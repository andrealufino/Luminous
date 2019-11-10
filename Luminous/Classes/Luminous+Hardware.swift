//
//  Luminous+Hardware.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import AVFoundation
import CoreMotion
import CoreTelephony
import ExternalAccessory
import Foundation
import SystemConfiguration.CaptiveNetwork

import Deviice


extension Luminous {
    
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
        
        /// The version of the system.
        public static var systemVersion: String {
            
            return UIDevice().systemVersion
        }
        
        /// The current boot time expressed in seconds.
        public static var bootTime: TimeInterval {
            
            return ProcessInfo().systemUptime
        }
        
        @available(iOS 9.0,*)
        /// Check if the low power mode is currently enabled (iOS 9 and above).
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
}
