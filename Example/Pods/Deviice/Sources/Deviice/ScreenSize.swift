//
//  ScreenSize.swift
//  Deviice
//
//  Created by Andrea Mario Lufino on 05/11/21.
//

import Foundation


// MARK: - Screen Size

/// This is the screen size of the device.
public enum ScreenSize: String {
    
    case unknown                = "Unknown"
    case screen3Dot5Inch        = "3,5 inch"
    case screen4Inch            = "4 inch"
    case screen4Dot7Inch        = "4,7 inch"
    case screen5Dot4Inch        = "5,4 inch"
    case screen5Dot5Inch        = "5,5 inch"
    case screen5Dot8Inch        = "5,8 inch"
    case screen6Dot1Inch        = "6,1 inch"
    case screen6Dot5Inch        = "6,5 inch"
    case screen6Dot7Inch        = "6,7 inch"
    case screen7Dot9Inch        = "7,9 inch"
    case screen8Dot3Inch        = "8,3 inch"
    case screen9Dot7Inch        = "9,7 inch"
    case screen10Dot2Inch       = "10,2 inch"
    case screen10Dot5Inch       = "10,5 inch"
    case screen10Dot9Inch       = "10,9 inch"
    case screen11Inch           = "11 inch"
    case screen12Dot9Inch       = "12,9 inch"
    
    /// This is the value as `Double` of the screen size.
    var value: Double {
        switch self {
        case .screen3Dot5Inch:          return 3.5
        case .screen4Inch:              return 4
        case .screen4Dot7Inch:          return 4.7
        case .screen5Dot4Inch:          return 5.4
        case .screen5Dot5Inch:          return 5.5
        case .screen5Dot8Inch:          return 5.8
        case .screen6Dot1Inch:          return 6.1
        case .screen6Dot5Inch:          return 6.5
        case .screen6Dot7Inch:          return 6.7
        case .screen7Dot9Inch:          return 7.9
        case .screen8Dot3Inch:          return 8.3
        case .screen9Dot7Inch:          return 9.7
        case .screen10Dot2Inch:         return 10.2
        case .screen10Dot5Inch:         return 10.5
        case .screen10Dot9Inch:         return 10.9
        case .screen11Inch:             return 11
        case .screen12Dot9Inch:         return 12.9
        case .unknown:                  return 0
        default:                        return 0
        }
    }
}


// MARK: - Comparable

extension ScreenSize: Comparable {
    
    public static func < (lhs: ScreenSize, rhs: ScreenSize) -> Bool {
        return lhs.value < rhs.value
    }
    
    public static func ==(lhs: ScreenSize, rhs: ScreenSize) -> Bool {
        return lhs.value == rhs.value
    }
}
