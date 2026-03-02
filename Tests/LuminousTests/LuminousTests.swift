//
//  LuminousTests.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 20/10/16.
//

import XCTest
@testable import Luminous

final class LuminousTests: XCTestCase {

    func testSystemNameIsNotEmpty() {
        XCTAssertFalse(Luminous.Hardware.systemName.isEmpty)
    }

    func testSystemVersionParsesCorrectly() {
        let version = Luminous.Hardware.systemVersion
        XCTAssertGreaterThan(version.major, 0)
    }

    func testDiskTotalSpaceIsPositive() {
        XCTAssertGreaterThan(Luminous.Disk.totalSpaceInBytes, 0)
    }

    func testMeasureUnitDiskValues() {
        let totalGB = Luminous.Disk.totalSpace(measureUnit: .gigabytes)
        XCTAssertGreaterThan(totalGB, 0)
    }

    func testApplicationVersion() {
        // In test context, bundle info may be nil — just verify no crash
        _ = Luminous.Application.version
        _ = Luminous.Application.build
    }

    func testProcessorCount() {
        XCTAssertGreaterThan(Luminous.Hardware.processorsNumber, 0)
        XCTAssertGreaterThan(Luminous.Hardware.activeProcessorsNumber, 0)
    }

    func testLocaleProperties() {
        // Verify no crash; values depend on environment
        _ = Luminous.Locale.currentTimeZone
        _ = Luminous.Locale.currentTimeZoneName
        _ = Luminous.Locale.usesMetricSystem
    }
}
