//
//  Mapper.swift
//  Deviice
//
//  Created by Andrea Mario Lufino on 21/03/22.
//

import Foundation


// MARK: - Mapper

/// This structure allows to get specific information based on the passed parameter.
/// The idea is to offer something that can easily relate a `model` to some of its specific
/// properties.
public struct Mapper {
    
    // MARK: Model
    
    public static func model(from identifier: Identifier) -> Model {
        
        switch identifier {
            
        // MARK: iPods
        case .iPod1_1:                                      return .iPodTouch1
        case .iPod2_1:                                      return .iPodTouch2
        case .iPod3_1:                                      return .iPodTouch3
        case .iPod4_1:                                      return .iPodTouch4
        case .iPod5_1:                                      return .iPodTouch5
        case .iPod7_1:                                      return .iPodTouch6
        case .iPod9_1:                                      return .iPodTouch7
            
        // MARK: iPhones
        case .iPhone1_1:                                    return .iPhone2G
        case .iPhone1_2:                                    return .iPhone3G
        case .iPhone2_1:                                    return .iPhone3GS
        case .iPhone3_1, .iPhone3_2, .iPhone3_3:            return .iPhone4
        case .iPhone4_1:                                    return .iPhone4S
        case .iPhone5_1, .iPhone5_2:                        return .iPhone5
        case .iPhone5_3, .iPhone5_4:                        return .iPhone5C
        case .iPhone6_1, .iPhone6_2:                        return .iPhone5S
        case .iPhone7_1:                                    return .iPhone6Plus
        case .iPhone7_2:                                    return .iPhone6
        case .iPhone8_1:                                    return .iPhone6S
        case .iPhone8_2:                                    return .iPhone6sPlus
        case .iPhone8_4:                                    return .iPhoneSE
        case .iPhone9_1, .iPhone9_3:                        return .iPhone7
        case .iPhone9_2, .iPhone9_4:                        return .iPhone7Plus
        case .iPhone10_1, .iPhone10_4:                      return .iPhone8
        case .iPhone10_2, .iPhone10_5:                      return .iPhone8Plus
        case .iPhone10_3,.iPhone10_6:                       return .iPhoneX
        case .iPhone11_2:                                   return .iPhoneXS
        case .iPhone11_4, .iPhone11_6:                      return .iPhoneXsMax
        case .iPhone11_8:                                   return .iPhoneXr
        case .iPhone12_1:                                   return .iPhone11
        case .iPhone12_3:                                   return .iPhone11Pro
        case .iPhone12_5:                                   return .iPhone11ProMax
        case .iPhone12_8:                                   return .iPhoneSE2
        case .iPhone13_1:                                   return .iPhone12Mini
        case .iPhone13_2:                                   return .iPhone12
        case .iPhone13_3:                                   return .iPhone12Pro
        case .iPhone13_4:                                   return .iPhone12ProMax
        case .iPhone14_2:                                   return .iPhone13Pro
        case .iPhone14_3:                                   return .iPhone13ProMax
        case .iPhone14_4:                                   return .iPhone13Mini
        case .iPhone14_5:                                   return .iPhone13
        case .iPhone14_6:                                   return .iPhoneSE3
            
        // MARK: iPads
        case .iPad2_1, .iPad2_2, .iPad2_3, .iPad2_4:        return .iPad2
        case .iPad3_1, .iPad3_2, .iPad3_3:                  return .iPad3
        case .iPad3_4, .iPad3_5, .iPad3_6:                  return .iPad4
        case .iPad4_1, .iPad4_2, .iPad4_3:                  return .iPadAir
        case .iPad5_3, .iPad5_4:                            return .iPadAir2
        case .iPad6_11, .iPad6_12:                          return .iPad5
        case .iPad7_5, .iPad7_6:                            return .iPad6
        case .iPad7_11, .iPad7_12:                          return .iPad7
        case .iPad11_3, .iPad11_4:                          return .iPadAir3
        case .iPad11_6, .iPad11_7:                          return .iPad8
        case .iPad12_1, .iPad12_2:                          return .iPad9
        case .iPad13_1, .iPad13_2:                          return .iPadAir4
        case .iPad13_16, .iPad13_17:                        return .iPadAir5
            
        // MARK: iPad minis
        case .iPad2_5, .iPad2_6, .iPad2_7:                  return .iPadMini
        case .iPad4_4, .iPad4_5, .iPad4_6:                  return .iPadMini2
        case .iPad4_7, .iPad4_8, .iPad4_9:                  return .iPadMini3
        case .iPad5_1, .iPad5_2:                            return .iPadMini4
        case .iPad11_1, .iPad11_2:                          return .iPadMini5
        case .iPad14_1, .iPad14_2:                          return .iPadMini6
            
        // MARK: iPad Pros
        case .iPad6_3, .iPad6_4:                            return .iPadPro
        case .iPad6_7, .iPad6_8:                            return .iPadPro12Inch1
        case .iPad7_1, .iPad7_2:                            return .iPadPro12Inch2
        case .iPad7_3, .iPad7_4:                            return .iPadPro2
        case .iPad8_1, .iPad8_2, .iPad8_3, .iPad8_4:        return .iPadPro11Inch1
        case .iPad8_5, .iPad8_6, .iPad8_7, .iPad8_8:        return .iPadPro12Inch3
        case .iPad8_9, .iPad8_10:                           return .iPadPro11Inch2
        case .iPad8_11, .iPad8_12:                          return .iPadPro12Inch4
        case .iPad13_4, .iPad13_5, .iPad13_6, .iPad13_7:    return .iPadPro11Inch3
        case .iPad13_8, .iPad13_9, .iPad13_10, .iPad13_11:  return .iPadPro12Inch5
            
        // MARK: Simulators
        case .i386, .x86_64, .arm64:
            let id = Identifier.init(rawValue: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS")!
            return .simulator(Mapper.model(from: id))
            
        // MARK: Unknown
        case .unknown:                                      return .unknown
        }
    }
    
    // MARK: Family
    
    public static func family(from identifier: Identifier) -> Family {
        
        let rawId = identifier.rawValue.lowercased()
        
        switch rawId {
        case _ where rawId.contains("ipod"):
            return .iPodTouch
        case _ where rawId.contains("iphone"):
            return .iPhone
        case _ where rawId.contains("ipad"):
            return .iPad
        case _ where (
            rawId.contains("arm64") ||
            rawId.contains("i386") ||
            rawId.contains("x86_64")):
            return .simulator
        default:
            return .unknown
        }
    }
    
    // MARK: Screen Size
    
    public static func screenSize(from model: Model) -> ScreenSize {
        
        switch model {
            
        case .unknown:                                                  return .unknown
        // MARK: 3.5
        case .iPodTouch1, .iPodTouch2, .iPodTouch3, .iPodTouch4,
                .iPhone2G, .iPhone3G, .iPhone3GS:                       return .screen3Dot5Inch
        // MARK: 4
        case .iPodTouch5, .iPodTouch6, .iPodTouch7, .iPhone4,
                .iPhone4S, .iPhone5, .iPhone5C, .iPhone5S:              return .screen4Inch
        // MARK: 4.7
        case .iPhone6, .iPhone6S, .iPhoneSE, .iPhone7, .iPhone8,
                .iPhoneSE2, .iPhoneSE3:                                 return .screen4Dot7Inch
        // MARK: 5.5
        case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:   return .screen5Dot5Inch
        // MARK: 5.8
        case .iPhoneX, .iPhoneXS, .iPhone11Pro:                         return .screen5Dot8Inch
        // MARK: 6.5
        case .iPhoneXsMax, .iPhone11ProMax:                             return .screen6Dot5Inch
        // MARK: 6.1
        case .iPhoneXr, .iPhone11, .iPhone12, .iPhone13, .iPhone12Pro,
                .iPhone13Pro:                                           return .screen6Dot1Inch
        // MARK: 5.4
        case .iPhone12Mini, .iPhone13Mini:                              return .screen5Dot4Inch
        // MARK: 6.7
        case .iPhone12ProMax, .iPhone13ProMax:                          return .screen6Dot7Inch
        // MARK: 9.7
        case .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPadAir,
                .iPadAir2, .iPadPro:                                    return .screen9Dot7Inch
        // MARK: 10.5
        case .iPadAir3, .iPadPro2:                                      return .screen10Dot5Inch
        // MARK: 10.9
        case .iPadAir4, .iPadAir5:                                      return .screen10Dot9Inch
        // MARK: 10.2
        case .iPad7, .iPad8, .iPad9:                                    return .screen10Dot2Inch
        // MARK: 7.9
        case .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadMini5: return .screen7Dot9Inch
        // MARK: 8.3
        case .iPadMini6:                                                return .screen8Dot3Inch
        // MARK: 11
        case .iPadPro11Inch1, .iPadPro11Inch2, .iPadPro11Inch3:         return .screen11Inch
        // MARK: 12.9
        case .iPadPro12Inch1, .iPadPro12Inch2, .iPadPro12Inch3,
                .iPadPro12Inch4, .iPadPro12Inch5:                       return .screen12Dot9Inch
        // MARK: Simulator
        case .simulator:                                                return .unknown
        }
    }
}
