#!/usr/bin/env bash
set -u

# Non-blocking verification: emits GitHub Actions warnings and exits 0.
# Verifies that vendored shared artifacts match the pinned tag in .loopwish/shared.ref.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REF_FILE="$ROOT_DIR/.loopwish/shared.ref"

warn() {
  # GitHub Actions annotation format (still readable locally)
  echo "::warning::$*"
}

if [[ ! -f "$REF_FILE" ]]; then
  warn "Missing .loopwish/shared.ref (expected single line tag, e.g. v0.1.0)"
  exit 0
fi

TAG="$(head -n 1 "$REF_FILE" | tr -d '\r' | xargs)"
if [[ -z "$TAG" ]]; then
  warn ".loopwish/shared.ref is empty"
  exit 0
fi

BASE_URL="https://raw.githubusercontent.com/loopwish/shared/${TAG}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

fetch() {
  local rel="$1"
  local out="$2"

  local url="${BASE_URL}/${rel}"
  if ! curl -fsSL "$url" -o "$out"; then
    warn "Could not fetch $url (tag missing or network issue)"
    return 1
  fi
  return 0
}

# Files to verify (v1 allowlist)
FILES=(
  "design-tokens/tokens.json"
  "assets/logos/loopwish-logo.svg"
  "assets/logos/loopwish-banner.svg"
)

for rel in "${FILES[@]}"; do
  local_path="$ROOT_DIR/vendor/shared/$rel"
  tmp_path="$TMP_DIR/$rel"
  mkdir -p "$(dirname "$tmp_path")"

  if [[ ! -f "$local_path" ]]; then
    warn "Missing vendored file: vendor/shared/$rel"
    continue
  fi

  if ! fetch "$rel" "$tmp_path"; then
    continue
  fi

  if ! diff -q "$local_path" "$tmp_path" >/dev/null 2>&1; then
    warn "Vendored file differs from shared@$TAG: vendor/shared/$rel"
  fi
done

exit 0
