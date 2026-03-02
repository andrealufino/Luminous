//
//  Luminous.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 20/10/16.
//

import Foundation
import UIKit


// MARK: - Luminous

/// Namespace for all system information utilities.
///
/// `Luminous` is an enum to prevent instantiation. All API is accessed through
/// its nested structs, e.g. `Luminous.Network.isInternetAvailable`.
public enum Luminous { }


// MARK: - v2 Migration Typealiases

extension Luminous {

    /// Deprecated. Use `UIDevice.BatteryState` directly.
    @available(*, deprecated, renamed: "UIDevice.BatteryState")
    public typealias BatteryState = UIDevice.BatteryState

    /// Deprecated. Use `UnitInformationStorage` from Foundation instead.
    @available(*, deprecated, message: "Use UnitInformationStorage from Foundation instead.")
    public typealias MeasureUnit = UnitInformationStorage

    /// Deprecated. Use `OperatingSystemVersion` with the `Comparable` extension instead.
    @available(*, deprecated, message: "Use OperatingSystemVersion with the Comparable extension instead.")
    public typealias SystemVersion = OperatingSystemVersion
}
