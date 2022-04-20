//
//  Groups.swift
//  Deviice
//
//  Created by Andrea Mario Lufino on 07/11/21.
//

import Foundation


// MARK: - Groups

/// This structure is intended to offer groups of devices as static vars.
public struct Groups {
    
    /// All the iPods.
    static var iPods: [Model] {
        return [
            .iPodTouch1, .iPodTouch2, .iPodTouch3, .iPodTouch4,
            .iPodTouch5, .iPodTouch6, .iPodTouch7
        ]
    }
    
    /// All the iPhones.
    static var iPhones: [Model] {
        return [
            .iPhone2G,
            .iPhone3G,
            .iPhone3GS,
            .iPhone4,
            .iPhone4S,
            .iPhone5,
            .iPhone5C,
            .iPhone5S,
            .iPhone6,
            .iPhone6Plus,
            .iPhone6S,
            .iPhone6sPlus,
            .iPhoneSE,
            .iPhone7,
            .iPhone7Plus,
            .iPhone8,
            .iPhone8Plus,
            .iPhoneX,
            .iPhoneXS,
            .iPhoneXsMax,
            .iPhoneXr,
            .iPhone11,
            .iPhone11Pro,
            .iPhone11ProMax,
            .iPhoneSE2,
            .iPhone12Mini,
            .iPhone12,
            .iPhone12Pro,
            .iPhone12ProMax,
            .iPhone13Mini,
            .iPhone13,
            .iPhone13Pro,
            .iPhone13ProMax,
            .iPhoneSE3
        ]
    }
    
    /// All the iPads.
    static var iPads: [Model] {
        return [
            // iPad
            .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPad7, .iPad8, .iPad9,
            // iPad Air
            .iPadAir, .iPadAir2, .iPadAir3, .iPadAir4, .iPadAir5,
            // iPad Mini
            .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadMini5,
            .iPadMini6,
            // iPad Pro
            .iPadPro, .iPadPro2,
            // iPad Pro 12.9
            .iPadPro12Inch1, .iPadPro12Inch2, .iPadPro12Inch3,
            .iPadPro12Inch4, .iPadPro12Inch5,
            // iPad Pro 11
            .iPadPro11Inch1, .iPadPro11Inch2, .iPadPro11Inch3
        ]
    }
    
    /// All the plus sized devices.
    static var plusDevices: [Model] {
        return [
            .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus,
            .iPhoneXsMax, .iPhone11ProMax, .iPhone12ProMax, .iPhone13ProMax
        ]
    }
    
    /// All the pro devices.
    static var proDevices: [Model] {
        return [
            // iPhone
            .iPhone11Pro, .iPhone11ProMax, .iPhone12Pro, .iPhone12ProMax,
            .iPhone13Pro, .iPhone13ProMax,
            // iPad Pro
            .iPadPro, .iPadPro2,
            // iPad Pro 12.9
            .iPadPro12Inch1, .iPadPro12Inch2, .iPadPro12Inch3, .iPadPro12Inch4,
            .iPadPro12Inch5,
            // iPad Pro 11
            .iPadPro11Inch1, .iPadPro11Inch2, .iPadPro11Inch3
        ]
    }
    
    /// All the mini devices.
    static var miniDevices: [Model] {
        return [
            // iPhone
            .iPhone12Mini, .iPhone13Mini,
            // iPad
            .iPadMini, .iPadMini2, .iPadMini3,
            .iPadMini4, .iPadMini5, .iPadMini6
        ]
    }
}
