//
//  Deviice.swift
//  Pods
//
//  Created by Andrea Mario Lufino on 20/03/16.
//
//

import Foundation


// MARK: - Types

// This enum explains itself
public enum DeviiceType: String {
    case unknown            = "Unknown"
    case iPodTouch5         = "iPod Touch 5"
    case iPodTouch6         = "iPod Touch 6"
    case iPhone4            = "iPhone 4"
    case iPhone4s           = "iPhone 4s"
    case iPhone5            = "iPhone 5"
    case iPhone5c           = "iPhone 5c"
    case iPhone5s           = "iPhone 5s"
    case iPhone6            = "iPhone 6"
    case iPhone6Plus        = "iPhone 6 Plus"
    case iPhone6s           = "iPhone 6s"
    case iPhone6sPlus       = "iPhone 6s Plus"
    case iPhoneSE           = "iPhone SE"
    case iPhone7            = "iPhone 7"
    case iPhone7Plus        = "iPhone 7 Plus"
    case iPad2              = "iPad 2"
    case iPad3              = "iPad 3"
    case iPad4              = "iPad 4"
    case iPadAir            = "iPad Air"
    case iPadAir2           = "iPad Air 2"
    case iPad5              = "iPad 5th generation"
    case iPadMini           = "iPad Mini"
    case iPadMini2          = "iPad Mini 2"
    case iPadMini3          = "iPad Mini 3"
    case iPadMini4          = "iPad Mini 4"
    case iPadPro            = "iPad Pro"
    case simulator          = "Simulator"
}

// The device screen size
public enum DeviiceSize: String {
    case screenUnknown          = "Unknown"
    case screen4Inches          = "4 inches"
    case screen4Dot7Inches      = "4,7 inches"
    case screen5Dot5Inches      = "5,5 inches"
    case screen7Dot9Inches      = "7,9 inches"
    case screen9Dot7Inches      = "9,7 inches"
    case screen12Dot9Inches     = "12,9 inches"
    case screen10Dot5Inches     = "10,5 inches"
}

// The connectivity of the device
public enum DeviiceConnectivity: String {
    case unknown        = "Unknown"
    case wiFi           = "WiFi"
    case wiFi3G         = "WiFi + 3G"
    case wiFi4G         = "WiFi + 4G"
}


// MARK: - Deviice

/// A Deviice struct
public struct Deviice {
    
    // MARK: Vars
    
    /// The identifier of the device (for example: "iPod5,1")
    public fileprivate (set) var identifier: String
    /// The device type (DeviiceType enum)
    public fileprivate (set) var type: DeviiceType
    /// The name of the device in human language (ex.: "iPod Touch 5")
    public fileprivate (set) var model: String
    /// The size of the screen (DeviiceSize)
    public fileprivate (set) var size: DeviiceSize
    /// The connectivity of the device (DeviiceConnectivity)
    public fileprivate (set) var connectivity: DeviiceConnectivity
    /// The complete device name (ex.: "iPhone 6 Plus - WiFi + 4G - 5,5 inches")
    public fileprivate (set) var completeName: String
    
    
    // MARK: Essentials
    
    /// Private init
    ///
    /// - Parameter identifier: The identifier of the device
    fileprivate init(identifier: String) {
        
        self.identifier = identifier
        
        switch identifier {
        
        case "iPod5,1":
            self.type = .iPodTouch5
            self.size = .screen4Inches
            self.connectivity = .wiFi
            break
            
        case "iPod7,1":
            self.type = .iPodTouch6
            self.size = .screen4Inches
            self.connectivity = .wiFi
            break
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            self.type = .iPhone4
            self.size = .screen4Inches
            self.connectivity = .wiFi3G
            break
            
        case "iPhone4,1":
            self.type = .iPhone4s
            self.size = .screen4Inches
            self.connectivity = .wiFi3G
            break
            
        case "iPhone5,1", "iPhone5,2":
            self.type = .iPhone5
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone5,3", "iPhone5,4":
            self.type = .iPhone5c
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone6,1", "iPhone6,2":
            self.type = .iPhone5s
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone7,2":
            self.type = .iPhone6
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone7,1":
            self.type = .iPhone6Plus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone8,1":
            self.type = .iPhone6s
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone8,2":
            self.type = .iPhone6sPlus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone8,4":
            self.type = .iPhoneSE
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone9,1", "iPhone9,3":
            self.type = .iPhone7
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPhone9,2", "iPhone9,4":
            self.type = .iPhone7Plus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad2,1":
            self.type = .iPad2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            break
            
        case "iPad2,2", "iPad2,3", "iPad2,4":
            self.type = .iPad2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi3G
            break
            
        case "iPad3,1":
            self.type = .iPad3
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            break
            
        case "iPad3,2", "iPad3,3":
            self.type = .iPad3
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad3,4":
            self.type = .iPad4
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            break
            
        case "iPad3,5", "iPad3,6":
            self.type = .iPad4
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad4,1":
            self.type = .iPadAir
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            break
            
        case "iPad4,2", "iPad4,3":
            self.type = .iPadAir
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad5,3":
            self.type = .iPadAir2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            break
            
        case "iPad5,4":
            self.type = .iPadAir2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad6,11":
            self.type = .iPad5
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            break
            
        case "iPad6,12":
            self.type = .iPad5
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad2,5":
            self.type = .iPadMini
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            break
            
        case "iPad2,6", "iPad2,7":
            self.type = .iPadMini
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi3G
            break
            
        case "iPad4,4":
            self.type = .iPadMini2
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            break
            
        case "iPad4,5", "iPad4,6":
            self.type = .iPadMini2
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad4,7":
            self.type = .iPadMini3
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            break
            
        case "iPad4,8", "iPad4,9":
            self.type = .iPadMini3
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad5,1":
            self.type = .iPadMini4
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            break
            
        case "iPad5,2":
            self.type = .iPadMini4
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad6,7":
            self.type = .iPadPro
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi
            break
            
        case "iPad6,8":
            self.type = .iPadPro
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad6,3":
            self.type = .iPadPro
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            break
            
        case "iPad6,4":
            self.type = .iPadPro
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            break
            
        case "iPad7,3":
            self.type = .iPadPro
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi
            break
            
        case "iPad7,4":
            self.type = .iPadPro
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi4G
            
        case "i386", "x86_64":
            self.type = .simulator
            self.size = .screenUnknown
            self.connectivity = .wiFi
            break
            
        default:
            self.type = .unknown
            self.size = .screenUnknown
            self.connectivity = .unknown
            break
        }
        
        self.model = self.type.rawValue
        self.completeName = self.model + " - " + self.connectivity.rawValue + " - " + self.size.rawValue
    }
    
    
    // MARK: Current device
    
    /// The current device as Deviice struct
    ///
    /// - Returns: Deviice struct with informations about current device
    public static var current: Deviice {
        
        // Credits to Dennis Weissmann for this snippet
        // https://github.com/dennisweissmann
        // Here his snippet : https://github.com/dennisweissmann/DeviceKit/blob/master/Source/Device.swift#L177-L185
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return Deviice(identifier: identifier)
    }
}


// MARK: Description

extension Deviice: CustomStringConvertible {
    
    public var description: String {
        
        return "Deviice\nIdentifier: \(identifier)\nType: \(type)\nModel name: \(model)\nConnectivity: \(connectivity)\nScreen size: \(size)"
    }
}





