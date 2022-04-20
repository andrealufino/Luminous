//
//  Deviice.swift
//  Pods
//
//  Created by Andrea Mario Lufino on 20/03/16.
//
//

import Foundation


// MARK: - Types

/// This enumeration represents the device.
public enum DeviiceType: String {
    case unknown            = "Unknown"
    case iPodTouch1         = "iPod Touch 1"
    case iPodTouch2         = "iPod Touch 2"
    case iPodTouch3         = "iPod Touch 3"
    case iPodTouch4         = "iPod Touch 4"
    case iPodTouch5         = "iPod Touch 5"
    case iPodTouch6         = "iPod Touch 6"
    case iPodTouch7         = "iPod Touch 7"
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
    case iPhone11           = "iPhone 11"
    case iPhone11Pro        = "iPhone 11 Pro"
    case iPhone11ProMax     = "iPhone 11 Pro Max"
    case iPhoneSE2          = "iPhone SE (2nd generation)"
    case iPhone12Mini       = "iPhone 12 Mini"
    case iPhone12           = "iPhone 12"
    case iPhone12Pro        = "iPhone 12 Pro"
    case iPhone12ProMax     = "iPhone 12 Pro Max"
    case iPhone13Mini       = "iPhone 13 Mini"
    case iPhone13           = "iPhone 13"
    case iPhone13Pro        = "iPhone 13 Pro"
    case iPhone13ProMax     = "iPhone 13 Pro Max"
    case iPhoneSE3          = "iPhone SE (3rd generation)"
    case iPad2              = "iPad 2"
    case iPad3              = "iPad 3"
    case iPad4              = "iPad 4"
    case iPadAir            = "iPad Air"
    case iPadAir2           = "iPad Air 2"
    case iPadAir3           = "iPad Air 3"
    case iPadAir4           = "iPad Air 4"
    case iPadAir5           = "iPad Air 5"
    case iPad5              = "iPad 5"
    case iPad6              = "iPad 6"
    case iPad7              = "iPad 7"
    case iPad8              = "iPad 8"
    case iPad9              = "iPad 9"
    case iPadMini           = "iPad mini"
    case iPadMini2          = "iPad mini 2"
    case iPadMini3          = "iPad mini 3"
    case iPadMini4          = "iPad mini 4"
    case iPadMini5          = "iPad mini 5"
    case iPadMini6          = "iPad mini 6"
    case iPadPro            = "iPad Pro"
    case iPadPro2           = "iPad Pro (2nd generation)"
    case iPadPro3           = "iPad Pro (3rd generation)"
    case iPadPro4           = "iPad Pro (4th generation)"
    case iPadPro5           = "iPad Pro (5th generation)"
    case simulator          = "Simulator"
}

// The device screen size.
public enum DeviiceSize: String {
    case screenUnknown          = "Unknown"
    case screen3Dot5Inches      = "3.5 inches"
    case screen4Inches          = "4 inches"
    case screen4Dot7Inches      = "4.7 inches"
    case screen5Dot4Inches      = "5.4 inches"
    case screen5Dot5Inches      = "5.5 inches"
    case screen5Dot8Inches      = "5.8 inches"
    case screen6Dot1Inches      = "6.1 inches"
    case screen6Dot5Inches      = "6.5 inches"
    case screen6Dot7Inches      = "6.7 inches"
    case screen7Dot9Inches      = "7.9 inches"
    case screen8Dot3Inches      = "8.3 inches"
    case screen9Dot7Inches      = "9.7 inches"
    case screen10Dot2Inches     = "10.2 inches"
    case screen10Dot5Inches     = "10.5 inches"
    case screen10Dot9Inches     = "10.9 inches"
    case screen11Inches         = "11 inches"
    case screen12Dot9Inches     = "12.9 inches"
    
    /// This is the value as `Double` of the screen size.
    /// Could be useful to make comparison.
    var value: Double {
        switch self {
        case .screenUnknown:
            return -1
        case .screen3Dot5Inches:
            return 3.5
        case .screen4Inches:
            return 4
        case .screen4Dot7Inches:
            return 4.7
        case .screen5Dot4Inches:
            return 5.4
        case .screen5Dot5Inches:
            return 5.5
        case .screen5Dot8Inches:
            return 5.8
        case .screen6Dot1Inches:
            return 6.1
        case .screen6Dot5Inches:
            return 6.5
        case .screen6Dot7Inches:
            return 6.7
        case .screen7Dot9Inches:
            return 7.9
        case .screen8Dot3Inches:
            return 8.3
        case .screen9Dot7Inches:
            return 9.7
        case .screen10Dot2Inches:
            return 10.2
        case .screen10Dot5Inches:
            return 10.5
        case .screen10Dot9Inches:
            return 10.9
        case .screen11Inches:
            return 11
        case .screen12Dot9Inches:
            return 12.9
        }
    }
}

// The connectivity of the device.
public enum DeviiceConnectivity: String {
    case unknown        = "Unknown"
    case wiFi           = "WiFi"
    case wiFi3G         = "WiFi + 3G"
    case wiFi4G         = "WiFi + 4G"
    case wiFi5G         = "WiFi + 5G"
}


// MARK: - Deviice

/// This structure represents a device.
@available(*, deprecated, message: "Use Device class instead.")
public struct Deviice {
    
    // MARK: Vars
    
    /// The identifier of the device (for example: "iPod5,1").
    public private (set) var identifier: String
    /// The device type (`DeviiceType` enum).
    public private (set) var type: DeviiceType
    /// The name of the device in human language (ex.: "iPod Touch 5").
    public private (set) var model: String
    /// The size of the screen (`DeviiceSize`).
    public private (set) var size: DeviiceSize
    /// The connectivity of the device (`DeviiceConnectivity`).
    public private (set) var connectivity: DeviiceConnectivity
    /// The complete device name (ex.: "iPhone 6 Plus - WiFi + 4G - 5,5 inches").
    public private (set) var completeName: String
    /// The release year of the device. It's an int because it could be useful to do quick comparison.
    public private (set) var year: Int
    
    
    // MARK: Essentials
    
    /// Private init.
    ///
    /// - Parameter identifier: The identifier of the device.
    // Identifiers and model information at: https://www.theiphonewiki.com/wiki/Models
    private init(identifier: String) {
        
        self.identifier = identifier
        
        switch identifier {

        // MARK: iPod

        case "iPod1,1":
            self.type = .iPodTouch1
            self.size = .screen3Dot5Inches
            self.connectivity = .wiFi
            self.year = 2007
            
        case "iPod2,1":
            self.type = .iPodTouch2
            self.size = .screen3Dot5Inches
            self.connectivity = .wiFi
            self.year = 2008
            
        case "iPod3,1":
            self.type = .iPodTouch3
            self.size = .screen3Dot5Inches
            self.connectivity = .wiFi
            self.year = 2009
            
        case "iPod4,1":
            self.type = .iPodTouch4
            self.size = .screen3Dot5Inches
            self.connectivity = .wiFi
            self.year = 2010
            
        case "iPod5,1":
            self.type = .iPodTouch5
            self.size = .screen4Inches
            self.connectivity = .wiFi
            self.year = 2012
            
        case "iPod7,1":
            self.type = .iPodTouch6
            self.size = .screen4Inches
            self.connectivity = .wiFi
            self.year = 2015
            
        case "iPod9,1":
            self.type = .iPodTouch7
            self.size = .screen4Inches
            self.connectivity = .wiFi
            self.year = 2019

        // MARK: iPhone

        case "iPhone3,1", "iPhone3,2", "iPhone3,3":
            self.type = .iPhone4
            self.size = .screen4Inches
            self.connectivity = .wiFi3G
            self.year = 2010
            
        case "iPhone4,1":
            self.type = .iPhone4s
            self.size = .screen4Inches
            self.connectivity = .wiFi3G
            self.year = 2011
            
        case "iPhone5,1", "iPhone5,2":
            self.type = .iPhone5
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            self.year = 2012
            
        case "iPhone5,3", "iPhone5,4":
            self.type = .iPhone5c
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            self.year = 2013
            
        case "iPhone6,1", "iPhone6,2":
            self.type = .iPhone5s
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            self.year = 2013
            
        case "iPhone7,1":
            self.type = .iPhone6Plus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            self.year = 2014
            
        case "iPhone7,2":
            self.type = .iPhone6
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2014
            
        case "iPhone8,1":
            self.type = .iPhone6s
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2015
            
        case "iPhone8,2":
            self.type = .iPhone6sPlus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            self.year = 2015
            
        case "iPhone8,4":
            self.type = .iPhoneSE
            self.size = .screen4Inches
            self.connectivity = .wiFi4G
            self.year = 2016
            
        case "iPhone9,1", "iPhone9,3":
            self.type = .iPhone7
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2016
            
        case "iPhone9,2", "iPhone9,4":
            self.type = .iPhone7Plus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            self.year = 2016
            
        case "iPhone10,1", "iPhone10,4":
            self.type = .iPhone8
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2017
            
        case "iPhone10,2", "iPhone10,5":
            self.type = .iPhone8Plus
            self.size = .screen5Dot5Inches
            self.connectivity = .wiFi4G
            self.year = 2017
            
        case "iPhone10,3", "iPhone10,6":
            self.type = .iPhoneX
            self.size = .screen5Dot8Inches
            self.connectivity = .wiFi4G
            self.year = 2017
            
        case "iPhone11,2":
            self.type = .iPhoneXs
            self.size = .screen5Dot8Inches
            self.connectivity = .wiFi4G
            self.year = 2018
            
        case "iPhone11,4", "iPhone11,6":
            self.type = .iPhoneXsMax
            self.size = .screen6Dot5Inches
            self.connectivity = .wiFi4G
            self.year = 2018
            
        case "iPhone11,8":
            self.type = .iPhoneXr
            self.size = .screen6Dot1Inches
            self.connectivity = .wiFi4G
            self.year = 2018

        case "iPhone12,1":
            self.type = .iPhone11
            self.size = .screen6Dot1Inches
            self.connectivity = .wiFi4G
            self.year = 2019

        case "iPhone12,3":
            self.type = .iPhone11Pro
            self.size = .screen5Dot8Inches
            self.connectivity = .wiFi4G
            self.year = 2019

        case "iPhone12,5":
            self.type = .iPhone11ProMax
            self.size = .screen6Dot5Inches
            self.connectivity = .wiFi4G
            self.year = 2019

        case "iPhone12,8":
            self.type = .iPhoneSE2
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2020
            
        case "iPhone13,1":
            self.type = .iPhone12Mini
            self.size = .screen5Dot4Inches
            self.connectivity = .wiFi5G
            self.year = 2020
            
        case "iPhone13,2":
            self.type = .iPhone12
            self.size = .screen6Dot1Inches
            self.connectivity = .wiFi5G
            self.year = 2020
            
        case "iPhone13,3":
            self.type = .iPhone12Pro
            self.size = .screen6Dot1Inches
            self.connectivity = .wiFi5G
            self.year = 2020
            
        case "iPhone13,4":
            self.type = .iPhone12ProMax
            self.size = .screen6Dot7Inches
            self.connectivity = .wiFi5G
            self.year = 2020
            
        case "iPhone14,4":
            self.type = .iPhone13Mini
            self.size = .screen5Dot4Inches
            self.connectivity = .wiFi5G
            self.year = 2021
            
        case "iPhone14,5":
            self.type = .iPhone13
            self.size = .screen6Dot1Inches
            self.connectivity = .wiFi5G
            self.year = 2021
            
        case "iPhone14,2":
            self.type = .iPhone13Pro
            self.size = .screen6Dot1Inches
            self.connectivity = .wiFi5G
            self.year = 2021
            
        case "iPhone14,3":
            self.type = .iPhone13ProMax
            self.size = .screen6Dot7Inches
            self.connectivity = .wiFi5G
            self.year = 2021
            
        case "iPhone14,6":
            self.type = .iPhoneSE3
            self.size = .screen4Dot7Inches
            self.connectivity = .wiFi5G
            self.year = 2022

        // MARK: iPad

        case "iPad2,1":
            self.type = .iPad2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            self.year = 2011
            
        case "iPad2,2", "iPad2,3", "iPad2,4":
            self.type = .iPad2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi3G
            self.year = 2011
            
        case "iPad3,1":
            self.type = .iPad3
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            self.year = 2012
            
        case "iPad3,2", "iPad3,3":
            self.type = .iPad3
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2012
            
        case "iPad3,4":
            self.type = .iPad4
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            self.year = 2012
            
        case "iPad3,5", "iPad3,6":
            self.type = .iPad4
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2012
            
        case "iPad4,1":
            self.type = .iPadAir
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            self.year = 2013
            
        case "iPad4,2", "iPad4,3":
            self.type = .iPadAir
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2013
            
        case "iPad5,3":
            self.type = .iPadAir2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            self.year = 2014
            
        case "iPad5,4":
            self.type = .iPadAir2
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2014

        case "iPad6,11":
            self.type = .iPad5
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            self.year = 2017
            
        case "iPad6,12":
            self.type = .iPad5
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2017

        case "iPad7,5":
            self.type = .iPad6
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            self.year = 2018
            
        case "iPad7,6":
            self.type = .iPad6
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2018

        case "iPad7,11":
            self.type = .iPad7
            self.size = .screen10Dot2Inches
            self.connectivity = .wiFi
            self.year = 2019

        case "iPad7,12":
            self.type = .iPad7
            self.size = .screen10Dot2Inches
            self.connectivity = .wiFi4G
            self.year = 2019

        case "iPad11,3":
            self.type = .iPadAir3
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi
            self.year = 2019

        case "iPad11,4":
            self.type = .iPadAir3
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi4G
            self.year = 2019

        case "iPad11,6":
            self.type = .iPad8
            self.size = .screen10Dot2Inches
            self.connectivity = .wiFi
            self.year = 2020

        case "iPad11,7":
            self.type = .iPad8
            self.size = .screen10Dot2Inches
            self.connectivity = .wiFi4G
            self.year = 2020

        case "iPad13,1":
            self.type = .iPadAir4
            self.size = .screen10Dot9Inches
            self.connectivity = .wiFi
            self.year = 2020

        case "iPad13,2":
            self.type = .iPadAir4
            self.size = .screen10Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2020

        case "iPad12,1":
            self.type = .iPad9
            self.size = .screen10Dot2Inches
            self.connectivity = .wiFi
            self.year = 2021

        case "iPad12,2":
            self.type = .iPad9
            self.size = .screen10Dot2Inches
            self.connectivity = .wiFi4G
            self.year = 2021
            
        case "iPad13,16":
            self.type = .iPadAir5
            self.size = .screen10Dot9Inches
            self.connectivity = .wiFi
            self.year = 2022
            
        case "iPad13,17":
            self.type = .iPadAir5
            self.size = .screen10Dot9Inches
            self.connectivity = .wiFi5G
            self.year = 2022

        // MARK: iPad Pro

        case "iPad6,3":
            self.type = .iPadPro
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi
            self.year = 2016

        case "iPad6,4":
            self.type = .iPadPro
            self.size = .screen9Dot7Inches
            self.connectivity = .wiFi4G
            self.year = 2016

        case "iPad6,7":
            self.type = .iPadPro
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi
            self.year = 2015

        case "iPad6,8":
            self.type = .iPadPro
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2015

        case "iPad7,1":
            self.type = .iPadPro2
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi
            self.year = 2017

        case "iPad7,2":
            self.type = .iPadPro2
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2017

        case "iPad7,3":
            self.type = .iPadPro2
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi
            self.year = 2017

        case "iPad7,4":
            self.type = .iPadPro2
            self.size = .screen10Dot5Inches
            self.connectivity = .wiFi4G
            self.year = 2017

        case "iPad8,1":
            self.type = .iPadPro3
            self.size = .screen11Inches
            self.connectivity = .wiFi
            self.year = 2018

        case "iPad8,2":
            self.type = .iPadPro3
            self.size = .screen11Inches
            self.connectivity = .wiFi
            self.year = 2018

        case "iPad8,3":
            self.type = .iPadPro3
            self.size = .screen11Inches
            self.connectivity = .wiFi4G
            self.year = 2018

        case "iPad8,4":
            self.type = .iPadPro3
            self.size = .screen11Inches
            self.connectivity = .wiFi4G
            self.year = 2018

        case "iPad8,5":
            self.type = .iPadPro3
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi
            self.year = 2018

        case "iPad8,6":
            self.type = .iPadPro3
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi
            self.year = 2018

        case "iPad8,7":
            self.type = .iPadPro3
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2018

        case "iPad8,8":
            self.type = .iPadPro3
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2018

        case "iPad8,9":
            self.type = .iPadPro4
            self.size = .screen11Inches
            self.connectivity = .wiFi
            self.year = 2020

        case "iPad8,10":
            self.type = .iPadPro4
            self.size = .screen11Inches
            self.connectivity = .wiFi4G
            self.year = 2020

        case "iPad8,11":
            self.type = .iPadPro4
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi
            self.year = 2020

        case "iPad8,12":
            self.type = .iPadPro4
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2020
            
        case "iPad13,4", "iPad13,5":
            self.type = .iPadPro5
            self.size = .screen11Inches
            self.connectivity = .wiFi
            self.year = 2021
            
        case "iPad13,6", "iPad13,7":
            self.type = .iPadPro5
            self.size = .screen11Inches
            self.connectivity = .wiFi5G
            self.year = 2021
            
        case "iPad13,8", "iPad13,9":
            self.type = .iPadPro5
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi
            self.year = 2021
            
        case "iPad13,10", "iPad13,11":
            self.type = .iPadPro5
            self.size = .screen12Dot9Inches
            self.connectivity = .wiFi5G
            self.year = 2021

        // MARK: iPad mini

        case "iPad2,5":
            self.type = .iPadMini
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            self.year = 2012
            
        case "iPad2,6", "iPad2,7":
            self.type = .iPadMini
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi3G
            self.year = 2012
            
        case "iPad4,4":
            self.type = .iPadMini2
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            self.year = 2013
            
        case "iPad4,5", "iPad4,6":
            self.type = .iPadMini2
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2013
            
        case "iPad4,7":
            self.type = .iPadMini3
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            self.year = 2014
            
        case "iPad4,8", "iPad4,9":
            self.type = .iPadMini3
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2014
            
        case "iPad5,1":
            self.type = .iPadMini4
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            self.year = 2015
            
        case "iPad5,2":
            self.type = .iPadMini4
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2015

        case "iPad11,1":
            self.type = .iPadMini5
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi
            self.year = 2019

        case "iPad11,2":
            self.type = .iPadMini5
            self.size = .screen7Dot9Inches
            self.connectivity = .wiFi4G
            self.year = 2019

        case "iPad14,1":
            self.type = .iPadMini6
            self.size = .screen8Dot3Inches
            self.connectivity = .wiFi
            self.year = 2021

        case "iPad14,2":
            self.type = .iPadMini6
            self.size = .screen8Dot3Inches
            self.connectivity = .wiFi5G
            self.year = 2021

        // MARK: Other

        case "i386", "x86_64", "arm64":
            self.type = .simulator
            self.size = .screenUnknown
            self.connectivity = .wiFi
            self.year = -1
            
        default:
            self.type = .unknown
            self.size = .screenUnknown
            self.connectivity = .unknown
            self.year = -1
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
