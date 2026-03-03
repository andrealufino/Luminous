//
//  Luminous+Application.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation


// MARK: - Application

extension Luminous {

    /// Application bundle information.
    public struct Application: Sendable {

        /// The current app version string (e.g. "2.1.3").
        ///
        /// Returns an empty string if `CFBundleShortVersionString` is absent from
        /// the bundle info dictionary (e.g. in test targets or frameworks without Info.plist).
        public static var version: String {
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        }

        /// The current build number string (e.g. "343").
        ///
        /// Returns an empty string if `CFBundleVersion` is absent from the bundle
        /// info dictionary.
        public static var build: String {
            Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        }

        /// The combined version and build string (e.g. "2.1.3 (343)").
        public static var completeAppVersion: String {
            "\(version) (\(build))"
        }

        /// The bundle identifier of the app (e.g. `"com.example.MyApp"`).
        ///
        /// Returns `nil` in test targets and frameworks that have no bundle
        /// identifier in their Info.plist.
        public static var bundleIdentifier: String? {
            Bundle.main.bundleIdentifier
        }

        /// The user-visible display name of the app.
        ///
        /// Reads `CFBundleDisplayName` first, then falls back to `CFBundleName`.
        /// Returns an empty string if neither key is present (e.g. in test targets).
        public static var displayName: String {
            Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
                ?? Bundle.main.infoDictionary?["CFBundleName"] as? String
                ?? ""
        }
    }
}
