//
//  Luminous+Hardware.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import AVFoundation
import CoreMotion
import ExternalAccessory
import Foundation
import UIKit


extension Luminous {
    
    /// Represents an OS version split into major, minor, and patch components.
    ///
    /// Supports equality and ordered comparison via tuple semantics, which correctly
    /// handles multi-digit version components (e.g. "2.10.0" > "2.9.0").
    public struct SystemVersion: Equatable, Comparable {

        /// The major version component. "10.1.2" → 10.
        public let major: Int
        /// The minor version component. "10.1.2" → 1.
        public let minor: Int
        /// The patch version component. "10.1.2" → 2.
        public let patch: Int
        /// The original version string.
        public let stringValue: String

        /// Creates a `SystemVersion` by parsing a dot-separated version string.
        ///
        /// Returns `nil` if the string does not contain at least two numeric
        /// dot-separated components (e.g. "18" or "abc" are invalid).
        ///
        /// - Parameter version: A version string such as "18.3.1".
        public init?(withVersion version: String) {
            let components = version.split(separator: ".").compactMap { Int($0) }
            guard components.count >= 2 else { return nil }
            self.major = components[0]
            self.minor = components[1]
            self.patch = components.count > 2 ? components[2] : 0
            self.stringValue = version
        }

        public static func < (lhs: SystemVersion, rhs: SystemVersion) -> Bool {
            (lhs.major, lhs.minor, lhs.patch) < (rhs.major, rhs.minor, rhs.patch)
        }
    }
    
    // MARK: Hardware
    
    /// Hardware information.
    public struct Hardware {
        
        /// Number of processors.
        public static var processorsNumber: Int {
            
            return ProcessInfo().processorCount
        }
        
        /// Number of active processors.
        public static var activeProcessorsNumber: Int {
            
            return ProcessInfo().activeProcessorCount
        }
        
        /// Physical memory of the device in megabytes.
        public static func physicalMemory(with sizeScale: MeasureUnit = .gigabytes) -> Double {
            
            let physicalMemory = Float(ProcessInfo().physicalMemory)
            
            switch sizeScale {
            case .bytes:
                return Double(physicalMemory)
            case .kilobytes:
                return Double(physicalMemory / 1024)
            case .megabytes:
                return Double(physicalMemory / 1024 / 1024)
            case .gigabytes:
                return Double(physicalMemory / 1024 / 1024 / 1024)
            case .percentage:
                return 100.0
            }
        }
        
        /// The name of the system.
        public static var systemName: String {
            
            return UIDevice().systemName
        }
        
        /// The version of the system. Private use.
        private static var _systemVersion: String {
            
            return UIDevice().systemVersion
        }
        
        /// The version of the system.
        public static var systemVersion: SystemVersion {
            // UIDevice.current.systemVersion is always a valid version string.
            return SystemVersion(withVersion: _systemVersion)!
        }
        
        /// The current boot time expressed in seconds.
        public static var bootTime: TimeInterval {
            
            return ProcessInfo().systemUptime
        }
        
        /// Check if the low power mode is currently enabled.
        public static var isLowPowerModeEnabled: Bool {
            
            return ProcessInfo().isLowPowerModeEnabled
        }
        
        
        // MARK: Screen
        
        /// Screen information.
        public struct Screen {
            
            /// The current brightness
            public static var brightness: Float {
                
                return Float(UIScreen.main.brightness)
            }
            
            /// Check if the screen is being mirrored.
            public static var isScreenMirrored: Bool {
                
                if let _ = UIScreen.main.mirrored {
                    return true
                }
                
                return false
            }
            
            /// The bounding rectange of the physical screen measured in pixels.
            public static var nativeBounds: CGRect {
                
                return UIScreen.main.nativeBounds
            }
            
            /// The scale of the physical screen.
            public static var nativeScale: Float {
                
                return Float(UIScreen.main.nativeScale)
            }
            
            /// The bounds of the current main screen.
            public static var bounds: CGRect {
                
                return UIScreen.main.bounds
            }
            
            /// The scale of the current main screen.
            public static var scale: Float {
                
                return Float(UIScreen.main.scale)
            }
            
            /// The snapshot of the current view after all the updates are applied.
            public static var snapshotOfCurrentView: UIView {
                
                return UIScreen.main.snapshotView(afterScreenUpdates: true)
            }
        }
        
        
        // MARK: Device
        
        /// Device information
        public struct Device {
            
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
}
