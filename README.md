# Luminous

![Luminous](./luminous.png)

A Swift library that gives you quick access to system information on iOS.

![iOS](https://img.shields.io/badge/iOS-17%2B-blue) ![Swift](https://img.shields.io/badge/Swift-6.0-orange) ![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen) ![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## Requirements

- iOS 17+
- Swift 6.0
- Xcode 16+

---

## Installation

### Swift Package Manager

In Xcode: **File → Add Package Dependencies**, then enter:

```
https://github.com/andrealufino/Luminous
```

Or add it directly to `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/andrealufino/Luminous", from: "3.0.0")
]
```

---

## Usage

All API is accessed through static properties and methods on nested structs under the `Luminous` namespace. No instantiation needed.

```swift
import Luminous

// Disk
let free = Luminous.Disk.freeSpace(in: .gigabytes)
let total = Luminous.Disk.totalSpaceInBytes

// Network
if Luminous.Network.isInternetAvailable {
    let expensive = Luminous.Network.isExpensive  // true on cellular/hotspot
}

// Hardware
let cores = Luminous.Hardware.processorsNumber
let model = Luminous.Hardware.modelIdentifier   // e.g. "iPhone16,1"
let thermal = Luminous.Hardware.thermalState    // ProcessInfo.ThermalState

// OS version comparison
let current = Luminous.Hardware.systemVersion
let ios18 = OperatingSystemVersion(majorVersion: 18, minorVersion: 0, patchVersion: 0)
if current >= ios18 { ... }

// Battery — requires @MainActor
let level = await MainActor.run { Luminous.Battery.level }   // Float? (0–100)
let state = await MainActor.run { Luminous.Battery.state }   // UIDevice.BatteryState
```

### `@MainActor` properties

`Battery`, `Hardware.Screen`, and `Hardware.Device` access UIKit APIs and must be called on the main actor:

```swift
// In a @MainActor context (e.g. a SwiftUI view or view controller):
let brightness = Luminous.Hardware.Screen.brightness
let style = Luminous.Hardware.Device.userInterfaceStyle  // .light / .dark

// From a non-isolated context:
let brightness = await MainActor.run { Luminous.Hardware.Screen.brightness }
```

---

## API Reference

### `Luminous.Application`

| Property | Type | Description |
|----------|------|-------------|
| `version` | `String` | `CFBundleShortVersionString` (e.g. `"3.0.0"`); `""` if absent |
| `build` | `String` | `CFBundleVersion` (e.g. `"42"`); `""` if absent |
| `completeAppVersion` | `String` | `"3.0.0 (42)"` |

### `Luminous.Audio`

| Property | Type | Description |
|----------|------|-------------|
| `currentAudioOutputVolume` | `Float?` | 0.0–1.0; does not activate the audio session |
| `secondaryAudioShouldBeSilencedHint` | `Bool` | Another app is playing non-mixable audio |
| `isWiredHeadsetPluggedIn` | `Bool` | 3.5 mm / Lightning / USB-C wired headset |
| `isAnyHeadphoneConnected` | `Bool` | Wired, AirPods, or any Bluetooth audio device |

### `Luminous.Battery` — `@MainActor`

| Property | Type | Description |
|----------|------|-------------|
| `level` | `Float?` | 0–100; `nil` in Simulator |
| `state` | `UIDevice.BatteryState` | `.unknown` / `.unplugged` / `.charging` / `.full` |

### `Luminous.Disk`

All size methods accept a `UnitInformationStorage` parameter (default: `.gigabytes`).

| Property / Method | Type | Description |
|-------------------|------|-------------|
| `totalSpaceInBytes` | `Int64` | Raw total capacity |
| `freeSpaceInBytes` | `Int64` | Available space including purgeable content |
| `totalSpace(in:)` | `Double` | Total capacity in the given unit |
| `freeSpace(in:)` | `Double` | Free space in the given unit |
| `usedSpace(in:)` | `Double` | Used space in the given unit |

```swift
let gb = Luminous.Disk.freeSpace(in: .gigabytes)
let mb = Luminous.Disk.usedSpace(in: .megabytes)
```

### `Luminous.Hardware`

| Property / Method | Type | Description |
|-------------------|------|-------------|
| `processorsNumber` | `Int` | Total processor count |
| `activeProcessorsNumber` | `Int` | Active processor count |
| `physicalMemory(in:)` | `Double` | Physical RAM in the given unit (default `.gigabytes`) |
| `availableMemoryInBytes` | `Int64` | Memory available to the process |
| `availableMemory(in:)` | `Double` | Available memory in the given unit (default `.megabytes`) |
| `systemVersion` | `OperatingSystemVersion` | Comparable — use `>=`, `<`, etc. |
| `uptime` | `TimeInterval` | Seconds since last boot |
| `isLowPowerModeEnabled` | `Bool` | |
| `thermalState` | `ProcessInfo.ThermalState` | `.nominal` / `.fair` / `.serious` / `.critical` |
| `modelIdentifier` | `String` | Hardware model string (e.g. `"iPhone16,1"`) |

### `Luminous.Hardware.Screen` — `@MainActor`

| Property | Type | Description |
|----------|------|-------------|
| `brightness` | `Float` | 0.0–1.0 |
| `isScreenMirrored` | `Bool` | |
| `nativeBounds` | `CGRect` | Physical screen bounds in pixels |
| `nativeScale` | `Float` | Physical screen scale |
| `bounds` | `CGRect` | Logical screen bounds in points |
| `scale` | `Float` | Logical screen scale |
| `maximumRefreshRate` | `Int` | 60, 120, etc. |

### `Luminous.Hardware.Device` — `@MainActor`

| Property | Type | Description |
|----------|------|-------------|
| `identifierForVendor` | `String?` | Vendor UUID |
| `orientation` | `UIDeviceOrientation` | Current device orientation |
| `systemName` | `String` | OS name (e.g. `"iPhone OS"`) |
| `userInterfaceStyle` | `UIUserInterfaceStyle` | `.light` / `.dark` / `.unspecified` |

### `Luminous.Locale`

| Property | Type | Description |
|----------|------|-------------|
| `currentLanguage` | `String?` | BCP 47 code (e.g. `"en"`, `"it"`) |
| `currentTimeZone` | `TimeZone` | Current time zone |
| `currentTimeZoneName` | `String` | IANA identifier (e.g. `"Europe/Rome"`) |
| `currentCountry` | `String?` | ISO 3166-1 (e.g. `"US"`, `"IT"`) |
| `currentCurrency` | `String?` | ISO 4217 (e.g. `"USD"`, `"EUR"`) |
| `currentCurrencySymbol` | `String?` | e.g. `"$"`, `"€"` |
| `usesMetricSystem` | `Bool` | |
| `decimalSeparator` | `String?` | `"."` or `","` |

### `Luminous.Network`

| Property | Type | Description |
|----------|------|-------------|
| `isConnectedViaWiFi` | `Bool` | |
| `isConnectedViaCellular` | `Bool` | |
| `isInternetAvailable` | `Bool` | Any satisfied path |
| `isExpensive` | `Bool` | Cellular or personal hotspot |
| `isConstrained` | `Bool` | Low Data Mode is active |
| `supportsIPv4` | `Bool` | |
| `supportsIPv6` | `Bool` | |

### `OperatingSystemVersion` — `Comparable`

Luminous adds retroactive `Equatable` and `Comparable` conformance to Foundation's `OperatingSystemVersion`, enabling direct comparison operators:

```swift
let current = Luminous.Hardware.systemVersion
let ios18 = OperatingSystemVersion(majorVersion: 18, minorVersion: 0, patchVersion: 0)

if current >= ios18 {
    // iOS 18+ code path
}
```

---

## Author

[Andrea Mario Lufino](https://andrealufino.com)

## License

Luminous is available under the MIT license. See the [LICENSE](LICENSE) file for details.
