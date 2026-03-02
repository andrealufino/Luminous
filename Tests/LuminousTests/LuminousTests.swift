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

    func testApplicationVersionDoesNotCrash() {
        // In a test target Bundle.main lacks Info.plist keys — must return "" not crash
        let version = Luminous.Application.version
        let build = Luminous.Application.build
        XCTAssertNotNil(version)
        XCTAssertNotNil(build)
    }


    // MARK: - Audio

    func testAudioVolumeIsNilOrInRange() {
        if let volume = Luminous.Audio.currentAudioOutputVolume {
            XCTAssertGreaterThanOrEqual(volume, 0)
            XCTAssertLessThanOrEqual(volume, 1)
        }
    }

    func testAudioHeadphonePropertiesDoNotCrash() {
        _ = Luminous.Audio.isWiredHeadsetPluggedIn
        _ = Luminous.Audio.isAnyHeadphoneConnected
        _ = Luminous.Audio.secondaryAudioShouldBeSilencedHint
    }


    // MARK: - Disk

    func testDiskTotalSpaceInBytesIsPositive() {
        XCTAssertGreaterThan(Luminous.Disk.totalSpaceInBytes, 0)
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
