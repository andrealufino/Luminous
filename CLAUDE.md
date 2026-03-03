# Luminous — Claude Code Instructions

## Project Identity

**Luminous** is a personal iOS Swift Package by Andrea Mario Lufino. It is a system information helper library providing a unified static API for querying device/system data (hardware, battery, disk, network, locale, audio, app metadata).

- Version: 3.0.0
- Platform: iOS 17+, Swift 6 (swift-tools-version 6.0, `.swiftLanguageMode(.v6)`)
- Distribution: Swift Package Manager only
- Current branch: `develop` (git-flow model: develop → release/X.Y.Z → master)

## Architecture Reference

See `docs/architecture.md` for the full reference — type hierarchy, API tables, design patterns, file map, and breaking changes from v2. Read that before making any changes.

## Project Structure

```
Sources/Luminous/         9 source files — the entire library
Tests/LuminousTests/      32 tests (all passing, zero warnings)
docs/                     Architecture and reference documentation
Package.swift             SPM manifest (iOS 17, swift-tools-version 6.0, no external deps)
```

## Design Conventions

Match these exactly when making changes:

- **Namespace enum pattern**: `Luminous` is an empty `enum` (not struct) — prevents instantiation.
- **Extension-per-domain**: each domain is `extension Luminous { public struct Domain { ... } }` in `Luminous+Domain.swift`.
- **Static-only API**: all properties/methods are `static`. No instances, no stored state (except `Network.monitor`).
- **Swift 6 concurrency**: structs that don't touch UIKit are `Sendable`; UIKit-dependent ones are `@MainActor`. See `docs/architecture.md` for the full concurrency table.
- **`UnitInformationStorage` for size values**: disk and memory parameters use `UnitInformationStorage` (not custom enums).
- **`OperatingSystemVersion` for OS versions**: use `ProcessInfo.processInfo.operatingSystemVersion` and the `Comparable` extension in `OperatingSystemVersion+Comparable.swift`.
- **No protocols**: the library defines zero protocols.
- **No ViewModels, no Combine**: pure synchronous data-access library.
- **Breaking changes allowed**: v3 is a major version; deprecated v2 APIs have been removed.

## Dependencies

No external SPM dependencies.

## Adding a New Domain

1. Create `Sources/Luminous/Luminous+NewDomain.swift`
2. Add the standard Xcode file header
3. `import` only the frameworks actually needed
4. `extension Luminous { public struct NewDomain: Sendable { ... } }` with all-`static` properties
5. Add `@MainActor` to the struct if it requires UIKit
6. Update `docs/architecture.md` with the new type and API table

## Known State

- `OperatingSystemVersion` has both `@retroactive Equatable` and `@retroactive Comparable` — both are needed for Swift 6 (synthesis doesn't work in retroactive cross-module extensions)
- `Hardware.Screen` returns safe defaults (`.zero`, `1`, `false`, `60`) when no foreground-active `UIWindowScene` is available

## Build & Test

`swift build` fails — UIKit is iOS-only. Use xcodebuild via XcodeBuildMCP:

```
mcp__XcodeBuildMCP__test_sim
```

Or raw xcodebuild:

```bash
xcodebuild -workspace .swiftpm/xcode/package.xcworkspace \
  -scheme Luminous test \
  -destination 'platform=iOS Simulator,id=<SIM_UUID>'
```

Session defaults are already configured (`workspacePath`, `scheme`, `simulatorId`).
