# Luminous — Claude Code Instructions

## Project Identity

**Luminous** is a personal iOS Swift Package by Andrea Mario Lufino. It is a system information helper library providing a unified static API for querying device/system data (hardware, battery, disk, network, locale, carrier, audio, app metadata).

- Version: 2.2.0
- Platform: iOS 12+, Swift 5 (swift-tools-version 5.3)
- Distribution: SPM + CocoaPods
- Current branch: `develop` (git-flow model: develop → release/X.Y.Z → master)

## Architecture Reference

See `docs/architecture.md` for the full reference — type hierarchy, API tables, design patterns, file map, and known issues. Read that before making any changes.

## Project Structure

```
Sources/Luminous/         10 source files — the entire library
Tests/LuminousTests/      7 real tests (all passing)
Example/                  CocoaPods example UIKit app (slightly outdated)
docs/                     Architecture and reference documentation
Luminous.podspec          CocoaPods spec
Package.swift             SPM manifest (platforms: iOS 12+, no external dependencies)
```

## Design Conventions

This library has established conventions — match them exactly:

- **Namespace struct pattern**: all public API lives as `static` properties/methods on nested structs under `Luminous`. No instances, no state.
- **Extension-per-domain**: each domain is `extension Luminous { public struct Domain { ... } }` in its own `Luminous+Domain.swift` file.
- **Value types only**: use `struct` for any new types. The only class is the vendored `Reachability.swift`.
- **No protocols**: the library defines zero protocols. Don't introduce them without a compelling reason.
- **No ViewModels, no Combine, no async/await**: this is a pure data-access library with synchronous (or simple async) reads. Respect that.
- **`MeasureUnit` for size values**: disk and memory values take a `MeasureUnit` parameter — follow that pattern for any new size-based API.
- **Deprecate, don't remove**: when changing an API, use `@available(*, deprecated, renamed:)` first. See existing disk/carrier deprecations as examples.

## Dependencies

- No external SPM dependencies.
- **Reachability.swift**: vendored third-party file (Ashley Mills, BSD license). Used internally by `Luminous.Network`. Candidate for replacement with `NWPathMonitor` (API phase).

## Adding a New Domain

1. Create `Sources/Luminous/Luminous+NewDomain.swift`
2. Add the standard file header
3. `import` only the frameworks actually needed
4. Write `extension Luminous { public struct NewDomain { ... } }` with all-`static` properties
5. Update `docs/architecture.md` with the new type

## Known State

- Example app won't compile as-is (references removed `Device.current` from Deviice)
- Several API-level issues remain (see `docs/architecture.md` → Known Issues)

## Build & Test

`swift build` doesn't work — UIKit makes this iOS-only. Use xcodebuild:

```bash
# Build
xcodebuild -workspace . -scheme Luminous build \
  -destination 'platform=iOS Simulator,id=<SIM_UUID>'

# Test
xcodebuild -workspace . -scheme Luminous test \
  -destination 'platform=iOS Simulator,id=<SIM_UUID>'
```

Use `mcp__XcodeBuildMCP__build_sim` / `test_sim` when working within an app context that imports Luminous.
