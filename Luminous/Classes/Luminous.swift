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
import Deviice
import ExternalAccessory
import CoreMotion

// MARK: Enums

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

/// Enumeration representing the different stage of the development
///
/// - team:        The team configuration is used only by the dev team and is not shared neither with the project managers or accounts
/// - development: The development configuration, usually used during the dev phase
/// - stage:       The stage configuration, usually used during the first deliver to the client
/// - production:  The production configuration, usually used when the product has to be finally delivered to the client
public enum LMAppConfiguration {
    case team
    case development
    case stage
    case production
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
            public static var isConnectedToWiFi: Bool {
                let reachability = Reachability()!
                
                if reachability.isReachableViaWiFi {
                    return true
                } else {
                    return false
                }
            }
            
            /// Check if the device is connected to the cellular network
            public static var isConnectedViaCellular: Bool {
                
                return !isConnectedToWiFi
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
            public static var networkCountryCode: String? {
                
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
                    
                    return Deviice.currentDevice()
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
                        if desc.portType == AVAudioSessionPortHeadphones {
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
                return ByteCountFormatter.string(fromByteCount: freeSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.binary)
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
        }
        
        
        
        // MARK: Battery
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
            
            /// The current content of the clipboard (only string)
            public static var clipboardString: String? {
                
                return UIPasteboard.general.string
            }
        }
    }
    
    
    
    
    
    
    // MARK: Utils
    /// This struct contains some functions that can be useful during the development. 
    public struct Utils {
        
        /// Check if the passed email address is valid
        ///
        /// - parameter emailAddress: The email address to validate
        ///
        /// - returns: true if is valid, false if it's not
        public static func isEmailAddressValid(_ emailAddress: String) -> Bool {
            // println("validate calendar: \(testStr)")
            let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            
            return emailTest.evaluate(with: emailAddress)
        }
        
        /// Save an object into the `UserDefaults`
        ///
        /// - parameter object: The object to save
        /// - parameter key:    The key associated to this object
        ///
        /// - returns: true if the object has been saved, false if it has not been saved
        public static func saveObjectInUserDefaults(_ object: Any, forKey key: String) -> Bool {
            
            UserDefaults.standard.set(object, forKey: key)
            return UserDefaults.standard.synchronize()
        }
        
        /// Create a unique UUID string
        ///
        /// - returns: A unique UUID string
        public static func uniqueUUID () -> String {
            
            return UUID().uuidString
        }
    }
    
    
    
    // MARK: AppConfiguration
    /// This struct requires a discussion. It's not intended to be instantiated, but offers an interface to save and retrieve some common vars used in every projects. The `set` method can be used to init all the properties in once. You can even set all the properties separately and keep some of them nil if you don't need them. Among the things you can save there are colors (to create a palette for example) and server url based on development, stage or production.
    public struct AppConfiguration {
        
        /// The main color of the palette
        public static var mainColor: UIColor?
        /// The second color of the palette
        public static var secondColor: UIColor?
        /// The third color of the palette
        public static var thirdColor: UIColor?
        /// The fourth color of the palette
        public static var fourthColor: UIColor?
        /// The fifth color of the palette
        public static var fifthColor: UIColor?
        
        /// The current configuration of the app
        public static var currentConfiguration: LMAppConfiguration?
        
        /// The server base url for the team configuration
        public static var serverBaseURLTeam: String?
        /// The server base url for the development configuration
        public static var serverBaseURLDevelopment: String?
        /// The server base url for the stage configuration
        public static var serverBaseURLStage: String?
        /// The server base url for the production configuration
        public static var serverBaseURLProduction: String?
        
        /// Set all the main properties in once
        ///
        /// - parameter mainColor:                The main color
        /// - parameter secondColor:              The second color
        /// - parameter thirdColor:               The third color
        /// - parameter fourthColor:              The fourth color
        /// - parameter fifthColor:               The fifth color
        /// - parameter serverBaseURLTeam:        The team (Cloud9 for example) server url
        /// - parameter serverBaseURLDevelopment: The development server url
        /// - parameter serverBaseURLStage:       The stage server url
        /// - parameter serverBaseURLProduction:  The production server url
        public static func set(
            withMainColor mainColor: UIColor?,
            secondColor: UIColor?,
            thirdColor: UIColor?,
            fourthColor: UIColor?,
            fifthColor: UIColor?,
            serverBaseURLTeam: String?,
            serverBaseURLDevelopment: String?,
            serverBaseURLStage: String?,
            serverBaseURLProduction: String?) {
            
            AppConfiguration.mainColor = mainColor
            AppConfiguration.secondColor = secondColor
            AppConfiguration.thirdColor = thirdColor
            AppConfiguration.fourthColor = fourthColor
            AppConfiguration.fifthColor = fifthColor
            
            AppConfiguration.serverBaseURLTeam = serverBaseURLTeam
            AppConfiguration.serverBaseURLDevelopment = serverBaseURLDevelopment
            AppConfiguration.serverBaseURLStage = serverBaseURLStage
            AppConfiguration.serverBaseURLProduction = serverBaseURLProduction
        }
        
        /// Get the server base URL based on the current app configuration
        ///
        /// - note:    This method throws `fatalError("message")` if something is not correctly set up
        /// - returns: The correct server url based on the current app configuration
        public static func serverBaseURLBasedOnCurrentConfiguration () -> String {
            
            if let config: LMAppConfiguration = AppConfiguration.currentConfiguration {
                
                switch config {
                case LMAppConfiguration.team:
                    if let baseURL = AppConfiguration.serverBaseURLTeam {
                        return baseURL
                    }
                    fatalError("Luminous - AppConfiguration - You didn't set the team server url!")
                case LMAppConfiguration.development:
                    if let baseURL = AppConfiguration.serverBaseURLDevelopment {
                        return baseURL
                    }
                    fatalError("Luminous - AppConfiguration - You didn't set the development server url!")
                case LMAppConfiguration.stage:
                    if let baseURL = AppConfiguration.serverBaseURLStage {
                        return baseURL
                    }
                    fatalError("Luminous - AppConfiguration - You didn't set the stage server url!")
                case LMAppConfiguration.production:
                    if let baseURL = AppConfiguration.serverBaseURLProduction {
                        return baseURL
                    }
                    fatalError("Luminous - AppConfiguration - You didn't set the production server url!")
                }
            }
            
            fatalError("Luminous - AppConfiguration - You didn't set the configuration server url!")
        }
    }
}



























