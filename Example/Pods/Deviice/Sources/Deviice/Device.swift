//
//  Device.swift
//  Deviice
//
//  Created by Andrea Mario Lufino on 05/11/21.
//

import Foundation
import CoreVideo
import UIKit


// MARK: - Device

/// This class represents a device.
///
/// You can use the `init` method to get an instance that represents the current device,
/// or you can create a specific device passing an `Identifier`.
public class Device {
    
    /// The identifier of a specific model.
    public let identifier: Identifier
    /// The family of the device, such as `iPhone`, `iPad`, etc...
    public private(set) var family: Family
//    private(set) var connectivity: Connectivity
    /// The model of the device, such as `iPhone 12 Pro`, `iPad Pro`, etc...
    public private(set) var model: Model
    /// The size of the screen.
    public private(set) var screenSize: ScreenSize
    
    /// Init a `Device` object with an optional identifier.
    /// If the `identifier` parameter is omitted, an object representing
    /// the current device will be created.
    /// - Parameter identifier: The identifier of the model to create.
    public init(identifier: Identifier? = nil) {
        
        self.identifier = identifier ?? Identifier.current
        
        let id = self.identifier
        
        family = Mapper.family(from: id)
        model = Mapper.model(from: id)
        screenSize = Mapper.screenSize(from: model)
    }
}


// MARK: - Device info

public extension Device {
    
    /// Check if the current device is an iPod.
    var isPod: Bool {
        return family == .iPodTouch
    }
    
    /// Check if the current device is an iPhone.
    var isPhone: Bool {
        return family == .iPhone
    }
    
    /// Check if the current device is an iPad.
    var isPad: Bool {
        return family == .iPad
    }
    
    /// Check if the current device is a simulator.
    var isSimulator: Bool {
        return family == .simulator
    }
    
    /// Check if the current device has a retina display.
    var isRetina: Bool {
        return UIScreen.main.scale > 1.0
    }
    
    /// The actual model of the device. This returns the same model if run of real device,
    /// and the simulated device in case of the simulator.
    var actualModel: Model {
        
        switch model {
        case .simulator(let model):
            return model
        default:
            return model
        }
    }
    
    /// This is the name of the device.
    var name: String {
        
//        #if os(watchOS)
//        return WKInterfaceDevice.current().name
//        #else
        return UIDevice.current.name
//        #endif
    }
    
    /// This is the name of the operating system.
    var osName: String {
        
//      #if os(watchOS)
//      return WKInterfaceDevice.current().systemName
//      #else
      return UIDevice.current.systemName
//      #endif
    }
    
    /// This is the version of the operating system.
    var osVersion: String? {
      
//      #if os(watchOS)
//      return WKInterfaceDevice.current().systemVersion
//      #else
      return UIDevice.current.systemVersion
//      #endif
    }
}


// MARK: - Description

extension Device: CustomStringConvertible {
    
    public var description: String {
        return """
        Device
        \(identifier.rawValue)
        \(model.marketingName)
        Screen size: \(screenSize.value)
        """
    }
}
