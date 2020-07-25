//
//  ViewController.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/20/2016.
//  Copyright (c) 2016 Andrea Mario Lufino. All rights reserved.
//

import UIKit
import Luminous

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // MARK: Network
        
        print("------------\nNetwork\n------------")
        print("isConnectedViaCellular: \(Luminous.Network.isConnectedViaCellular)")
        print("isConnectedViaWiFi: \(Luminous.Network.isConnectedViaWiFi)")
        print("SSID: \(Luminous.Network.SSID)")
        
        
        // MARK: Locale
        
        print("------------\nLocale\n------------")
        print("currentCountry: \(Luminous.Locale.currentCountry)")
        print("currentCurrency: \(Luminous.Locale.currentCurrency ?? "-")")
        print("currentCurrencySymbol: \(Luminous.Locale.currentCurrencySymbol ?? "-")")
        print("currentLanguage: \(Luminous.Locale.currentLanguage)")
        print("currentTimeZone: \(Luminous.Locale.currentTimeZone)")
        print("currentTimeZoneName: \(Luminous.Locale.currentTimeZoneName)")
        print("decimalSeparator: \(Luminous.Locale.decimalSeparator ?? "-")")
        print("usesMetricSystem: \(Luminous.Locale.usesMetricSystem)")
        
        
        // MARK: Carrier
        
        print("------------\nCarrier\n------------")
        print("allowsVOIP: \(Luminous.Carrier.isVoipAllowed ?? false)")
        print("ISOCountryCode: \(Luminous.Carrier.ISOCountryCode ?? "-")")
        print("mobileCountryCode: \(Luminous.Carrier.mobileCountryCode ?? "-")")
        print("name: \(Luminous.Carrier.name ?? "-")")
        print("networkCountryCode: \(Luminous.Carrier.mobileNetworkCode ?? "-")")
        
        
        // MARK: Hardware
        
        print("------------\nHardware\n------------")
        print("bootTime: \(Luminous.Hardware.bootTime)")
        print("bootTime: \(Luminous.Hardware.physicalMemory(with: Luminous.MeasureUnit.megabytes))")
        print("processorsNumber: \(Luminous.Hardware.processorsNumber)")
        print("systemName: \(Luminous.Hardware.systemName)")
        print("systemVersion: \(Luminous.Hardware.systemVersion)")
        print("isOperatingSystemAtLeastVersion \(Luminous.Hardware.isOperatingSystemAtLeastVersion("13"))")
        if #available(iOS 9.0, *) {
            print("isLowPowerModeEnabled: \(Luminous.Hardware.isLowPowerModeEnabled)")
        }
        
        
        // MARK: Hardware - Screen
        
        print("------------\nScreen\n------------")
        print("bounds: \(Luminous.Hardware.Screen.bounds)")
        print("brightness: \(Luminous.Hardware.Screen.brightness)")
        print("isScreenMirrored: \(Luminous.Hardware.Screen.isScreenMirrored)")
        print("nativeBounds: \(Luminous.Hardware.Screen.nativeBounds)")
        print("nativeScale: \(Luminous.Hardware.Screen.nativeScale)")
        print("bounds: \(Luminous.Hardware.Screen.scale)")
//        print("snapshotOfCurrentView: \(Luminous.Hardware.Screen.snapshotOfCurrentView())")
        
        
        // MARK: Hardware - Device
        
        print("------------\nDevice\n------------")
        print("current: \(Luminous.Hardware.Device.current)")
        print("identifierForVendor: \(Luminous.Hardware.Device.identifierForVendor ?? "-")")
        print("orientation: \(Luminous.Hardware.Device.orientation)")
        
        
        // MARK: Hardware - Accessory
        
        print("------------\nAccessory\n------------")
        print("connectedAccessories: \(Luminous.Hardware.Accessory.connectedAccessories)")
        print("connectedAccessoriesNames: \(Luminous.Hardware.Accessory.connectedAccessoriesNames)")
        print("count: \(Luminous.Hardware.Accessory.count)")
        print("isHeadsetPluggedIn: \(Luminous.Hardware.Accessory.isHeadsetPluggedIn)")
        
        
        // MARK: Hardware - Sensors
        
        print("------------\nSensors\n------------")
        print("isAccelerometerAvailable : \(Luminous.Hardware.Sensors.isAccelerometerAvailable)")
        print("isGyroAvailable : \(Luminous.Hardware.Sensors.isGyroAvailable)")
        print("isMagnetometerAvailable : \(Luminous.Hardware.Sensors.isMagnetometerAvailable)")
        print("isDeviceMotionAvailable : \(Luminous.Hardware.Sensors.isDeviceMotionAvailable)")
        
        
        // MARK: Audio
        
        print("------------\nAudio\n------------")
        print("currentAudioOutputVolume : \(Luminous.Audio.currentAudioOutputVolume ?? -1.0)")
        print("secondaryAudioShouldBeSilencedHint : \(Luminous.Audio.secondaryAudioShouldBeSilencedHint)")
        
        
        // MARK: Disk
        
        print("------------\nDisk\n------------")
        print("freeSpace: \(Luminous.Disk.freeSpace)")
        print("freeSpaceInBytes: \(Luminous.Disk.freeSpaceInBytes)")
        print("totalSpace: \(Luminous.Disk.totalSpace)")
        print("totalSpaceInBytes: \(Luminous.Disk.totalSpaceInBytes)")
        print("usedSpace: \(Luminous.Disk.usedSpace)")
        print("usedSpaceInBytes: \(Luminous.Disk.usedSpaceInBytes)")
        print("freeSpaceInPercentage: \(Luminous.Disk.freeSpaceInPercentage)%")
        print("usedSpaceInPercentage: \(Luminous.Disk.usedSpaceInPercentage)%")
        
        
        // MARK: Battery
        
        print("------------\nBattery\n------------")
        print("level: \(Luminous.Battery.level ?? -1)")
        print("state: \(Luminous.Battery.state)")
        
        
        // MARK: Application
        
        print("------------\nApplication\n------------")
        print("clipboardString: \(Luminous.Application.clipboardString ?? "-")")
        print("version: \(Luminous.Application.version)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

