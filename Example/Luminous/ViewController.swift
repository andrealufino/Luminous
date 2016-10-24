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
        print("isConnectedViaCellular: \(Luminous.System.Network.isConnectedViaCellular())")
        print("isConnectedViaWiFi: \(Luminous.System.Network.isConnectedViaWiFi())")
        print("SSID: \(Luminous.System.Network.SSID())")
        
        // MARK: Locale
        print("------------\nLocale\n------------")
        print("currentCountry: \(Luminous.System.Locale.currentCountry())")
        print("currentCurrency: \(Luminous.System.Locale.currentCurrency())")
        print("currentCurrencySymbol: \(Luminous.System.Locale.currentCurrencySymbol())")
        print("currentLanguage: \(Luminous.System.Locale.currentLanguage())")
        print("currentTimeZone: \(Luminous.System.Locale.currentTimeZone())")
        print("currentTimeZoneName: \(Luminous.System.Locale.currentTimeZoneName())")
        print("decimalSeparator: \(Luminous.System.Locale.decimalSeparator())")
        print("usesMetricSystem: \(Luminous.System.Locale.usesMetricSystem())")
        
        // MARK: Carrier
        print("------------\nCarrier\n------------")
        print("allowsVOIP: \(Luminous.System.Carrier.allowsVOIP())")
        print("ISOCountryCode: \(Luminous.System.Carrier.ISOCountryCode())")
        print("mobileCountryCode: \(Luminous.System.Carrier.mobileCountryCode())")
        print("name: \(Luminous.System.Carrier.name())")
        print("networkCountryCode: \(Luminous.System.Carrier.networkCountryCode())")
        
        // MARK: Hardware
        print("------------\nHardware\n------------")
        print("bootTime: \(Luminous.System.Hardware.bootTime())")
        print("bootTime: \(Luminous.System.Hardware.physicalMemory(withSizeScale: .megabytes))")
        print("processorsNumber: \(Luminous.System.Hardware.processorsNumber())")
        print("systemName: \(Luminous.System.Hardware.systemName())")
        print("systemVersion: \(Luminous.System.Hardware.systemVersion())")
        
        // MARK: Hardware - Screen
        print("------------\nScreen\n------------")
        print("bounds: \(Luminous.System.Hardware.Screen.bounds())")
        print("brightness: \(Luminous.System.Hardware.Screen.brightness())")
        print("isScreenMirrored: \(Luminous.System.Hardware.Screen.isScreenMirrored())")
        print("nativeBounds: \(Luminous.System.Hardware.Screen.nativeBounds())")
        print("nativeScale: \(Luminous.System.Hardware.Screen.nativeScale())")
        print("bounds: \(Luminous.System.Hardware.Screen.scale())")
//        print("snapshotOfCurrentView: \(Luminous.System.Hardware.Screen.snapshotOfCurrentView())")
        
        // MARK: Hardware - Device
        print("------------\nDevice\n------------")
        print("current: \(Luminous.System.Hardware.Device.current())")
        print("identifierForVendor: \(Luminous.System.Hardware.Device.identifierForVendor())")
        print("orientation: \(Luminous.System.Hardware.Device.orientation())")
        
        // MARK: Hardware - Accessory
        print("------------\nAccessory\n------------")
        print("connectedAccessories: \(Luminous.System.Hardware.Accessory.connectedAccessories())")
        print("connectedAccessoriesNames: \(Luminous.System.Hardware.Accessory.connectedAccessoriesNames())")
        print("count: \(Luminous.System.Hardware.Accessory.count())")
        print("isHeadsetPluggedIn: \(Luminous.System.Hardware.Accessory.isHeadsetPluggedIn())")
        
        // MARK: Disk
        print("------------\nDisk\n------------")
        print("freeSpace: \(Luminous.System.Disk.freeSpace())")
        print("freeSpaceInBytes: \(Luminous.System.Disk.freeSpaceInBytes())")
        print("totalSpace: \(Luminous.System.Disk.totalSpace())")
        print("totalSpaceInBytes: \(Luminous.System.Disk.totalSpaceInBytes())")
        print("usedSpace: \(Luminous.System.Disk.usedSpace())")
        print("usedSpaceInBytes: \(Luminous.System.Disk.usedSpaceInBytes())")
        
        // MARK: Battery
        print("------------\nBattery\n------------")
        print("level: \(Luminous.System.Battery.level())")
        print("state: \(Luminous.System.Battery.state())")
        
        // MARK: Application
        print("------------\nApplication\n------------")
        print("clipboardString: \(Luminous.System.Application.clipboardString())")
        print("version: \(Luminous.System.Application.version())")
        
        
        
        // MARK: Utils
        print("------------\nUtils\n------------")
        let emailAddress = "andrea.lufino@me.com"
        print("isEmailValid (andrea.lufino@me.com): \(Luminous.Utils.isEmailAddressValid(emailAddress))")
        print("saveObjectInUserDefaults: \(Luminous.Utils.saveObjectInUserDefaults("Hello", forKey: "hello"))")
        print("uniqueUUID: \(Luminous.Utils.uniqueUUID())")
        
        // MARK: AppConfiguration
        
        Luminous.AppConfiguration.currentConfiguration = .development
        Luminous.AppConfiguration.mainColor = UIColor.blue
        Luminous.AppConfiguration.secondColor = UIColor.black
        
        // You can do the same with the server vars to use in everywhere you need in the app
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

