//
//  Luminous+Carrier.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import CoreTelephony
import Foundation


extension Luminous {


    // MARK: - Carrier

    /// Carrier information.
    ///
    /// - Note: `CTCarrier` was deprecated by Apple in iOS 16.1 with no official replacement.
    ///   All properties in this struct may return `nil` on iOS 16.1+ even with an active SIM.
    @available(iOS, deprecated: 16.1, message: "CTCarrier was deprecated by Apple in iOS 16.1 with no replacement. Carrier info may not be available.")
    public struct Carrier {

        // MARK: Private

        /// Returns the active carrier, preferring the data SIM on multi-SIM devices.
        ///
        /// Uses `dataServiceIdentifier` (iOS 13+) to pick the active data SIM.
        /// Falls back to the first available provider on iOS 12.
        private static var currentCarrier: CTCarrier? {
            let netInfo = CTTelephonyNetworkInfo()
            guard let providers = netInfo.serviceSubscriberCellularProviders,
                  !providers.isEmpty else { return nil }
            if #available(iOS 13.0, *), let dataId = netInfo.dataServiceIdentifier {
                return providers[dataId]
            }
            return providers.values.first
        }


        // MARK: Public Properties

        /// The name of the carrier, or `nil` if not available.
        public static var name: String? {
            currentCarrier?.carrierName
        }

        /// The carrier ISO country code, or `nil` if not available.
        public static var ISOCountryCode: String? {
            currentCarrier?.isoCountryCode
        }

        /// The mobile country code (MCC), or `nil` if not available.
        public static var mobileCountryCode: String? {
            currentCarrier?.mobileCountryCode
        }

        /// The mobile network code (MNC), or `nil` if not available.
        public static var mobileNetworkCode: String? {
            currentCarrier?.mobileNetworkCode
        }

        /// Whether the carrier allows VoIP, or `nil` if not available.
        public static var isVoipAllowed: Bool? {
            currentCarrier?.allowsVOIP
        }
    }
}
