# GitHub Copilot Agent Instructions (Apple)

This repository contains the Loopwish Apple client.

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
