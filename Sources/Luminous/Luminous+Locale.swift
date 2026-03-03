//
//  Luminous+Locale.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation


// MARK: - Locale

extension Luminous {

    /// Locale information.
    ///
    /// All properties use the iOS 17 `Locale` API (`language`, `region`,
    /// `currency`) instead of the deprecated `languageCode`, `regionCode`,
    /// and `currencyCode` properties.
    public struct Locale: Sendable {

        /// The BCP 47 language code for the current locale (e.g. `"en"`, `"it"`).
        public static var currentLanguage: String? {
            Foundation.Locale.current.language.languageCode?.identifier
        }

        /// The current time zone.
        public static var currentTimeZone: TimeZone {
            TimeZone.current
        }

        /// The IANA identifier of the current time zone (e.g. `"Europe/Rome"`).
        public static var currentTimeZoneName: String {
            TimeZone.current.identifier
        }

        /// The ISO 3166-1 region identifier for the current locale (e.g. `"US"`, `"IT"`).
        public static var currentCountry: String? {
            Foundation.Locale.current.region?.identifier
        }

        /// The ISO 4217 currency code for the current locale (e.g. `"USD"`, `"EUR"`).
        public static var currentCurrency: String? {
            Foundation.Locale.current.currency?.identifier
        }

        /// The currency symbol for the current locale (e.g. `"$"`, `"€"`).
        public static var currentCurrencySymbol: String? {
            Foundation.Locale.current.currencySymbol
        }

        /// Whether the current locale uses the metric system.
        public static var usesMetricSystem: Bool {
            Foundation.Locale.current.measurementSystem == .metric
        }

        /// The decimal separator character for the current locale (e.g. `"."` or `","`).
        public static var decimalSeparator: String? {
            Foundation.Locale.current.decimalSeparator
        }
    }
}
