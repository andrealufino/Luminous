//
//  Luminous+Disk.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation


// MARK: - Disk

extension Luminous {

    /// Internal disk space information.
    ///
    /// Space values use `URL.resourceValues(forKeys:)` with
    /// `.volumeAvailableCapacityForImportantUsageKey` for free space — this
    /// accounts for purgeable content and gives a more accurate available-space
    /// figure than the older `FileManager.attributesOfFileSystem` approach.
    public struct Disk: Sendable {

        // MARK: Raw bytes

        /// Total disk capacity in bytes. Returns `0` on failure.
        public static var totalSpaceInBytes: Int64 {
            guard
                let values = try? URL(fileURLWithPath: NSHomeDirectory())
                    .resourceValues(forKeys: [.volumeTotalCapacityKey]),
                let bytes = values.volumeTotalCapacity
            else { return 0 }
            return Int64(bytes)
        }

        /// Available disk space in bytes, including purgeable content.
        ///
        /// Uses `.volumeAvailableCapacityForImportantUsageKey` which reflects
        /// the space the OS will make available for important writes (e.g. app
        /// data). Returns `0` on failure.
        public static var freeSpaceInBytes: Int64 {
            guard
                let values = try? URL(fileURLWithPath: NSHomeDirectory())
                    .resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey]),
                let bytes = values.volumeAvailableCapacityForImportantUsage
            else { return 0 }
            return bytes
        }

        // MARK: Converted space

        /// Total disk capacity converted to the given unit.
        ///
        /// - Parameter unit: The `UnitInformationStorage` to convert to.
        ///   Defaults to `.gigabytes`.
        public static func totalSpace(in unit: UnitInformationStorage = .gigabytes) -> Double {
            convert(bytes: totalSpaceInBytes, to: unit)
        }

        /// Available disk space converted to the given unit.
        ///
        /// - Parameter unit: The `UnitInformationStorage` to convert to.
        ///   Defaults to `.gigabytes`.
        public static func freeSpace(in unit: UnitInformationStorage = .gigabytes) -> Double {
            convert(bytes: freeSpaceInBytes, to: unit)
        }

        /// Used disk space converted to the given unit.
        ///
        /// - Parameter unit: The `UnitInformationStorage` to convert to.
        ///   Defaults to `.gigabytes`.
        public static func usedSpace(in unit: UnitInformationStorage = .gigabytes) -> Double {
            convert(bytes: totalSpaceInBytes - freeSpaceInBytes, to: unit)
        }

        // MARK: Private helpers

        /// Converts a byte count to the requested `UnitInformationStorage`.
        ///
        /// Uses `Measurement` for correct floating-point conversion, avoiding
        /// integer-division truncation.
        ///
        /// - Parameters:
        ///   - bytes: The value in bytes to convert.
        ///   - unit: The target unit.
        /// - Returns: The converted value as `Double`.
        private static func convert(bytes: Int64, to unit: UnitInformationStorage) -> Double {
            let measurement = Measurement<UnitInformationStorage>(value: Double(bytes), unit: .bytes)
            return measurement.converted(to: unit).value
        }
    }
}
