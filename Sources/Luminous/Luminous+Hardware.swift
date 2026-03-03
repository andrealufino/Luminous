//
//  Luminous+Hardware.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation
import UIKit


// MARK: - Hardware

extension Luminous {

    /// Hardware information.
    ///
    /// Core properties are `nonisolated` — `ProcessInfo` is thread-safe.
    /// `Screen` and `Device` are `@MainActor` because they access UIKit APIs
    /// that must run on the main thread.
    public struct Hardware: Sendable {

        // MARK: Processors

        /// The total number of processors on the device.
        public static var processorsNumber: Int {
            ProcessInfo.processInfo.processorCount
        }

        /// The number of active processors on the device.
        public static var activeProcessorsNumber: Int {
            ProcessInfo.processInfo.activeProcessorCount
        }

        // MARK: Memory

        /// Physical RAM of the device converted to the given unit.
        ///
        /// Uses `UInt64` → `Double` arithmetic directly to avoid the precision
        /// loss caused by an intermediate `Float` conversion.
        ///
        /// - Parameter unit: The `UnitInformationStorage` to convert to.
        ///   Defaults to `.gigabytes`.
        ///
        /// - Note: Previously `physicalMemory(with: MeasureUnit)` in v2.
        public static func physicalMemory(in unit: UnitInformationStorage = .gigabytes) -> Double {
            let bytes = Double(ProcessInfo.processInfo.physicalMemory)
            return Measurement<UnitInformationStorage>(value: bytes, unit: .bytes)
                .converted(to: unit).value
        }

        /// Memory currently available to the process, in bytes.
        ///
        /// Uses `os_proc_available_memory()` from the `os` framework.
        /// Returns `0` if the value cannot be determined.
        public static var availableMemoryInBytes: Int64 {
            let raw = os_proc_available_memory()
            return raw > 0 ? Int64(raw) : 0
        }

        /// Memory currently available to the process, converted to the given unit.
        ///
        /// - Parameter unit: The `UnitInformationStorage` to convert to.
        ///   Defaults to `.megabytes`.
        public static func availableMemory(in unit: UnitInformationStorage = .megabytes) -> Double {
            Measurement<UnitInformationStorage>(value: Double(availableMemoryInBytes), unit: .bytes)
                .converted(to: unit).value
        }

        // MARK: System

        /// The OS version as an `OperatingSystemVersion` value.
        ///
        /// Use the `Comparable` extension to compare versions directly:
        /// ```swift
        /// let ios18 = OperatingSystemVersion(majorVersion: 18, minorVersion: 0, patchVersion: 0)
        /// if Luminous.Hardware.systemVersion >= ios18 { ... }
        /// ```
        ///
        /// - Note: Replaces the custom `SystemVersion` struct from v2.
        ///   Use `OperatingSystemVersion` with `>=`, `<`, `==` directly.
        public static var systemVersion: OperatingSystemVersion {
            ProcessInfo.processInfo.operatingSystemVersion
        }

        /// The elapsed time since the device last booted, in seconds.
        ///
        /// - Note: Previously `bootTime` in v2 (the name was misleading).
        public static var uptime: TimeInterval {
            ProcessInfo.processInfo.systemUptime
        }

        /// Whether Low Power Mode is currently enabled.
        public static var isLowPowerModeEnabled: Bool {
            ProcessInfo.processInfo.isLowPowerModeEnabled
        }

        /// The current thermal state of the device.
        ///
        /// Use `ProcessInfo.ThermalState` cases (`.nominal`, `.fair`, `.serious`,
        /// `.critical`) to react appropriately to thermal pressure.
        public static var thermalState: ProcessInfo.ThermalState {
            ProcessInfo.processInfo.thermalState
        }

        /// Whether the code is running in an iOS Simulator environment.
        ///
        /// Determined at compile time via `targetEnvironment(simulator)`.
        /// Always `false` on physical devices.
        public static var isSimulator: Bool {
            #if targetEnvironment(simulator)
            return true
            #else
            return false
            #endif
        }

        /// The hardware model identifier string (e.g. `"iPhone16,1"`).
        ///
        /// Obtained via `uname(2)`. Returns an empty string on failure.
        public static var modelIdentifier: String {
            var info = utsname()
            uname(&info)
            return withUnsafeBytes(of: &info.machine) { rawBuffer in
                let bytes = rawBuffer.bindMemory(to: CChar.self)
                return String(cString: bytes.baseAddress!)
            }
        }


        // MARK: - Screen

        /// Screen information.
        ///
        /// All properties are `@MainActor` and access the screen via the active
        /// `UIWindowScene`. Properties return safe defaults (`.zero`, `1`, `false`)
        /// when no foreground scene is available.
        @MainActor
        public struct Screen {

            /// The primary `UIWindowScene` that is currently in the foreground.
            ///
            /// Returns `nil` if no foreground-active scene is found (e.g. during
            /// background execution or before the first scene activation).
            private static var currentWindowScene: UIWindowScene? {
                UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .first { $0.activationState == .foregroundActive }
            }

            /// The current screen brightness (0.0–1.0).
            ///
            /// Returns `0` when called with no foreground-active scene (e.g. in background).
            public static var brightness: Float {
                Float(currentWindowScene?.screen.brightness ?? 0)
            }

            /// Whether the screen is currently being mirrored to another display.
            public static var isScreenMirrored: Bool {
                currentWindowScene?.screen.mirrored != nil
            }

            /// The bounding rectangle of the physical screen, in pixels.
            ///
            /// Returns `.zero` when no foreground-active scene is available.
            public static var nativeBounds: CGRect {
                currentWindowScene?.screen.nativeBounds ?? .zero
            }

            /// The scale factor of the physical screen.
            ///
            /// Returns `1` when no foreground-active scene is available.
            public static var nativeScale: Float {
                Float(currentWindowScene?.screen.nativeScale ?? 1)
            }

            /// The logical bounds of the screen, in points.
            ///
            /// Returns `.zero` when no foreground-active scene is available.
            public static var bounds: CGRect {
                currentWindowScene?.screen.bounds ?? .zero
            }

            /// The logical scale factor of the screen (e.g. 2.0 on Retina displays).
            ///
            /// Returns `1` when no foreground-active scene is available.
            public static var scale: Float {
                Float(currentWindowScene?.screen.scale ?? 1)
            }

            /// The maximum refresh rate of the screen in frames per second.
            ///
            /// Returns `60` as a fallback when no foreground scene is available.
            public static var maximumRefreshRate: Int {
                currentWindowScene?.screen.maximumFramesPerSecond ?? 60
            }

            /// Whether Display Zoom is currently active.
            ///
            /// Display Zoom renders content at a lower logical resolution so that
            /// elements appear larger. When active, `nativeScale` differs from
            /// `scale` on the underlying `UIScreen`.
            ///
            /// Returns `false` when no foreground-active scene is available.
            public static var isZoomed: Bool {
                guard let screen = currentWindowScene?.screen else { return false }
                return screen.nativeScale != screen.scale
            }
        }


        // MARK: - Device

        /// Device information.
        ///
        /// All properties are `@MainActor` because they read from `UIDevice.current`.
        @MainActor
        public struct Device {

            /// The vendor-assigned UUID string for this device.
            ///
            /// Returns `nil` when the device has been recently restarted and not
            /// yet unlocked.
            public static var identifierForVendor: String? {
                UIDevice.current.identifierForVendor?.uuidString
            }

            /// The current device orientation.
            public static var orientation: UIDeviceOrientation {
                UIDevice.current.orientation
            }

            /// The name of the operating system (e.g. `"iPhone OS"`).
            ///
            /// - Note: Previously `Hardware.systemName` in v2. Moved to
            ///   `Hardware.Device.systemName` in v3.
            public static var systemName: String {
                UIDevice.current.systemName
            }

            /// The name of the device as set by the user (e.g. `"Andrea's iPhone"`).
            ///
            /// Reads `UIDevice.current.name`. Useful for diagnostics and support screens.
            public static var name: String {
                UIDevice.current.name
            }

            /// The current user interface style (light, dark, or unspecified).
            public static var userInterfaceStyle: UIUserInterfaceStyle {
                UITraitCollection.current.userInterfaceStyle
            }
        }
    }
}
