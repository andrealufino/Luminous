//
//  Luminous+Locale.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation


extension Luminous {
    
    
    // MARK: Locale
    
    /// Locale information.
    public struct Locale {
        
        /// The current language of the system.
        public static var currentLanguage: String? {
            
            if let languageCode = Foundation.Locale.current.languageCode {
                return languageCode
            }
            
            return nil
        }
        
        /// The current Time Zone as TimeZone object.
        public static var currentTimeZone: TimeZone {
            
            return TimeZone.current
        }
        
        /// The current Time Zone identifier.
        public static var currentTimeZoneName: String {
            
            return TimeZone.current.identifier
        }
        
        /// The current country.
        public static var currentCountry: String? {
            
            if let regionCode = Foundation.Locale.current.regionCode {
                return regionCode
            }
            
            return nil
        }
        
        /// The current currency.
        public static var currentCurrency: String? {
             
            if let currencyCode = Foundation.Locale.current.currencyCode {
                return currencyCode
            }
            
            return nil
        }
        
        /// The current currency symbol.
        public static var currentCurrencySymbol: String? {
            
            if let currencySymbol = Foundation.Locale.current.currencySymbol {
                return currencySymbol
            }
            
            return nil
        }
        
        /// Check if the system is using the metric system.
        public static var usesMetricSystem: Bool {
            
            return Foundation.Locale.current.usesMetricSystem
        }
        
        /// The decimal separator
        public static var decimalSeparator: String? {
            
            if let decimalSeparator = Foundation.Locale.current.decimalSeparator {
                return decimalSeparator
            }
            
            return nil
        }
    }
}
