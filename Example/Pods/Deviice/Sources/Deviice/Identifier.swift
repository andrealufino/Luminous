//
//  Identifier.swift
//  Deviice
//
//  Created by Andrea Mario Lufino on 06/11/21.
//

import Foundation


// MARK: - Identifier

/// This enumeration represents an identifier.
public enum Identifier: String, CaseIterable {
    
    // MARK: iPod
    case iPod1_1            = "iPod1,1"
    case iPod2_1            = "iPod2,1"
    case iPod3_1            = "iPod3,1"
    case iPod4_1            = "iPod4,1"
    case iPod5_1            = "iPod5,1"
    case iPod7_1            = "iPod7,1"
    case iPod9_1            = "iPod9,1"
    
    // MARK: iPhone
    case iPhone1_1          = "iPhone1,1"
    case iPhone1_2          = "iPhone1,2"
    case iPhone2_1          = "iPhone2,1"
    case iPhone3_1          = "iPhone3,1"
    case iPhone3_2          = "iPhone3,2"
    case iPhone3_3          = "iPhone3,3"
    case iPhone4_1          = "iPhone4,1"
    case iPhone5_1          = "iPhone5,1"
    case iPhone5_2          = "iPhone5,2"
    case iPhone5_3          = "iPhone5,3"
    case iPhone5_4          = "iPhone5,4"
    case iPhone6_1          = "iPhone6,1"
    case iPhone6_2          = "iPhone6,2"
    case iPhone7_1          = "iPhone7,1"
    case iPhone7_2          = "iPhone7,2"
    case iPhone8_1          = "iPhone8,1"
    case iPhone8_2          = "iPhone8,2"
    case iPhone8_4          = "iPhone 8,4"
    case iPhone9_1          = "iPhone9,1"
    case iPhone9_2          = "iPhone9,2"
    case iPhone9_3          = "iPhone9,3"
    case iPhone9_4          = "iPhone9,4"
    case iPhone10_1         = "iPhone10,1"
    case iPhone10_2         = "iPhone10,2"
    case iPhone10_3         = "iPhone10,3"
    case iPhone10_4         = "iPhone10,4"
    case iPhone10_5         = "iPhone10,5"
    case iPhone10_6         = "iPhone10,6"
    case iPhone11_2         = "iPhone11,2"
    case iPhone11_4         = "iPhone11,4"
    case iPhone11_6         = "iPhone11,6"
    case iPhone11_8         = "iPhone11,8"
    case iPhone12_1         = "iPhone12,1"
    case iPhone12_3         = "iPhone12,3"
    case iPhone12_5         = "iPhone12,5"
    case iPhone12_8         = "iPhone12,8"
    case iPhone13_1         = "iPhone13,1"
    case iPhone13_2         = "iPhone13,2"
    case iPhone13_3         = "iPhone13,3"
    case iPhone13_4         = "iPhone13,4"
    case iPhone14_2         = "iPhone14,2"
    case iPhone14_3         = "iPhone14,3"
    case iPhone14_4         = "iPhone14,4"
    case iPhone14_5         = "iPhone14,5"
    case iPhone14_6         = "iPhone14,6"
    
    // MARK: iPad
    case iPad2_1            = "iPad2,1"
    case iPad2_2            = "iPad2,2"
    case iPad2_3            = "iPad2,3"
    case iPad2_4            = "iPad2,4"
    case iPad3_1            = "iPad3,1"
    case iPad3_2            = "iPad3,2"
    case iPad3_3            = "iPad3,3"
    case iPad3_4            = "iPad3,4"
    case iPad3_5            = "iPad3,5"
    case iPad3_6            = "iPad3,6"
    case iPad4_1            = "iPad4,1"
    case iPad4_2            = "iPad4,2"
    case iPad4_3            = "iPad4,3"
    case iPad5_3            = "iPad5,3"
    case iPad5_4            = "iPad5,4"
    case iPad6_11           = "iPad6,11"
    case iPad6_12           = "iPad6,12"
    case iPad7_5            = "iPad7,5"
    case iPad7_6            = "iPad7,6"
    case iPad7_11           = "iPad7,11"
    case iPad7_12           = "iPad7,12"
    case iPad11_3           = "iPad11,3"
    case iPad11_4           = "iPad11,4"
    case iPad11_6           = "iPad11,6"
    case iPad11_7           = "iPad11,7"
    case iPad12_1           = "iPad12,1"
    case iPad12_2           = "iPad12,2"
    case iPad13_1           = "iPad13,1"
    case iPad13_2           = "iPad13,2"
    case iPad13_16          = "iPad13,16"
    case iPad13_17          = "iPad13,17"
    
    // MARK: iPad Mini
    case iPad2_5            = "iPad2,5"
    case iPad2_6            = "iPad2,6"
    case iPad2_7            = "iPad2,7"
    case iPad4_4            = "iPad4,4"
    case iPad4_5            = "iPad4,5"
    case iPad4_6            = "iPad4,6"
    case iPad4_7            = "iPad4,7"
    case iPad4_8            = "iPad4,8"
    case iPad4_9            = "iPad4,9"
    case iPad5_1            = "iPad5,1"
    case iPad5_2            = "iPad5,2"
    case iPad11_1           = "iPad11,1"
    case iPad11_2           = "iPad11,2"
    case iPad14_1           = "iPad14,1"
    case iPad14_2           = "iPad14,2"
    
    // MARK: iPad Pro
    case iPad6_3            = "iPad6,3"
    case iPad6_4            = "iPad6,4"
    case iPad6_7            = "iPad6,7"
    case iPad6_8            = "iPad6,8"
    case iPad7_1            = "iPad7,1"
    case iPad7_2            = "iPad7,2"
    case iPad7_3            = "iPad7,3"
    case iPad7_4            = "iPad7,4"
    case iPad8_1            = "iPad8,1"
    case iPad8_2            = "iPad8,2"
    case iPad8_3            = "iPad8,3"
    case iPad8_4            = "iPad8,4"
    case iPad8_5            = "iPad8,5"
    case iPad8_6            = "iPad8,6"
    case iPad8_7            = "iPad8,7"
    case iPad8_8            = "iPad8,8"
    case iPad8_9            = "iPad8,9"
    case iPad8_10           = "iPad8,10"
    case iPad8_11           = "iPad8,11"
    case iPad8_12           = "iPad8,12"
    case iPad13_4           = "iPad13,4"
    case iPad13_5           = "iPad13,5"
    case iPad13_6           = "iPad13,6"
    case iPad13_7           = "iPad13,7"
    case iPad13_8           = "iPad13,8"
    case iPad13_9           = "iPad13,9"
    case iPad13_10          = "iPad13,10"
    case iPad13_11          = "iPad13,11"
    
    // MARK: Simulator
    case i386               = "i386"
    case x86_64             = "x86_64"
    case arm64              = "arm64"
    
    // MARK: Unknown
    case unknown
}


// MARK: - Public

extension Identifier {
    
    /// This is the identifier of the current device.
    static var current: Identifier {
        return Identifier.init(rawValue: rawIdentifier) ?? .unknown
    }
}


// MARK: - Private

private extension Identifier {
    
    /// This is the raw identifier, as `String`.
    static var rawIdentifier: String = {
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
        
        return identifier
    }()
}
