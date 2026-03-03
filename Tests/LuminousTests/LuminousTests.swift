//
//  LuminousTests.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 20/10/16.
//

import Foundation
import XCTest
@testable import Luminous

final class LuminousTests: XCTestCase {


    // MARK: - Application

    func testApplicationVersionAndBuildReturnStrings() {
        // In a test target Bundle.main lacks Info.plist keys — must return "" not crash
        let version: String = Luminous.Application.version
        let build: String = Luminous.Application.build
        // Both are non-optional String — compile-time guarantee. Verify they don't crash.
        _ = version
        _ = build
    }

    func testApplicationCompleteVersionContainsBrackets() {
        let complete = Luminous.Application.completeAppVersion
        // Format is "\(version) (\(build))" — must contain a space and parentheses
        XCTAssertTrue(complete.contains("("), "completeAppVersion should contain opening parenthesis")
        XCTAssertTrue(complete.contains(")"), "completeAppVersion should contain closing parenthesis")
    }

    func testApplicationBundleIdentifierDoesNotCrash() {
        // May be nil in a test target without a bundle identifier; just must not crash
        _ = Luminous.Application.bundleIdentifier
    }

    func testApplicationDisplayNameDoesNotCrash() {
        // Returns "" in test targets that have no CFBundleDisplayName/CFBundleName
        _ = Luminous.Application.displayName
    }


    // MARK: - Audio

    func testAudioVolumeIsNilOrInRange() {
        if let volume = Luminous.Audio.currentAudioOutputVolume {
            XCTAssertGreaterThanOrEqual(volume, 0)
            XCTAssertLessThanOrEqual(volume, 1)
        }
    }

    func testAudioPropertiesDoNotCrash() {
        _ = Luminous.Audio.isWiredHeadsetPluggedIn
        _ = Luminous.Audio.isAnyHeadphoneConnected
        _ = Luminous.Audio.secondaryAudioShouldBeSilencedHint
    }


    // MARK: - Battery

    @MainActor
    func testBatteryStateDoesNotCrash() {
        _ = Luminous.Battery.state
    }

    @MainActor
    func testBatteryIsChargingDoesNotCrash() {
        _ = Luminous.Battery.isCharging
    }

    @MainActor
    func testBatteryLevelIsNilOrInRange() {
        if let level = Luminous.Battery.level {
            XCTAssertGreaterThanOrEqual(level, 0, "Battery level must be >= 0")
            XCTAssertLessThanOrEqual(level, 100, "Battery level must be <= 100")
        }
        // nil is valid in Simulator where battery monitoring is unavailable
    }


    // MARK: - Disk

    func testDiskTotalSpaceInBytesIsPositive() {
        XCTAssertGreaterThan(Luminous.Disk.totalSpaceInBytes, 0)
    }

    func testDiskUsedSpaceInBytesIsNonNegativeAndSmallerThanTotal() {
        let used = Luminous.Disk.usedSpaceInBytes
        let total = Luminous.Disk.totalSpaceInBytes
        XCTAssertGreaterThanOrEqual(used, 0)
        XCTAssertLessThanOrEqual(used, total)
    }

    func testDiskFreeSpaceIsNonNegativeAndSmallerThanTotal() {
        let free = Luminous.Disk.freeSpaceInBytes
        let total = Luminous.Disk.totalSpaceInBytes
        XCTAssertGreaterThanOrEqual(free, 0)
        XCTAssertLessThanOrEqual(free, total)
    }

    func testDiskTotalSpaceInGigabytesIsPositive() {
        XCTAssertGreaterThan(Luminous.Disk.totalSpace(in: .gigabytes), 0)
    }

    func testDiskFreeSpaceInMegabytesIsNonNegative() {
        XCTAssertGreaterThanOrEqual(Luminous.Disk.freeSpace(in: .megabytes), 0)
    }

    func testDiskUsedPlusFreeEqualsTotalWithinTolerance() {
        let used = Luminous.Disk.usedSpace(in: .bytes)
        let free = Luminous.Disk.freeSpace(in: .bytes)
        let total = Luminous.Disk.totalSpace(in: .bytes)
        // Allow 1 MB tolerance for rounding in Measurement conversion
        XCTAssertEqual(used + free, total, accuracy: 1_048_576)
    }


    // MARK: - Hardware

    func testHardwareProcessorCounts() {
        XCTAssertGreaterThan(Luminous.Hardware.processorsNumber, 0)
        XCTAssertGreaterThan(Luminous.Hardware.activeProcessorsNumber, 0)
    }

    func testHardwarePhysicalMemoryIsPositive() {
        XCTAssertGreaterThan(Luminous.Hardware.physicalMemory(in: .gigabytes), 0)
    }

    func testHardwareSystemVersionHasReasonableMajor() {
        let v = Luminous.Hardware.systemVersion
        XCTAssertGreaterThanOrEqual(v.majorVersion, 17)
    }

    func testHardwareUptimeIsPositive() {
        XCTAssertGreaterThan(Luminous.Hardware.uptime, 0)
    }

    func testHardwareModelIdentifierIsNotEmpty() {
        XCTAssertFalse(Luminous.Hardware.modelIdentifier.isEmpty)
    }

    func testHardwareThermalStateDoesNotCrash() {
        _ = Luminous.Hardware.thermalState
    }

    func testHardwareAvailableMemoryInBytesIsNonNegative() {
        XCTAssertGreaterThanOrEqual(Luminous.Hardware.availableMemoryInBytes, 0)
    }

    func testHardwareAvailableMemoryConvertedIsNonNegative() {
        XCTAssertGreaterThanOrEqual(Luminous.Hardware.availableMemory(in: .megabytes), 0)
    }

    func testHardwareIsLowPowerModeDoesNotCrash() {
        _ = Luminous.Hardware.isLowPowerModeEnabled
    }

    func testHardwareIsSimulatorIsTrueInTests() {
        // Test targets always run on simulator; value must be true
        XCTAssertTrue(Luminous.Hardware.isSimulator)
    }


    // MARK: - Hardware.Screen

    @MainActor
    func testScreenPropertiesDoNotCrash() {
        _ = Luminous.Hardware.Screen.isScreenMirrored
        _ = Luminous.Hardware.Screen.nativeBounds
        _ = Luminous.Hardware.Screen.nativeScale
        _ = Luminous.Hardware.Screen.bounds
        _ = Luminous.Hardware.Screen.scale
        _ = Luminous.Hardware.Screen.maximumRefreshRate
    }

    @MainActor
    func testScreenBrightnessIsInRange() {
        let brightness = Luminous.Hardware.Screen.brightness
        XCTAssertGreaterThanOrEqual(brightness, 0, "Brightness must be >= 0")
        XCTAssertLessThanOrEqual(brightness, 1, "Brightness must be <= 1")
    }

    @MainActor
    func testScreenMaximumRefreshRateIsPositive() {
        XCTAssertGreaterThan(Luminous.Hardware.Screen.maximumRefreshRate, 0)
    }

    @MainActor
    func testScreenIsZoomedDoesNotCrash() {
        _ = Luminous.Hardware.Screen.isZoomed
    }


    // MARK: - Hardware.Device

    @MainActor
    func testDevicePropertiesDoNotCrash() {
        _ = Luminous.Hardware.Device.identifierForVendor
        _ = Luminous.Hardware.Device.orientation
        _ = Luminous.Hardware.Device.userInterfaceStyle
    }

    @MainActor
    func testDeviceSystemNameIsNotEmpty() {
        XCTAssertFalse(Luminous.Hardware.Device.systemName.isEmpty)
    }

    @MainActor
    func testDeviceNameIsNotEmpty() {
        XCTAssertFalse(Luminous.Hardware.Device.name.isEmpty)
    }


    // MARK: - Network

    func testNetworkPropertiesDoNotCrash() {
        _ = Luminous.Network.isConnectedViaWiFi
        _ = Luminous.Network.isConnectedViaCellular
        _ = Luminous.Network.isInternetAvailable
        _ = Luminous.Network.isExpensive
        _ = Luminous.Network.isConstrained
        _ = Luminous.Network.supportsIPv4
        _ = Luminous.Network.supportsIPv6
    }

    func testNetworkWiFiAndCellularMutuallyExclusive() {
        let wifi = Luminous.Network.isConnectedViaWiFi
        let cellular = Luminous.Network.isConnectedViaCellular
        XCTAssertFalse(wifi && cellular, "Cannot be on WiFi and cellular simultaneously")
    }


    // MARK: - Locale

    func testLocalePropertiesDoNotCrash() {
        _ = Luminous.Locale.currentLanguage
        _ = Luminous.Locale.currentTimeZone
        _ = Luminous.Locale.currentTimeZoneName
        _ = Luminous.Locale.currentCountry
        _ = Luminous.Locale.currentCurrency
        _ = Luminous.Locale.currentCurrencySymbol
        _ = Luminous.Locale.usesMetricSystem
        _ = Luminous.Locale.decimalSeparator
    }

    func testLocaleTimeZoneNameIsNotEmpty() {
        XCTAssertFalse(Luminous.Locale.currentTimeZoneName.isEmpty)
    }

    func testLocaleDecimalSeparatorIsNotNil() {
        XCTAssertNotNil(Luminous.Locale.decimalSeparator)
    }


    // MARK: - OperatingSystemVersion Comparable

    func testOperatingSystemVersionComparable() {
        let v17 = OperatingSystemVersion(majorVersion: 17, minorVersion: 0, patchVersion: 0)
        let v18 = OperatingSystemVersion(majorVersion: 18, minorVersion: 0, patchVersion: 0)
        let v18_3_1 = OperatingSystemVersion(majorVersion: 18, minorVersion: 3, patchVersion: 1)

        XCTAssertTrue(v17 < v18)
        XCTAssertTrue(v18 < v18_3_1)
        XCTAssertTrue(v18_3_1 > v17)
        XCTAssertEqual(v17, OperatingSystemVersion(majorVersion: 17, minorVersion: 0, patchVersion: 0))
    }

    func testOperatingSystemVersionMultiDigitMinor() {
        // "2.10.0" must be greater than "2.9.0" — was broken in old string-based implementation
        let v2_10 = OperatingSystemVersion(majorVersion: 2, minorVersion: 10, patchVersion: 0)
        let v2_9  = OperatingSystemVersion(majorVersion: 2, minorVersion: 9,  patchVersion: 0)
        XCTAssertTrue(v2_10 > v2_9)
    }
}
