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
    case iPodTouch1         = "iPod Touch 1"
    case iPodTouch2         = "iPod Touch 2"
    case iPodTouch3         = "iPod Touch 3"
    case iPodTouch4         = "iPod Touch 4"
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
    case iPhone8            = "iPhone 8"
    case iPhone8Plus        = "iPhone 8 Plus"
    case iPhoneX            = "iPhone X"
    case iPhoneXs           = "iPhone XS"
    case iPhoneXsMax        = "iPhone XS Max"
    case iPhoneXr           = "iPhone XR"
    case iPad2              = "iPad 2"
    case iPad3              = "iPad 3"
    case iPad4              = "iPad 4"
    case iPadAir            = "iPad Air"
    case iPadAir2           = "iPad Air 2"
    case iPadAir3           = "iPad Air 3"
    case iPad5              = "iPad 5"
    case iPad6              = "iPad 6"
    case iPadMini           = "iPad mini"
    case iPadMini2          = "iPad mini 2"
    case iPadMini3          = "iPad mini 3"
    case iPadMini4          = "iPad mini 4"
    case iPadMini5          = "iPad mini 5"
    case iPadPro            = "iPad Pro"
    case iPadPro2           = "iPad Pro (2nd generation)"
    case iPadPro3           = "iPad Pro (3rd generation)"
    case simulator          = "Simulator"
}

// The device screen size
public enum DeviiceSize: String {
    case screenUnknown          = "Unknown"
    case screen4Inches          = "4 inches"
    case screen4Dot7Inches      = "4,7 inches"
    case screen5Dot5Inches      = "5,5 inches"
    case screen5Dot8Inches      = "5,8 inches"
    case screen6Dot1Inches      = "6,1 inches"
    case screen6Dot5Inches      = "6,5 inches"
    case screen7Dot9Inches      = "7,9 inches"
    case screen9Dot7Inches      = "9,7 inches"
    case screen10Dot5Inches     = "10,5 inches"
    case screen11Inches         = "11 inches"
    case screen12Dot9Inches     = "12,9 inches"
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
    // Identifiers and model information at: https://www.theiphonewiki.com/wiki/Models
    fileprivate init(identifier: String) {
        
        self.identifier = identifier
        
        switch identifier {

        //
        // MARK: iPods
        //

        case "iPod1,1":
            self.type = .iPodTouch1
            self.size = .screen4Inches
            self.connectivity = .wiFi
            
        case "iPod2,1":
            self.type = .iPodTouch2
            self.size = .screen4Inches
            self.connectivity = .wiFi
            
        case "iPod3,1":
            self.type = .iPodTouch3
            self.size = .screen4Inches
            self.connectivity = .wiFi
            
        case "iPod4,1":
            self.type = .iPodTouch4
            self.size = .screen4Inches
            self.connectivity = .wiFi
            
        case "iPod5,1":
            self.type = .iPodTouch5
            self.size = .screen4Inches
            self.connectivity = .wiFi
            
        case "iPod7,1":
            self.type = .iPodTouch6
            self.size = .screen4Inches
            self.connectivity = .wiFi

        //
        // MARK: iPhones
        //

        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            self.type = .iPhone4
            self.size = .screen4Inches
            self.connectivity = .wiFi3G
            
        case "iPhone4,1":
            self.type = .iPhone4s
            self.size = .screen4Inches
            self.connectivity = .wiFi3G
            
        case "iPhone5,1", "iPhone5,2":
            self.type = .iPhone5
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            
        case "iPhone5,3", "iPhone5,4":
            self.type = .iPhone5c
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            
        case "iPhone6,1", "iPhone6,2":
            self.type = .iPhone5s
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            
        case "iPhone7,1":
            self.type = .iPhone6Plus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            
        case "iPhone7,2":
            self.type = .iPhone6
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            
        case "iPhone8,1":
            self.type = .iPhone6s
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            
        case "iPhone8,2":
            self.type = .iPhone6sPlus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            
        case "iPhone8,4":
            self.type = .iPhoneSE
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            
        case "iPhone9,1", "iPhone9,3":
            self.type = .iPhone7
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            
        case "iPhone9,2", "iPhone9,4":
            self.type = .iPhone7Plus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            
        case "iPhone10,1", "iPhone10,4":
            self.type = .iPhone8
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            
        case "iPhone10,2", "iPhone10,5":
            self.type = .iPhone8Plus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            
        case "iPhone10,3", "iPhone10,6":
            self.type = .iPhoneX
            self.size = .screen5Dot8Inches
            self.connectivity = .wiFi4G
            
        case "iPhone11,2":
            self.type = .iPhoneXs
            self.size = .screen5Dot8Inches
            self.connectivity = .wiFi4G
            
        case "iPhone11,4", "iPhone11,6":
            self.type = .iPhoneXsMax
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            
        case "iPhone11,8":
            self.type = .iPhoneXr
            self.size = .screen6Dot1Inches
            self.connectivity = .wiFi4G

        //
        // MARK: iPads
        //

        case "iPad2,1":
            self.type = .iPad2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            
        case "iPad2,2", "iPad2,3", "iPad2,4":
            self.type = .iPad2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi3G
            
        case "iPad3,1":
            self.type = .iPad3
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            
        case "iPad3,2", "iPad3,3":
            self.type = .iPad3
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            
        case "iPad3,4":
            self.type = .iPad4
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            
        case "iPad3,5", "iPad3,6":
            self.type = .iPad4
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            
        case "iPad4,1":
            self.type = .iPadAir
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            
        case "iPad4,2", "iPad4,3":
            self.type = .iPadAir
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            
        case "iPad5,3":
            self.type = .iPadAir2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            
        case "iPad5,4":
            self.type = .iPadAir2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G

        case "iPad6,3":
            self.type = .iPadPro
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi

        case "iPad6,4":
            self.type = .iPadPro
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G

        case "iPad6,7":
            self.type = .iPadPro
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi

        case "iPad6,8":
            self.type = .iPadPro
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G

        case "iPad6,11":
            self.type = .iPad5
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            
        case "iPad6,12":
            self.type = .iPad5
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G

        case "iPad7,1":
            self.type = .iPadPro2
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi

        case "iPad7,2":
            self.type = .iPadPro2
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G

        case "iPad7,3":
            self.type = .iPadPro2
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi

        case "iPad7,4":
            self.type = .iPadPro2
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi4G

        case "iPad7,5":
            self.type = .iPad6
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            
        case "iPad7,6":
            self.type = .iPad6
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G

        case "iPad8,1":
            self.type = .iPadPro3
            self.size = .screen11Inches
            self.connectivity = .wiFi

        case "iPad8,2":
            self.type = .iPadPro3
            self.size = .screen11Inches
            self.connectivity = .wiFi

        case "iPad8,3":
            self.type = .iPadPro3
            self.size = .screen11Inches
            self.connectivity = .wiFi4G

        case "iPad8,4":
            self.type = .iPadPro3
            self.size = .screen11Inches
            self.connectivity = .wiFi4G

        case "iPad8,5":
            self.type = .iPadPro3
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi

        case "iPad8,6":
            self.type = .iPadPro3
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi

        case "iPad8,7":
            self.type = .iPadPro3
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G

        case "iPad8,8":
            self.type = .iPadPro3
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G

        case "iPad11,3":
            self.type = .iPadAir3
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi

        case "iPad11,4":
            self.type = .iPadAir3
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi4G

        //
        // MARK: iPad mini
        //
            
        case "iPad2,5":
            self.type = .iPadMini
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            
        case "iPad2,6", "iPad2,7":
            self.type = .iPadMini
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi3G
            
        case "iPad4,4":
            self.type = .iPadMini2
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            
        case "iPad4,5", "iPad4,6":
            self.type = .iPadMini2
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            
        case "iPad4,7":
            self.type = .iPadMini3
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            
        case "iPad4,8", "iPad4,9":
            self.type = .iPadMini3
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            
        case "iPad5,1":
            self.type = .iPadMini4
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            
        case "iPad5,2":
            self.type = .iPadMini4
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G

        case "iPad11,1":
            self.type = .iPadMini5
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi

        case "iPad11,2":
            self.type = .iPadMini5
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G

        //
        // MARK: Other
        //

        case "i386", "x86_64":
            self.type = .simulator
            self.size = .screenUnknown
            self.connectivity = .wiFi
            
        default:
            self.type = .unknown
            self.size = .screenUnknown
            self.connectivity = .unknown
        }
        
        self.model = self.type.rawValue
        
        if self.type == .unknown {
            self.completeName = identifier + " - " + self.connectivity.rawValue + " - " + self.size.rawValue
        } else {
            self.completeName = self.model + " - " + self.connectivity.rawValue + " - " + self.size.rawValue
        }
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
