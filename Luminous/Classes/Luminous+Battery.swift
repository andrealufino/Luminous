//
//  Luminous+Battery.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation


extension Luminous {
    
    // MARK: Battery
    
    /// Battery information
    public struct Battery {
        
        private static var device: UIDevice {
            get {
                let dev = UIDevice.current
                dev.isBatteryMonitoringEnabled = true
                
                return dev
            }
        }
        
        /// The current level of the battery
        public static var level: Float? {
            
            let batteryCharge = device.batteryLevel
            if batteryCharge > 0 {
                return batteryCharge * 100
            } else {
                return nil
            }
        }
        
        /// The current battery state of the device
        public static var state: BatteryState {
            
            switch device.batteryState {
            case .unknown:
                return BatteryState.unknown
            case .unplugged:
                return BatteryState.unplugged
            case .charging:
                return BatteryState.charging
            case .full:
                return BatteryState.full
            }
        }
    }
}
