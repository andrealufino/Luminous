# Luminous — Architecture Reference

## Overview

Luminous is an iOS system information library written in Swift. It provides a unified, static API to query device and system data: hardware specs, battery, disk, network, locale, carrier, audio, and application metadata.

- **Version**: 2.2.0
- **Platform**: iOS 12+
- **Swift version**: 5.0 (swift-tools-version 5.3)
- **Distribution**: Swift Package Manager + CocoaPods
- **License**: MIT
- **Author**: Andrea Mario Lufino
- **Repository**: `https://github.com/andrealufino/Luminous`

---

## Module Structure

Single SPM module: `Luminous`. All source lives under `Sources/Luminous/` (10 files). One test target `LuminousTests` under `Tests/LuminousTests/`.

Architecture pattern: **hub-and-spoke**. The `Luminous` struct acts as a namespace. Each domain area is a nested struct in its own extension file. All API is `static` — no instantiation needed.

---

## File Map

| File | Nested Type | Purpose |
|------|-------------|---------|
| `Luminous.swift` | — | Root namespace struct, `BatteryState` enum, `MeasureUnit` enum |
| `Luminous+Application.swift` | `Luminous.Application` | App version, build number, clipboard |
| `Luminous+Audio.swift` | `Luminous.Audio` | Audio output volume, secondary audio hint |
| `Luminous+Battery.swift` | `Luminous.Battery` | Battery level (%) and state |
| `Luminous+Carrier.swift` | `Luminous.Carrier` | Carrier name, MCC, MNC, VoIP support |
| `Luminous+Disk.swift` | `Luminous.Disk` | Total/free/used disk space in configurable units |
| `Luminous+Hardware.swift` | `Luminous.Hardware` + `Luminous.SystemVersion` | CPU, RAM, OS version, screen, device ID, accessories, sensors |
| `Luminous+Locale.swift` | `Luminous.Locale` | Language, timezone, country, currency, metric system |
| `Luminous+Network.swift` | `Luminous.Network` | WiFi/cellular/internet reachability, SSID |
| `Reachability.swift` | `Reachability` | Vendored third-party class (Ashley Mills, BSD) for `SCNetworkReachability` |

---

## Type Hierarchy

```
Luminous (struct — namespace only)
├── BatteryState (enum)          .unknown | .unplugged | .charging | .full
├── MeasureUnit (enum)           .bytes | .kilobytes | .megabytes | .gigabytes | .percentage
├── SystemVersion (struct)       Equatable, Comparable — parses "major.minor.patch"
├── Application (struct)         version, build, completeAppVersion, clipboardString
├── Audio (struct)               currentAudioOutputVolume, secondaryAudioShouldBeSilencedHint
├── Battery (struct)             level, state
├── Carrier (struct)             name, ISOCountryCode, mobileCountryCode, mobileNetworkCode, isVoipAllowed
├── Disk (struct)                totalSpaceInBytes, freeSpaceInBytes, totalSpace(measureUnit:), freeSpace(measureUnit:), usedSpace(measureUnit:)
├── Hardware (struct)
│   ├── processorsNumber, activeProcessorsNumber
│   ├── physicalMemory(with:), systemName, systemVersion, bootTime, isLowPowerModeEnabled
│   ├── Screen (struct)          brightness, isScreenMirrored, nativeBounds, nativeScale, bounds, scale, snapshotOfCurrentView
│   ├── Device (struct)          identifierForVendor, orientation
│   ├── Accessory (struct)       count, connectedAccessoriesNames, connectedAccessories, isHeadsetPluggedIn
│   └── Sensors (struct)         isAccelerometerAvailable, isGyroAvailable, isMagnetometerAvailable, isDeviceMotionAvailable
├── Locale (struct)              currentLanguage, currentTimeZone, currentTimeZoneName, currentCountry, currentCurrency, currentCurrencySymbol, usesMetricSystem, decimalSeparator
└── Network (struct)             isConnectedViaWiFi, isConnectedViaCellular, isInternetAvailable, SSID

Reachability (class — standalone, not nested under Luminous)
├── NetworkStatus (enum)         .notReachable | .reachableViaWiFi | .reachableViaWWAN
└── ReachabilityError (enum)     failure cases for setup
```

---

## Design Patterns

### Namespace struct + extension-per-domain

`Luminous` is never instantiated. Each domain lives in its own file as `extension Luminous { public struct Domain { ... } }`. This keeps the codebase modular while maintaining a single coherent namespace.

**Adding a new domain**: Create `Sources/Luminous/Luminous+NewDomain.swift` with `extension Luminous { public struct NewDomain { ... } }`.

### Static-only API

Every property and method on every nested struct is `static`. Consumers never hold references. Call sites look like:

```swift
let level = Luminous.Battery.level
let free = Luminous.Disk.freeSpace(measureUnit: .gigabytes)
let brightness = Luminous.Hardware.Screen.brightness
```

### Value types throughout

All Luminous-defined types are structs. The only class is the vendored `Reachability`.

### No protocols, no delegation, no generics

The library defines zero protocols. It is a pure data-access layer with no callbacks or observation patterns of its own (Reachability has its own notification/callback system internally, but that is not part of the public Luminous API).

### Deprecated API migration pattern

Older string-returning disk properties (`totalSpace`, `freeSpace`, `usedSpace`) are marked `@available(*, deprecated)` in favour of the `measureUnit:`-based methods. Same pattern used for `Carrier.networkCountryCode` → `mobileNetworkCode`.

---

## Dependencies

### Deviice

Removed as of this cleanup. Was used by `Luminous.Hardware.Device.current` (dropped in v2.2.0), then lingered in `Package.swift` and `Luminous.podspec` as dead weight. Fully removed now — consumers who need device identification should add Deviice directly to their project.

### Reachability (vendored, BSD license)

- `Sources/Luminous/Reachability.swift` — Ashley Mills' `SCNetworkReachability` wrapper
- Embedded directly in the source rather than as a dependency
- Used only by `Luminous.Network` internally

### System frameworks

| Framework | Used by |
|-----------|---------|
| `Foundation` | All |
| `UIKit` | Battery, Hardware (Screen, Device), Application, Disk |
| `AVFoundation` | Audio, Hardware.Accessory (headphone detection) |
| `CoreTelephony` | Carrier |
| `CoreMotion` | Hardware.Sensors |
| `ExternalAccessory` | Hardware.Accessory |
| `SystemConfiguration` / `CaptiveNetwork` | Network (Reachability, SSID) |

---

## API Quick Reference

### Luminous.Application
| Property | Type | Notes |
|----------|------|-------|
| `version` | `String` | `CFBundleShortVersionString` |
| `build` | `String` | `CFBundleVersion` |
| `completeAppVersion` | `String` | `"2.1.3 (343)"` |
| `clipboardString` | `String?` | Current UIPasteboard string |

### Luminous.Audio
| Property | Type | Notes |
|----------|------|-------|
| `currentAudioOutputVolume` | `Double?` | 0.0–1.0 via AVAudioSession |
| `secondaryAudioShouldBeSilencedHint` | `Bool` | Another app playing non-mixable audio |

### Luminous.Battery
| Property | Type | Notes |
|----------|------|-------|
| `level` | `Float?` | 0–100, nil if unavailable |
| `state` | `BatteryState` | Maps UIDevice.batteryState |

### Luminous.Carrier
| Property | Type | Notes |
|----------|------|-------|
| `name` | `String?` | |
| `ISOCountryCode` | `String?` | |
| `mobileCountryCode` | `String?` | MCC |
| `mobileNetworkCode` | `String?` | MNC |
| `isVoipAllowed` | `Bool?` | |
| `networkCountryCode` | `String?` | Deprecated → use `mobileNetworkCode` |

### Luminous.Disk
| Property/Method | Type | Notes |
|-----------------|------|-------|
| `totalSpaceInBytes` | `Int64` | |
| `freeSpaceInBytes` | `Int64` | |
| `totalSpace(measureUnit:)` | `Double` | Preferred |
| `freeSpace(measureUnit:)` | `Double` | Preferred |
| `usedSpace(measureUnit:)` | `Double` | Preferred |
| `usedSpaceInPercentage` | `Float` | |
| `totalSpace`, `freeSpace`, `usedSpace` | `String` | Deprecated formatted strings |

### Luminous.Hardware
| Property/Method | Type | Notes |
|-----------------|------|-------|
| `processorsNumber` | `Int` | |
| `activeProcessorsNumber` | `Int` | |
| `physicalMemory(with:)` | `Double` | Pass `MeasureUnit` |
| `systemName` | `String` | e.g. "iOS" |
| `systemVersion` | `SystemVersion` | Comparable value type |
| `bootTime` | `TimeInterval` | Seconds since boot |
| `isLowPowerModeEnabled` | `Bool` | |

### Luminous.Hardware.Screen
| Property | Type |
|----------|------|
| `brightness` | `Float` |
| `isScreenMirrored` | `Bool` |
| `nativeBounds` | `CGRect` |
| `nativeScale` | `Float` |
| `bounds` | `CGRect` |
| `scale` | `Float` |
| `snapshotOfCurrentView` | `UIView` |

### Luminous.Hardware.Device
| Property | Type |
|----------|------|
| `identifierForVendor` | `String?` |
| `orientation` | `UIDeviceOrientation` |

### Luminous.Hardware.Accessory
| Property | Type |
|----------|------|
| `count` | `Int` |
| `connectedAccessoriesNames` | `[String]` |
| `connectedAccessories` | `[EAAccessory]` |
| `isHeadsetPluggedIn` | `Bool` |

### Luminous.Hardware.Sensors
| Property | Type |
|----------|------|
| `isAccelerometerAvailable` | `Bool` |
| `isGyroAvailable` | `Bool` |
| `isMagnetometerAvailable` | `Bool` |
| `isDeviceMotionAvailable` | `Bool` |

### Luminous.Locale
| Property | Type |
|----------|------|
| `currentLanguage` | `String?` |
| `currentTimeZone` | `TimeZone` |
| `currentTimeZoneName` | `String` |
| `currentCountry` | `String?` |
| `currentCurrency` | `String?` |
| `currentCurrencySymbol` | `String?` |
| `usesMetricSystem` | `Bool` |
| `decimalSeparator` | `String?` |

### Luminous.Network
| Property | Type | Notes |
|----------|------|-------|
| `isConnectedViaWiFi` | `Bool` | Via Reachability |
| `isConnectedViaCellular` | `Bool` | `!isConnectedViaWiFi` |
| `isInternetAvailable` | `Bool` | Via Reachability |
| `SSID` | `String` | Deprecated on iOS 13+; requires entitlement |

### Luminous.SystemVersion
Value type, `Equatable`, `Comparable`. Properties: `major: Int`, `minor: Int`, `patch: Int`, `stringValue: String`. Useful for comparing OS versions at runtime.

---

## Versioning & Branching

Git-flow model: `develop` → `release/X.Y.Z` → `master`. All releases are tagged on `master`. Current branch is `develop`.

Tag history: `0.40.x` → `0.50.x` → `1.0.x` → `1.10/1.11` → `2.0.0` → `2.1.x` → `2.2.0`.

---

## Known Issues / Technical Debt

### Resolved (this cleanup)
- Tests now compile and pass (7/7)
- Deviice dependency removed from `Package.swift` and `Luminous.podspec`
- `platforms: [.iOS(.v12)]` added to `Package.swift`
- `.travis.yml` deleted (was targeting Xcode 7.3)
- Linux test scaffolding (`XCTestManifests.swift`, `LinuxMain.swift`) deleted

### Remaining (API phase)
| Issue | Location | Severity |
|-------|----------|---------|
| `isConnectedViaCellular` is just `!isConnectedViaWiFi` — imprecise | `Luminous+Network.swift` | Medium |
| `Reachability.swift` is vendored — migrate to `NWPathMonitor` | `Sources/Luminous/Reachability.swift` | Medium |
| `Carrier` uses `subscriberCellularProvider` deprecated on iOS 16 | `Luminous+Carrier.swift` | Medium |
| `SSID` uses `CNCopySupportedInterfaces` deprecated on iOS 13 | `Luminous+Network.swift` | Low |
| `SystemVersion` uses `fatalError` for invalid version strings | `Luminous+Hardware.swift` | Low |
| Several `force-unwrap` in disk and app info | `Luminous+Disk.swift`, `Luminous+Application.swift` | Low |
| Example app references removed `Device.current` | `Example/Luminous/ViewController.swift` | Low |
