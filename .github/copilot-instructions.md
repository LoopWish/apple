# GitHub Copilot Agent Instructions (Apple)

This repository contains the Loopwish Apple client.

## Organization-wide standards (Loopwish)

- Keep PRs small and reviewable; avoid drive-by refactors.
- Do not commit secrets (API keys, tokens, credentials) or `.env` files.
- Prefer secure-by-default changes; avoid logging sensitive data.
- Update docs and tests when behavior changes.
- Keep CI green and run the repo’s validation commands before opening a PR.
- Follow the existing code style and architecture; copy patterns already used in the repo.

## Stack

- Swift, SwiftUI
- Swift Package Manager (SPM)
- Platforms: iOS 16+, iPadOS 16+, macOS 13+
- Lint: SwiftLint

## Goals

- Prefer small, reviewable PRs.
- Keep the codebase buildable and tests passing.
- Follow established folder boundaries: `Loopwish/App`, `Loopwish/Features`, `Loopwish/Core`, `Loopwish/Resources`, `Loopwish/Tests`.

## Coding conventions

- Use Swift concurrency responsibly (`async/await`) and avoid blocking the main thread.
- Keep UI logic in SwiftUI views and domain logic in `Loopwish/Core`.
- Avoid introducing new dependencies unless required; prefer standard library and Apple frameworks.

## Validation

Before opening a PR, run:

```bash
swift test
swiftlint --strict
```

## Safety

- Never commit secrets, tokens, or API keys.
- Do not add user tracking/analytics unless explicitly requested.
