---
name: loopwish-apple-spm
description: Workflows for the Loopwish Apple client (Swift/SwiftUI + Swift Package Manager): run swift test, run SwiftLint strict, and organize changes by module.
---

# Loopwish Apple (Swift/SPM) Skill

Use this skill when working in the Loopwish **apple repository**.

## When to use

- Modifying SwiftUI views or app wiring.
- Changing shared domain logic in `Loopwish/Core`.
- Fixing SwiftLint or `swift test` failures.

## Key structure

- Core library: `Loopwish/Core`
- App entry: `Loopwish/App`
- Tests: `Loopwish/Tests`
- Package manifest: `Package.swift`

## Validation (matches CI)

From the repo root:

```bash
swift test
swiftlint --strict
```

If SwiftLint isn’t installed locally (macOS):

```bash
brew install swiftlint
```

## Typical workflow for a change

1. Keep domain logic in `Loopwish/Core` and UI logic in SwiftUI views.
2. Prefer small changes; update tests when behavior changes.
3. Run `swift test` and `swiftlint --strict` before opening a PR.

## Example prompts

- “Add a small pure function to `Loopwish/Core` and cover it with tests.”
- “Fix the SwiftLint strict violation without changing behavior.”
