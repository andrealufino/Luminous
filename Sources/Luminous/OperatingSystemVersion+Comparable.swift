//
//  OperatingSystemVersion+Comparable.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 02/03/26.
//

import Foundation


// MARK: - OperatingSystemVersion + Comparable

/// Adds `Comparable` support to `OperatingSystemVersion` so that OS versions
/// can be compared with `<`, `>`, `<=`, `>=` operators.
///
/// ```swift
/// let current = ProcessInfo.processInfo.operatingSystemVersion
/// let ios18 = OperatingSystemVersion(majorVersion: 18, minorVersion: 0, patchVersion: 0)
/// if current >= ios18 { ... }
/// ```
extension OperatingSystemVersion: @retroactive Equatable {

    public static func == (lhs: OperatingSystemVersion, rhs: OperatingSystemVersion) -> Bool {
        (lhs.majorVersion, lhs.minorVersion, lhs.patchVersion) ==
        (rhs.majorVersion, rhs.minorVersion, rhs.patchVersion)
    }
}

extension OperatingSystemVersion: @retroactive Comparable {

    public static func < (lhs: OperatingSystemVersion, rhs: OperatingSystemVersion) -> Bool {
        (lhs.majorVersion, lhs.minorVersion, lhs.patchVersion) <
        (rhs.majorVersion, rhs.minorVersion, rhs.patchVersion)
    }
}
