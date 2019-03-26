//
//  Luminous.swift
//  Pods
//
//  Created by Andrea Mario Lufino on 20/10/16.
//
//

import AVFoundation
import CoreMotion
import CoreTelephony
import ExternalAccessory
import Foundation
import SystemConfiguration.CaptiveNetwork

import Deviice


// MARK: Types

/// The size scale to decide how you want to obtain size information
///
/// - bytes:     In bytes
/// - kilobytes: In kilobytes
/// - megabytes: In megabytes
/// - gigabytes: In gigabytes
public enum LMSizeScale {
    case bytes
    case kilobytes
    case megabytes
    case gigabytes
}

/// The battery state
///
/// - unknown:   State unknown
/// - unplugged: Battery is not plugged in
/// - charging:  Battery is charging
/// - full:      Battery is full charged
public enum LMBatteryState: Int {
    case unknown
    case unplugged
    case charging
    case full
}


// MARK: Luminous

public struct Luminous {
    
    
    // MARK: System
    
    /// All the information about the system
    public struct System {
        
        
        // MARK: Network
        
        /// Network information
        public struct Network {
            
            /// Check if the device is connected to the WiFi network
            public static var isConnectedViaWiFi: Bool {
                let reachability = Reachability()!
                
                if reachability.isReachableViaWiFi {
                    return true
                } else {
                    return false
                }
            }
            
            /// Check if the device is connected to the cellular network
            public static var isConnectedViaCellular: Bool {
                
                return !isConnectedViaWiFi
            }
            
            public static var isInternetAvailable: Bool {
                
                return Reachability()!.isReachable
            }
            
            /// Get the network SSID (doesn't work in the Simulator). Empty string if not available
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
        
        
        // MARK: Locale
        
        /// Locale information
        public struct Locale {
            
            /// The current language of the system
            public static var currentLanguage: String {
                
                return NSLocale.preferredLanguages[0]
            }
            
            /// The current Time Zone as TimeZone object
            public static var currentTimeZone: TimeZone {
                
                return TimeZone.current
            }
            
            /// The current Time Zone identifier
            public static var currentTimeZoneName: String {
                
                return TimeZone.current.identifier
            }
            
            /// The current country
            public static var currentCountry: String {
                
                return NSLocale.current.identifier
            }
            
            /// The current currency
            public static var currentCurrency: String? {
                
                return NSLocale.current.currencyCode
            }
            
            /// The current currency symbol
            public static var currentCurrencySymbol: String? {
                
                return NSLocale.current.currencySymbol
            }
            
            /// Check if the system is using the metric system
            public static var usesMetricSystem: Bool {
                
                return NSLocale.current.usesMetricSystem
            }
            
            /// The decimal separator
            public static var decimalSeparator: String? {
                
                return NSLocale.current.decimalSeparator
            }
        }
        
        
        // MARK: Carrier
        
        /// The Carrier information
        public struct Carrier {
            
            /// The name of the carrier or nil if not available
            public static var name: String? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.carrierName
                }
                
                return nil
            }
            
            /// The carrier ISO code or nil if not available
            public static var ISOCountryCode: String? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.isoCountryCode
                }
                
                return nil
            }
            
            /// The carrier mobile country code or nil if not available
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
            
            /// The carrier network country code or nil if not available
            public static var mobileNetworkCode: String? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.mobileNetworkCode
                }
                
                return nil
            }
            
            /// Check if the carrier allows VOIP
            public static var allowsVOIP: Bool? {
                
                let netInfo = CTTelephonyNetworkInfo()
                if let carrier = netInfo.subscriberCellularProvider {
                    return carrier.allowsVOIP
                }
                
                return nil
            }
        }
        
        
        // MARK: Hardware
        
        /// Hardware information
        public struct Hardware {
            
            /// Number of processors
            public static var processorsNumber: Int {
                
                return ProcessInfo().processorCount
            }
            
            /// Number of active processors
            public static var activeProcessorsNumber: Int {
                
                return ProcessInfo().activeProcessorCount
            }
            
            /// Physical memory of the device in megabytes
            public static func physicalMemory (withSizeScale sizeScale: LMSizeScale) -> Float {
                
                let physicalMemory = ProcessInfo().physicalMemory
                
                switch sizeScale {
                case .bytes:
                    return Float(physicalMemory)
                case .kilobytes:
                    return Float(physicalMemory * 1024)
                case .megabytes:
                    return Float(physicalMemory * 1024 * 1024)
                case .gigabytes:
                    return Float(physicalMemory * 1024 * 1024 * 1024)
                }
            }
            
            /// The name of the system
            public static var systemName: String {
                
                return UIDevice().systemName
            }
            
            /// The version of the system
            public static var systemVersion: String {
                
                return UIDevice().systemVersion
            }
            
            /// The current boot time expressed in seconds
            public static var bootTime: TimeInterval {
                
                return ProcessInfo().systemUptime
            }
            
            @available(iOS 9.0,*)
            /// Check if the low power mode is currently enabled (iOS 9 and above)
            public static var isLowPowerModeEnabled: Bool {
                
                return ProcessInfo().isLowPowerModeEnabled
            }
            
            
            // MARK: Screen
            
            /// Screen information
            public struct Screen {
                
                /// The current brightness
                public static var brightness: Float {
                    
                    return Float(UIScreen.main.brightness)
                }
                
                /// Check if the screen is being mirrored
                public static var isScreenMirrored: Bool {
                    
                    if let _ = UIScreen.main.mirrored {
                        return true
                    }
                    
                    return false
                }
                
                /// The bounding rectange of the physical screen measured in pixels
                public static var nativeBounds: CGRect {
                    
                    return UIScreen.main.nativeBounds
                }
                
                /// The scale of the physical screen
                public static var nativeScale: Float {
                    
                    return Float(UIScreen.main.nativeScale)
                }
                
                /// The bounds of the current main screen
                public static var bounds: CGRect {
                    
                    return UIScreen.main.bounds
                }
                
                /// The scale of the current main screen
                public static var scale: Float {
                    
                    return Float(UIScreen.main.scale)
                }
                
                /// The snapshot of the current view after all the updates are applied
                public static var snapshotOfCurrentView: UIView {
                    
                    return UIScreen.main.snapshotView(afterScreenUpdates: true)
                }
            }
            
            
            // MARK: Device
            
            /// Device information
            public struct Device {
                
                /// The current device as Deviice object (see [Deviice](https://github.com/andrealufino/Deviice) library)
                public static var current: Deviice {
                    
                    return Deviice.current
                }
                
                /// The identifier for vendor of the device
                public static var identifierForVendor: String? {
                    
                    return UIDevice.current.identifierForVendor?.uuidString
                }
                
                /// The current device orientation as UIDeviceOrientation
                public static var orientation: UIDeviceOrientation {
                    
                    return UIDevice.current.orientation
                }
            }
            
            
            // MARK: Accessory
            
            /// Accessory information
            public struct Accessory {
                
                /// The number of connected accessories
                public static var count: Int {
                    
                    return EAAccessoryManager.shared().connectedAccessories.count
                }
                
                /// The names of the attacched accessories. If no accessory is attached the array will be empty, but not nil
                public static var connectedAccessoriesNames: [String] {
                    
                    var theNames: [String] = []
                    
                    for accessory in EAAccessoryManager.shared().connectedAccessories {
                        
                        theNames.append(accessory.name)
                    }
                    
                    return theNames
                }
                
                /// The accessories connected and available to use for the app as EAAccessory objects
                public static var connectedAccessories: [EAAccessory] {
                    
                    return EAAccessoryManager.shared().connectedAccessories
                }
                
                /// Check if headphones are plugged in
                public static var isHeadsetPluggedIn: Bool {
                    // !!!: Thanks to Antonio E., this code is coming from this SO answer : http://stackoverflow.com/a/21382748/588967 . I've only translated it in Swift
                    let route = AVAudioSession.sharedInstance().currentRoute
                    
                    for desc in route.outputs {
                        if desc.portType == AVAudioSession.Port.headphones {
                            return true
                        }
                    }
                    return false
                }
            }
            
            
            // MARK: Sensors
            
            /// Get info about the sensors
            public struct Sensors {
                
                /// Check if the accelerometer is available
                public static var isAccelerometerAvailable: Bool {
                    
                    return CMMotionManager.init().isAccelerometerAvailable
                }
                
                /// Check if gyroscope is available
                public static var isGyroAvailable: Bool {
                    
                    return CMMotionManager.init().isGyroAvailable
                }
                
                /// Check if magnetometer is available
                public static var isMagnetometerAvailable: Bool {
                    
                    return CMMotionManager.init().isMagnetometerAvailable
                }
                
                /// Check if device motion is available
                public static var isDeviceMotionAvailable: Bool {
                    
                    return CMMotionManager.init().isDeviceMotionAvailable
                }
            }
        }
        
        
        // MARK: Disk
        
        /// Disk information
        public struct Disk {
            
            // The credits for these functions are to Cuong Lam for this SO answer : http://stackoverflow.com/a/29417855/588967
            private static func MBFormatter(_ bytes: Int64) -> String {
                let formatter = ByteCountFormatter()
                formatter.allowedUnits = ByteCountFormatter.Units.useMB
                formatter.countStyle = ByteCountFormatter.CountStyle.decimal
                formatter.includesUnit = false
                return formatter.string(fromByteCount: bytes) as String
            }
            
            /// The total disk space in string format (megabytes)
            public static var totalSpace: String {
                return ByteCountFormatter.string(fromByteCount: totalSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
            }
            
            /// The free disk space in string format (megabytes)
            public static var freeSpace: String {
                return ByteCountFormatter.string(fromByteCount: freeSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
            }
            
            /// The used disk space in string format (megabytes)
            public static var usedSpace: String {
                return ByteCountFormatter.string(fromByteCount: usedSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
            }
            
            /// The total disk space in bytes. 0 if something went wrong
            public static var totalSpaceInBytes: Int64 {
                do {
                    let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                    let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
                    return space!
                } catch {
                    return 0
                }
            }
            
            /// The free disk space in bytes. 0 if something went wrong
            public static var freeSpaceInBytes: Int64 {
                do {
                    let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                    let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
                    return freeSpace!
                } catch {
                    return 0
                }
            }
            
            /// The used disk space in bytes. 0 if something went wrong
            public static var usedSpaceInBytes: Int64 {
                let usedSpace = totalSpaceInBytes - freeSpaceInBytes
                return usedSpace
            }
            
            /// The free disk space in percentage
            public static var freeSpaceInPercentage: Float {
                
                let freeSpace = Float(freeSpaceInBytes)
                let totalSpace = Float(totalSpaceInBytes)
                
                return (freeSpace * 100) / totalSpace
            }
            
            /// The used disk space in percentage
            public static var usedSpaceInPercentage: Float {
                
                let usedSpace = Float(usedSpaceInBytes)
                let totalSpace = Float(totalSpaceInBytes)
                
                return (usedSpace * 100) / totalSpace
            }
        }
        
        
        // MARK: Battery
        
        /// Battery information
        public struct Battery {
            
            private static var device: UIDevice {
                get {
                    let dev = UIDevice.current
                    dev.isBatteryMonitoringEnabled = true
                    
                    return dev
                }
            }
            
            /// The current level of the battery
            public static var level: Float? {
                
                let batteryCharge = device.batteryLevel
                if batteryCharge > 0 {
                    return batteryCharge * 100
                } else {
                    return nil
                }
            }
            
            /// The current battery state of the device
            public static var state: LMBatteryState {
                
                switch device.batteryState {
                case .unknown:
                    return LMBatteryState.unknown
                case .unplugged:
                    return LMBatteryState.unplugged
                case .charging:
                    return LMBatteryState.charging
                case .full:
                    return LMBatteryState.full
                }
            }
        }
        
        
        // MARK: Application
        
        /// Application information
        public struct Application {
            
            /// The current app version
            public static var version: String {
                
                return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            }
            
            /// The build number
            public static var build: String {
                
                return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
            }
            
            /// The complete app version with build number (i.e. : "2.1.3 (343)")
            public static var completeAppVersion: String {
                
                return "\(Application.version) (\(Application.build))"
            }
            
            /// The current content of the clipboard (only string)
            public static var clipboardString: String? {
                
                return UIPasteboard.general.string
            }
        }
    }
}



























