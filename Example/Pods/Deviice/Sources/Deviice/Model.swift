//
//  Model.swift
//  Deviice
//
//  Created by Andrea Mario Lufino on 05/11/21.
//

import Foundation


// MARK: - Model

/// This is the model of the device.
public enum Model {
    
    case unknown
            
    // MARK: iPod
    case iPodTouch1
    case iPodTouch2
    case iPodTouch3
    case iPodTouch4
    case iPodTouch5
    case iPodTouch6
    case iPodTouch7
            
    // MARK: iPhone
    case iPhone2G
    case iPhone3G
    case iPhone3GS
    case iPhone4
    case iPhone4S
    case iPhone5
    case iPhone5C
    case iPhone5S
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6sPlus
    case iPhoneSE
    case iPhone7
    case iPhone7Plus
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXsMax
    case iPhoneXr
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax
    case iPhoneSE2
    case iPhone12Mini
    case iPhone12
    case iPhone12Pro
    case iPhone12ProMax
    case iPhone13Mini
    case iPhone13
    case iPhone13Pro
    case iPhone13ProMax
    case iPhoneSE3
            
    // MARK: iPad
    case iPad2
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPadAir3
    case iPadAir4
    case iPadAir5
    case iPad5
    case iPad6
    case iPad7
    case iPad8
    case iPad9
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadMini5
    case iPadMini6
    case iPadPro
    case iPadPro2
    case iPadPro11Inch1
    case iPadPro11Inch2
    case iPadPro11Inch3
    case iPadPro12Inch1
    case iPadPro12Inch2
    case iPadPro12Inch3
    case iPadPro12Inch4
    case iPadPro12Inch5
            
    // MARK: Simulator
    indirect case simulator(Model)
}


// MARK: - Marketing name

public extension Model {
    
    /// This is the marketing name of the device, such as "iPhone 12 Pro".
    var marketingName: String {
        switch self {
        case .unknown:                          return "Unknown"
                
        // MARK: iPod
        case .iPodTouch1:                       return "iPod Touch 1"
        case .iPodTouch2:                       return "iPod Touch 2"
        case .iPodTouch3:                       return "iPod Touch 3"
        case .iPodTouch4:                       return "iPod Touch 4"
        case .iPodTouch5:                       return "iPod Touch 5"
        case .iPodTouch6:                       return "iPod Touch 6"
        case .iPodTouch7:                       return "iPod Touch 7"
                
        // MARK: iPhone
        case .iPhone2G:                         return "iPhone 2G"
        case .iPhone3G:                         return "iPhone 3G"
        case .iPhone3GS:                        return "iPhone 3GS"
        case .iPhone4:                          return "iPhone 4"
        case .iPhone4S:                         return "iPhone 4S"
        case .iPhone5:                          return "iPhone 5"
        case .iPhone5C:                         return "iPhone 5C"
        case .iPhone5S:                         return "iPhone 5S"
        case .iPhone6:                          return "iPhone 6"
        case .iPhone6Plus:                      return "iPhone 6 Plus"
        case .iPhone6S:                         return "iPhone 6S"
        case .iPhone6sPlus:                     return "iPhone 6s Plus"
        case .iPhoneSE:                         return "iPhone SE"
        case .iPhone7:                          return "iPhone 7"
        case .iPhone7Plus:                      return "iPhone 7 Plus"
        case .iPhone8:                          return "iPhone 8"
        case .iPhone8Plus:                      return "iPhone 8 Plus"
        case .iPhoneX:                          return "iPhone X"
        case .iPhoneXS:                         return "iPhone XS"
        case .iPhoneXsMax:                      return "iPhone XS Max"
        case .iPhoneXr:                         return "iPhone XR"
        case .iPhone11:                         return "iPhone 11"
        case .iPhone11Pro:                      return "iPhone 11 Pro"
        case .iPhone11ProMax:                   return "iPhone 11 Pro Max"
        case .iPhoneSE2:                        return "iPhone SE (2nd generation)"
        case .iPhone12Mini:                     return "iPhone 12 Mini"
        case .iPhone12:                         return "iPhone 12"
        case .iPhone12Pro:                      return "iPhone 12 Pro"
        case .iPhone12ProMax:                   return "iPhone 12 Pro Max"
        case .iPhone13Mini:                     return "iPhone 13 Mini"
        case .iPhone13:                         return "iPhone 13"
        case .iPhone13Pro:                      return "iPhone 13 Pro"
        case .iPhone13ProMax:                   return "iPhone 13 Pro Max"
        case .iPhoneSE3:                        return "iPhone SE (3rd generation)"
                
        // MARK: iPad
        case .iPad2:                            return "iPad 2"
        case .iPad3:                            return "iPad 3"
        case .iPad4:                            return "iPad 4"
        case .iPadAir:                          return "iPad Air"
        case .iPadAir2:                         return "iPad Air 2"
        case .iPadAir3:                         return "iPad Air 3"
        case .iPadAir4:                         return "iPad Air 4"
        case .iPadAir5:                         return "iPad Air 5"
        case .iPad5:                            return "iPad 5"
        case .iPad6:                            return "iPad 6"
        case .iPad7:                            return "iPad 7"
        case .iPad8:                            return "iPad 8"
        case .iPad9:                            return "iPad 9"
        case .iPadMini:                         return "iPad mini"
        case .iPadMini2:                        return "iPad mini 2"
        case .iPadMini3:                        return "iPad mini 3"
        case .iPadMini4:                        return "iPad mini 4"
        case .iPadMini5:                        return "iPad mini 5"
        case .iPadMini6:                        return "iPad mini 6"
        case .iPadPro:                          return "iPad Pro"
        case .iPadPro2:                         return "iPad Pro (2nd generation)"
        case .iPadPro11Inch1:                   return "iPad Pro 11'"
        case .iPadPro11Inch2:                   return "iPad Pro 11' (2nd generation)"
        case .iPadPro11Inch3:                   return "iPad Pro 11' (3rd generation)"
        case .iPadPro12Inch1:                   return "iPad Pro 12.9"
        case .iPadPro12Inch2:                   return "iPad Pro 12.9 (2nd generation)"
        case .iPadPro12Inch3:                   return "iPad Pro 12.9 (3rd generation)"
        case .iPadPro12Inch4:                   return "iPad Pro 12.9 (4th generation)"
        case .iPadPro12Inch5:                   return "iPad Pro 12.9 (5th generation)"
            
        case .simulator:                        return "Simulator"
        }
    }
}
