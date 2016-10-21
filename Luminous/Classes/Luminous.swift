//
//  Luminous.swift
//  Pods
//
//  Created by Andrea Mario Lufino on 20/10/16.
//
//

import Foundation
import SystemConfiguration.CaptiveNetwork
import CoreTelephony
import AVFoundation

struct Luminous {
    
    /// Network information
    struct Network {
        
        /// Check if the device is connected to the WiFi network
        ///
        /// - returns: true if it is, false if it isn't
        static func isConnectedViaWiFi () -> Bool {
            
            let reachability = Reachability()!
            
            if reachability.isReachableViaWiFi {
                return true
            } else {
                return false
            }
        }
        
        /// Check if the device is connected to the cellular network
        ///
        /// - returns: true if it is, false if it isn't
        static func isConnectedViaCellular () -> Bool {
            
            return !isConnectedViaWiFi()
        }
        
        /// Get the network SSID (doesn't work in the Simulator)
        ///
        /// - returns: The SSID or the empty string ("")
        static func SSID () -> String{
            
            // Doesn't work in the Simulator
            var currentSSID = ""
            if let interfaces:CFArray = CNCopySupportedInterfaces() {
                for i in 0..<CFArrayGetCount(interfaces){
                    let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                    let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                    let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                    if unsafeInterfaceData != nil {
                        let interfaceData = unsafeInterfaceData! as Dictionary!
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
    
    
    
    
    /// Locale information
    struct Locale {
        
        /// The current language of the system
        ///
        /// - returns: The current language of the system as String
        static func currentLanguage () -> String {
            
            return NSLocale.preferredLanguages[0]
        }
        
        /// The current Time Zone as TimeZone object
        ///
        /// - returns: TimeZone object
        static func currentTimeZone () -> TimeZone {
            
            return TimeZone.current
        }
        
        /// The current Time Zone identifier
        ///
        /// - returns: The current Time Zone identifier as String
        static func currentTimeZoneName () -> String {
            
            return TimeZone.current.identifier
        }
        
        /// The current country
        ///
        /// - returns: The current country as String
        static func currentCountry () -> String {
            
            return NSLocale().localeIdentifier
        }
        
        /// The current measurement system
        ///
        /// - returns: The current measurement system as String
        static func currentMeasurementSystem () -> String {
            
            return NSLocale().object(forKey: NSLocale.Key.measurementSystem) as! String
        }
        
        /// The current currency
        ///
        /// - returns: The current currency as String
        static func currentCurrency () -> String {
            
            return NSLocale().object(forKey: NSLocale.Key.currencyCode) as! String
        }
        
        /// The current currency symbol
        ///
        /// - returns: The current currency symbol as String
        static func currentCurrencySymbol () -> String {
            
            if #available(iOS 10.0, *) {
                return NSLocale().currencySymbol
            } else {
                // Fallback on earlier versions
                return NSLocale().object(forKey: NSLocale.Key.currencySymbol) as! String
            }
        }
        
        /// Check if the system is using the metric system
        ///
        /// - returns: true if it does, false if it doesn't
        static func usesMetricSystem () -> Bool {
            
            if #available(iOS 10.0, *) {
                return NSLocale().usesMetricSystem
            } else {
                // Fallback on earlier versions
                return NSLocale().object(forKey: NSLocale.Key.usesMetricSystem) as! Bool
            }
        }
        
        /// The decimal separator
        ///
        /// - returns: The decimal separator as String
        static func decimalSeparator () -> String {
            
            if #available(iOS 10.0, *) {
                return NSLocale().decimalSeparator
            } else {
                // Fallback on earlier versions
                return NSLocale().object(forKey: NSLocale.Key.decimalSeparator) as! String
            }
        }
    }
    
    
    
    
    /// The Carrier information
    struct Carrier {
        
        /// The name of the carrier
        ///
        /// - returns: The name of the carrier or nil
        static func carrierName () -> String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.carrierName
            }
            
            return nil
        }
        
        /// The carrier ISO code
        ///
        /// - returns: The carrier ISO code or nil
        static func carrierISOCountryCode () -> String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.isoCountryCode
            }
            
            return nil
        }
        
        /// The carrier mobile country code
        ///
        /// - returns: The carrier mobile country code or nil
        static func carrierMobileCountryCode () -> String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.mobileCountryCode
            }
            
            return nil
        }
        
        /// The carrier network country code
        ///
        /// - returns: The carrier network country code or nil
        static func carrierNetworkCountryCode () -> String? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.mobileNetworkCode
            }
            
            return nil
        }
        
        /// Check if the carrier allows VOIP
        ///
        /// - returns: true if it does, false if it doesn't
        static func carrierAllowsVOIP () -> Bool? {
            
            let netInfo = CTTelephonyNetworkInfo()
            if let carrier = netInfo.subscriberCellularProvider {
                return carrier.allowsVOIP
            }
            
            return nil
        }
    }
    
    
    
    
    /// Hardware information
    struct Hardware {
        
        
        /// Number of processors
        ///
        /// - returns: The number of processors
        static func processorNumber () -> Int {
            
            return ProcessInfo().processorCount
        }
        
        /// Number of active processors
        ///
        /// - returns: The number of active processors
        static func activeProcessorNumber () -> Int {
            
            return ProcessInfo().activeProcessorCount
        }
        
        /// The name of the system
        ///
        /// - returns: The name of the system
        static func systemName () -> String {
            
            return UIDevice().systemName
        }
        
        /// The version of the system
        ///
        /// - returns: The version of the system
        static func systemVersion () -> String {
            
            return UIDevice().systemVersion
        }
        
        /// The current boot time
        ///
        /// - returns: The current boot time expressed in seconds
        static func bootTime () -> TimeInterval {
            
            return ProcessInfo().systemUptime
        }
        
        /// Check if headphones are plugged in
        ///
        /// - returns: true if they are, false if they aren't
        // !!!: Thanks to Antonio E., this code is coming from this SO answer : http://stackoverflow.com/a/21382748/588967 . I've only translated it in Swift
        static func isHeadsetPluggedIn () -> Bool {
            
            let route = AVAudioSession.sharedInstance().currentRoute
            
            for desc in route.outputs {
                if desc.portType == AVAudioSessionPortHeadphones {
                    return true
                }
            }
            return false
        }
        
        
        
        
        /// Screen information
        struct Screen {
            
            /// The current brightness
            ///
            /// - returns: The current brightness
            static func brightness () -> Float {
                
                return UIScreen.main.brightness as! Float
            }
            
            /// Check if the screen is being mirrored
            ///
            /// - returns: true if it is, false if it's not
            static func isScreenMirrored () -> Bool {
                
                if let mirrored = UIScreen.main.mirrored {
                    return true
                }
                
                return false
            }
            
            /// The bounding rectange of the physical screen measured in pixels
            ///
            /// - returns: The bounding rectange of the physical screen measured in pixels
            static func nativeBounds () -> CGRect {
                
                return UIScreen.main.nativeBounds
            }
            
            /// The scale of the physical screen
            ///
            /// - returns: The scale of the physical screen
            static func nativeScale () -> Float {
                
                return UIScreen.main.nativeScale as! Float
            }
            
            /// The bounds of the current main screen
            ///
            /// - returns: The bounds of the screen
            static func bounds () -> CGRect {
                
                return UIScreen.main.bounds
            }
            
            /// The scale of the current main screen
            ///
            /// - returns: The scale of the current main screen
            static func scale () -> Float {
                
                return UIScreen.main.scale as! Float
            }
            
            /// The snapshot of the current view
            ///
            /// - returns: The snapshot of the current view after all the updates are applied
            static func snapshotOfCurrentView () -> UIView {
                
                return UIScreen.main.snapshotView(afterScreenUpdates: true)
            }
        }
    }
    
    
    
    
    
}
































