//
//  Luminous+Battery.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation
import UIKit


// MARK: - Battery

extension Luminous {

    /// Battery information.
    ///
    /// All properties are `@MainActor` because they read from `UIDevice.current`,
    /// which must be accessed on the main thread.
    @MainActor
    public struct Battery {

        /// Enables battery monitoring once and returns `UIDevice.current`.
        ///
        /// `isBatteryMonitoringEnabled` is set to `true` the first time a property
        /// is accessed and stays enabled for the lifetime of the app.
        private static let device: UIDevice = {
            let d = UIDevice.current
            d.isBatteryMonitoringEnabled = true
            return d
        }()

        /// The current battery charge level as a percentage (0–100).
        ///
        /// Returns `nil` when the battery level is unavailable (e.g. on Simulator
        /// or when monitoring is not yet active). The underlying `batteryLevel`
        /// value of `-1.0` is treated as unavailable.
        public static var level: Float? {
            let raw = device.batteryLevel
            guard raw >= 0 else { return nil }
            return raw * 100
        }

        /// The current battery state of the device.
        ///
        /// Returns `UIDevice.BatteryState` directly, including `.unknown` when
        /// the state cannot be determined.
        public static var state: UIDevice.BatteryState {
            device.batteryState
        }
    }
}
