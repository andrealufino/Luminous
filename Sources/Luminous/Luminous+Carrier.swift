//
//  Luminous+Carrier.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import CoreTelephony
import Foundation


extension Luminous {
    
    
    // MARK: Carrier
    
    /// The Carrier information.
    public struct Carrier {
        
        /// The name of the carrier or nil if not available.
        public static var name: String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.carrierName
            }
            
            return nil
        }
        
        /// The carrier ISO code or nil if not available.
        public static var ISOCountryCode: String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.isoCountryCode
            }
            
            return nil
        }
        
        /// The carrier mobile country code or nil if not available.
        public static var mobileCountryCode: String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.mobileCountryCode
            }
            
            return nil
        }
        
        /// The carrier network country code or nil if not available
        @available(*, deprecated, message: "Use mobileNetworkCode instead")
        public static var networkCountryCode: String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.mobileNetworkCode
            }
            
            return nil
        }
        
        /// The carrier network country code or nil if not available.
        public static var mobileNetworkCode: String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.mobileNetworkCode
            }
            
            return nil
        }
        
        /// Check if the carrier allows Voip.
        public static var isVoipAllowed: Bool? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.allowsVOIP
            }
            
            return nil
        }
    }
}
