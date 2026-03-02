//
//  LuminousTests.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 20/10/16.
//

import XCTest
@testable import Luminous

final class LuminousTests: XCTestCase {


    // MARK: Hardware

    func testSystemNameIsNotEmpty() {
        XCTAssertFalse(Luminous.Hardware.systemName.isEmpty)
    }

    func testHardwareSystemVersionParsesCorrectly() {
        let version = Luminous.Hardware.systemVersion
        XCTAssertGreaterThan(version.major, 0)
    }

    func testProcessorCount() {
        XCTAssertGreaterThan(Luminous.Hardware.processorsNumber, 0)
        XCTAssertGreaterThan(Luminous.Hardware.activeProcessorsNumber, 0)
    }


    // MARK: SystemVersion

    func testSystemVersion_failableInit_validInput() {
        let v = Luminous.SystemVersion(withVersion: "18.3.1")
        XCTAssertNotNil(v)
        XCTAssertEqual(v?.major, 18)
        XCTAssertEqual(v?.minor, 3)
        XCTAssertEqual(v?.patch, 1)
    }

    func testSystemVersion_failableInit_twoComponents() {
        let v = Luminous.SystemVersion(withVersion: "14.0")
        XCTAssertNotNil(v)
        XCTAssertEqual(v?.major, 14)
        XCTAssertEqual(v?.minor, 0)
        XCTAssertEqual(v?.patch, 0)
    }

    func testSystemVersion_failableInit_invalidInput() {
        XCTAssertNil(Luminous.SystemVersion(withVersion: "notaversion"))
        XCTAssertNil(Luminous.SystemVersion(withVersion: "18"))
        XCTAssertNil(Luminous.SystemVersion(withVersion: ""))
    }

    func testSystemVersion_comparison_multiDigitComponents() {
        // This was broken before: "2.10.0" was incorrectly compared as string "2100" vs "290"
        let v2_10_0 = Luminous.SystemVersion(withVersion: "2.10.0")!
        let v2_9_0 = Luminous.SystemVersion(withVersion: "2.9.0")!
        XCTAssertTrue(v2_10_0 > v2_9_0, "2.10.0 must be greater than 2.9.0")
    }

    func testSystemVersion_comparison_basic() {
        let low = Luminous.SystemVersion(withVersion: "16.0.0")!
        let high = Luminous.SystemVersion(withVersion: "18.3.1")!
        XCTAssertTrue(low < high)
        XCTAssertTrue(high > low)
        XCTAssertEqual(low, Luminous.SystemVersion(withVersion: "16.0.0")!)
    }


    // MARK: Disk

    func testDiskTotalSpaceIsPositive() {
        XCTAssertGreaterThan(Luminous.Disk.totalSpaceInBytes, 0)
    }

    func testMeasureUnitDiskValues() {
        let totalGB = Luminous.Disk.totalSpace(measureUnit: .gigabytes)
        XCTAssertGreaterThan(totalGB, 0)
    }


    // MARK: Application

    func testApplicationVersionDoesNotCrash() {
        // In test context Bundle.main may lack Info.plist keys — must return "" not crash
        let version = Luminous.Application.version
        let build = Luminous.Application.build
        XCTAssertNotNil(version)
        XCTAssertNotNil(build)
    }


    // MARK: Network

    func testNetworkPropertiesDoNotCrash() {
        let wifi = Luminous.Network.isConnectedViaWiFi
        let cellular = Luminous.Network.isConnectedViaCellular
        let internet = Luminous.Network.isInternetAvailable
        // Device cannot be on WiFi and cellular simultaneously
        XCTAssertFalse(wifi && cellular, "Device cannot be on WiFi and cellular at the same time")
        _ = internet
    }


    // MARK: Locale

    func testLocaleProperties() {
        _ = Luminous.Locale.currentTimeZone
        _ = Luminous.Locale.currentTimeZoneName
        _ = Luminous.Locale.usesMetricSystem
    }
}
