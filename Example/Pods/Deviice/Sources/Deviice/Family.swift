//
//  Family.swift
//  Deviice
//
//  Created by Andrea Mario Lufino on 06/11/21.
//

import Foundation


// MARK: - Family

/// This is the family of the device.
public enum Family: String {
    case iPodTouch
    case iPhone
    case iPad
    case simulator  = "Simulator"
    case unknown    = "Unknown"
}
