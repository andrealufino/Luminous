//
//  Luminous+Network.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation
import SystemConfiguration.CaptiveNetwork


extension Luminous {
    
    
    // MARK: Network
    
    /// Network information.
    public struct Network {
        
        /// Check if the device is connected to the WiFi network.
        public static var isConnectedViaWiFi: Bool {
            let reachability = Reachability()!
            
            if reachability.isReachableViaWiFi {
                return true
            } else {
                return false
            }
        }
        
        /// Check if the device is connected to the cellular network.
        public static var isConnectedViaCellular: Bool {
            
            return !isConnectedViaWiFi
        }
        
        /// Check if the internet is available.
        public static var isInternetAvailable: Bool {
            
            return Reachability()!.isReachable
        }
        
        /// Get the network SSID (doesn't work in the Simulator). Empty string if not available.
        /// This property is deprecated since version 2 of Luminous as iOS 13 does not allow access to
        /// `CNCopySupportedInterfaces`.
        @available(iOS, deprecated: 13.0, message: "It's no longer possible to get SSID info using CNCopySupportedInterfaces.")
        public static var SSID: String {
            
            // Doesn't work in the Simulator
            var currentSSID = ""
            if let interfaces:CFArray = CNCopySupportedInterfaces() {
                for i in 0..<CFArrayGetCount(interfaces){
                    let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                    let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                    let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                    if unsafeInterfaceData != nil {
                        let interfaceData = unsafeInterfaceData! as Dictionary?
                        for dictData in interfaceData! {
                            if dictData.key as! String == "SSID" {
                                currentSSID = dictData.value as! String
                            }
                        }
                    }
                }
            }
            
            return currentSSID
        }
    }
}
