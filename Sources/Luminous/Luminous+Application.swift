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
    }
}
