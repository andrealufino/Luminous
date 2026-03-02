# Luminous — Architecture Reference

## Overview

Luminous is an iOS system information library written in Swift. It provides a unified, static API to query device and system data: hardware specs, battery, disk, network, locale, audio, and application metadata.

- **Version**: 3.0.0
- **Platform**: iOS 17+
- **Swift version**: 6.0 (strict concurrency)
- **Distribution**: Swift Package Manager
- **License**: MIT
- **Author**: Andrea Mario Lufino
- **Repository**: `https://github.com/andrealufino/Luminous`

---

## Module Structure

Single SPM module: `Luminous`. All source lives under `Sources/Luminous/` (9 files). One test target `LuminousTests` under `Tests/LuminousTests/`.

Architecture pattern: **hub-and-spoke**. `Luminous` is an `enum` (prevents instantiation) acting as a namespace. Each domain area is a nested struct in its own extension file. All API is `static` — no instantiation needed.

---

## File Map

| File | Nested Type | Purpose |
|------|-------------|---------|
| `Luminous.swift` | — | Root namespace enum (empty body) |
| `OperatingSystemVersion+Comparable.swift` | — | Retroactive `Equatable` + `Comparable` for `OperatingSystemVersion` |
| `Luminous+Application.swift` | `Luminous.Application` | App version and build number |
| `Luminous+Audio.swift` | `Luminous.Audio` | Audio volume, headphone detection |
| `Luminous+Battery.swift` | `Luminous.Battery` | Battery level (%) and state |
| `Luminous+Disk.swift` | `Luminous.Disk` | Total/free/used disk space via URL resource values |
| `Luminous+Hardware.swift` | `Luminous.Hardware` | CPU, RAM, OS version, thermal state, screen, device |
| `Luminous+Locale.swift` | `Luminous.Locale` | Language, timezone, country, currency, metric system |
| `Luminous+Network.swift` | `Luminous.Network` | WiFi/cellular/internet, expense/constraint/IP version flags |

---

## Type Hierarchy

```
Luminous (enum — namespace only, no cases)
├── Application (struct: Sendable)
│   version, build, completeAppVersion
├── Audio (struct: Sendable)
│   currentAudioOutputVolume, secondaryAudioShouldBeSilencedHint
│   isWiredHeadsetPluggedIn, isAnyHeadphoneConnected
├── Battery (@MainActor struct)
│   level, state
├── Disk (struct: Sendable)
│   totalSpaceInBytes, freeSpaceInBytes
│   totalSpace(in:), freeSpace(in:), usedSpace(in:)
├── Hardware (struct: Sendable)
│   processorsNumber, activeProcessorsNumber
│   physicalMemory(in:), availableMemoryInBytes, availableMemory(in:)
│   systemVersion, uptime, isLowPowerModeEnabled, thermalState, modelIdentifier
│   ├── Screen (@MainActor struct)
│   │   brightness, isScreenMirrored, nativeBounds, nativeScale
│   │   bounds, scale, maximumRefreshRate
│   └── Device (@MainActor struct)
│       identifierForVendor, orientation, systemName, userInterfaceStyle
├── Locale (struct: Sendable)
│   currentLanguage, currentTimeZone, currentTimeZoneName
│   currentCountry, currentCurrency, currentCurrencySymbol
│   usesMetricSystem, decimalSeparator
└── Network (struct)
    isConnectedViaWiFi, isConnectedViaCellular, isInternetAvailable
    isExpensive, isConstrained, supportsIPv4, supportsIPv6

OperatingSystemVersion (Foundation) — extended with @retroactive Equatable + Comparable
```

---

## Concurrency Model

| Domain | Isolation | Reason |
|--------|-----------|--------|
| `Application` | `nonisolated` | `Bundle` is thread-safe |
| `Audio` | `nonisolated` | `AVAudioSession` is thread-safe |
| `Battery` | `@MainActor` | `UIDevice` must run on main thread |
| `Disk` | `nonisolated` | `FileManager` / URL resource values are thread-safe |
| `Hardware` (root) | `nonisolated` | `ProcessInfo` is thread-safe |
| `Hardware.Screen` | `@MainActor` | `UIWindowScene`, `UIScreen` require main thread |
| `Hardware.Device` | `@MainActor` | `UIDevice` requires main thread |
| `Locale` | `nonisolated` | `Foundation.Locale` is thread-safe |
| `Network` | `nonisolated` + `@unchecked Sendable` | `NWPathMonitor` on dedicated queue, `NSLock` for internal state |

---

## Design Patterns

### Namespace enum + extension-per-domain

`Luminous` is an empty `enum` — it cannot be instantiated (unlike a struct where `init()` is implicitly available). Each domain lives in its own file as `extension Luminous { public struct Domain { ... } }`.

**Adding a new domain**: Create `Sources/Luminous/Luminous+NewDomain.swift` with `extension Luminous { public struct NewDomain { ... } }`.

### Static-only API

Every property and method on every nested struct is `static`. Consumers never hold references. Call sites look like:

```swift
let level = await Luminous.Battery.level          // @MainActor
let free  = Luminous.Disk.freeSpace(in: .gigabytes)
let wifi  = Luminous.Network.isConnectedViaWiFi
```

### Network: PathMonitor singleton

`NWPathMonitor` is started once on first access to `Luminous.Network`. A `DispatchSemaphore` blocks until the first path update arrives, so the very first read is always synchronous and accurate. Subsequent updates happen in the background on a dedicated utility queue.

### Disk: URL resource values

Disk space uses `URL.resourceValues(forKeys:)`:
- `.volumeTotalCapacityKey` for total capacity
- `.volumeAvailableCapacityForImportantUsageKey` for free space

The latter accounts for purgeable content and gives a more accurate picture of space available for important writes than the old `FileManager.attributesOfFileSystem` approach.

### Screen: UIWindowScene

`Hardware.Screen` queries the foreground-active `UIWindowScene` for all screen metrics, replacing the deprecated `UIScreen.main` accessors. Falls back to `UIScreen.main` when no scene is active (e.g. during background execution).

---

## Dependencies

### System frameworks

| Framework | Used by |
|-----------|---------|
| `Foundation` | All |
| `UIKit` | Battery, Hardware (Screen, Device) |
| `Network` | Network (NWPathMonitor) |
| `AVFoundation` | Audio |
| `Darwin` | Hardware (`os_proc_available_memory`, `uname`) |

No third-party dependencies.

---

## API Quick Reference

### Luminous.Application
| Property | Type | Notes |
|----------|------|-------|
| `version` | `String` | `CFBundleShortVersionString`; `""` if absent |
| `build` | `String` | `CFBundleVersion`; `""` if absent |
| `completeAppVersion` | `String` | `"2.1.3 (343)"` |

### Luminous.Audio
| Property | Type | Notes |
|----------|------|-------|
| `currentAudioOutputVolume` | `Float?` | 0.0–1.0; does not activate session |
| `secondaryAudioShouldBeSilencedHint` | `Bool` | Another app playing non-mixable audio |
| `isWiredHeadsetPluggedIn` | `Bool` | 3.5 mm / Lightning / USB-C only |
| `isAnyHeadphoneConnected` | `Bool` | Wired + all Bluetooth variants |

### Luminous.Battery (`@MainActor`)
| Property | Type | Notes |
|----------|------|-------|
| `level` | `Float?` | 0–100; `nil` if unavailable (Simulator) |
| `state` | `UIDevice.BatteryState` | `.unknown / .unplugged / .charging / .full` |

### Luminous.Disk
| Property/Method | Type | Notes |
|-----------------|------|-------|
| `totalSpaceInBytes` | `Int64` | Raw bytes |
| `freeSpaceInBytes` | `Int64` | Includes purgeable; raw bytes |
| `totalSpace(in:)` | `Double` | Default `.gigabytes` |
| `freeSpace(in:)` | `Double` | Default `.gigabytes` |
| `usedSpace(in:)` | `Double` | Default `.gigabytes` |

### Luminous.Hardware
| Property/Method | Type | Notes |
|-----------------|------|-------|
| `processorsNumber` | `Int` | |
| `activeProcessorsNumber` | `Int` | |
| `physicalMemory(in:)` | `Double` | Default `.gigabytes` |
| `availableMemoryInBytes` | `Int64` | `os_proc_available_memory()` |
| `availableMemory(in:)` | `Double` | Default `.megabytes` |
| `systemVersion` | `OperatingSystemVersion` | Comparable via retroactive extension |
| `uptime` | `TimeInterval` | Seconds since last boot |
| `isLowPowerModeEnabled` | `Bool` | |
| `thermalState` | `ProcessInfo.ThermalState` | `.nominal / .fair / .serious / .critical` |
| `modelIdentifier` | `String` | e.g. `"iPhone16,1"` via `utsname` |

### Luminous.Hardware.Screen (`@MainActor`)
| Property | Type | Notes |
|----------|------|-------|
| `brightness` | `Float` | 0.0–1.0 |
| `isScreenMirrored` | `Bool` | |
| `nativeBounds` | `CGRect` | Physical pixels |
| `nativeScale` | `Float` | |
| `bounds` | `CGRect` | Logical points |
| `scale` | `Float` | |
| `maximumRefreshRate` | `Int` | 60, 120, etc. |

### Luminous.Hardware.Device (`@MainActor`)
| Property | Type | Notes |
|----------|------|-------|
| `identifierForVendor` | `String?` | |
| `orientation` | `UIDeviceOrientation` | |
| `systemName` | `String` | e.g. `"iPhone OS"` |
| `userInterfaceStyle` | `UIUserInterfaceStyle` | `.light / .dark / .unspecified` |

### Luminous.Locale
| Property | Type | Notes |
|----------|------|-------|
| `currentLanguage` | `String?` | BCP 47 code, e.g. `"en"` |
| `currentTimeZone` | `TimeZone` | |
| `currentTimeZoneName` | `String` | IANA identifier |
| `currentCountry` | `String?` | ISO 3166-1, e.g. `"IT"` |
| `currentCurrency` | `String?` | ISO 4217, e.g. `"EUR"` |
| `currentCurrencySymbol` | `String?` | e.g. `"€"` |
| `usesMetricSystem` | `Bool` | Via `measurementSystem == .metric` |
| `decimalSeparator` | `String?` | `"."` or `","` |

### Luminous.Network
| Property | Type | Notes |
|----------|------|-------|
| `isConnectedViaWiFi` | `Bool` | |
| `isConnectedViaCellular` | `Bool` | |
| `isInternetAvailable` | `Bool` | `NWPath.status == .satisfied` |
| `isExpensive` | `Bool` | Cellular / personal hotspot |
| `isConstrained` | `Bool` | Low Data Mode |
| `supportsIPv4` | `Bool` | |
| `supportsIPv6` | `Bool` | |

---

## Breaking Changes from v2 → v3

| Removed | Replacement |
|---------|-------------|
| `Luminous.Carrier` (entire struct) | CTCarrier deprecated since iOS 16.1, no viable replacement |
| `Luminous.Hardware.Sensors` | Returns `true` on every device since 2014; removed entirely |
| `Luminous.Hardware.Accessory` | MFi-only, niche API passthrough; removed entirely |
| `Luminous.Network.SSID` | Dead on iOS 13+ without entitlement + location |
| `Luminous.Application.clipboardString` | Triggers iOS paste permission prompt as side-effect |
| `Luminous.Hardware.Screen.snapshotOfCurrentView` | Deprecated `UIScreen` API, no `@MainActor` safety |
| `BatteryState` enum | Use `UIDevice.BatteryState` directly |
| `MeasureUnit` enum | Use `UnitInformationStorage` from Foundation |
| `SystemVersion` struct | Use `OperatingSystemVersion` with the new `Comparable` extension |
| `Hardware.systemName` | Moved to `Hardware.Device.systemName` |
| `Hardware.bootTime` | Renamed to `Hardware.uptime` (was misleading) |
| `Disk.totalSpace` / `freeSpace` / `usedSpace` (String) | Deprecated since v2, now removed |
| `Disk.usedSpaceInBytes` | Deprecated since v2, now removed |
| `Disk.freeSpaceInPercentage` / `usedSpaceInPercentage` | Removed |
| `Disk.totalSpace(measureUnit:)` etc. | Replaced with `totalSpace(in: UnitInformationStorage)` |
| `Hardware.physicalMemory(with:)` | Replaced with `physicalMemory(in: UnitInformationStorage)` |

---

## Versioning & Branching

Git-flow model: `develop` → `release/X.Y.Z` → `master`. All releases are tagged on `master`.

Tag history: `0.40.x` → `0.50.x` → `1.0.x` → `1.10/1.11` → `2.0.0` → `2.1.x` → `2.2.0` → `3.0.0`.

---

## Known Issues

None.
