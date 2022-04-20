# Luminous

![Luminous](./Example/luminous.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 12+
- Swift 5

## Installation

Luminous is available through Swift Package Manager and [CocoaPods](http://cocoapods.org).

### Swift Package Manager

Add `https://github.com/andrealufino/Luminous` as the URL of the library. [Deviice](https://github.com/andrealufino/Deviice) will also be imported. 

### CocoaPods

To install it, simply add the following line to your Podfile:

```ruby
pod "Luminous"
```

Then use `import Luminous` wherever you want to use the library.

## Dependencies

Luminous has only 1 dependency : [Deviice](https://github.com/andrealufino/Deviice) which is my other library useful to know on which device your app is running on, plus some nice information. This dependency is no more actually used since version 2.2.0, but it is still there when you add `Luminous`.

## Version 2.2.0 - Breaking Change

In version 2.2.0 I updated the `Luminous.Hardware.Device` structure, removing the `current` var that was returning a `Deviice` object. Given that the [Deviice](https://github.com/andrealufino/Deviice) library has been updated to version 2, I took the opportunity to make a change also here. So, Luminous still automatically download the [Deviice](https://github.com/andrealufino/Deviice) library, but it is not using it in the framework. If you want to get the `Deviice` (or, better, the new `Device`) object, you have to do it importing `Deviice` and use everything from there. 

## Migration to version 2

In version 2, I've changed some things and added others. An important change has been made to the structure of the library, useful for who wants to contribute to the project and to who wants to fork it. I created a specific file (`extension`) for every substruct. 

### Changed

- `LMBatteryState` has been renamed to `BatteryState`
- `LMSizeScale` has been renamed to `MeasureUnit`
- `Luminous.Carrier.allowsVOIP` has been renamed to `isVoipAllowed`
- `Luminous.Hardware.physicalMemory(withScale: _)` now returns a `Double` and no more a `Float`
- All the structs are now accessible using `Luminous.<substruct>` as I removed the `System` middleware struct since it became useless
- `NSLocale` is no more used in the library. I switched to `Locale`
- `Disk` substruct now has a new method to return the `totalSpace`, `freeSpace` and `usedSpace` that takes a `MeasureUnit` parameter as input. The old vars that returned `String` and percentage have been deprecated and will be removed in the next version

### Added

- `Audio` (thanks to [GregOriol](https://github.com/GregOriol))
    - `currentAudioOutputVolume`
    - `secondaryAudioShouldBeSilencedHint`
- `SystemVersion` (from version 2.1.0) : this has been added under the `Hardware` struct and represents the system version

## What is Luminous?

Luminous is the son of [ALSystemUtilities](https://github.com/andrealufino/ALSystemUtilities) library which is no longer maintained (it still is my best library on github). I got ideas from that one and I wrote everything from scratch in Swift adding some new feature and designing it in a different way thanks to the differences between Objective-C and Swift.

Luminous is a big library that I like to consider an "Helper Library". It provides a lot of information about the system and has some features that can speed up significantly the development process.

~~It is composed by 3 parts :~~
~~- system information (`Luminous.System.<substruct>`)~~
~~- utils (some handy method like the email check)~~
~~- custom app configuration~~

Luminous is no more composed by 3 parts as I think that a library has to serve one and one only purpose. I removed the Utils and AppConfiguration structs. I'm sorry for any kind of inconvenience this could cause to everyone is using it, but I think that it's the right choice.

### System information

Here I provide tons of information about the system and you can access them using the notation `Luminous.<substruct>`.

There are 11 different substructs here from which you can get information :
- `Network`
    - `isConnectedViaWiFi`
    - `isConnectedViaCellular`
    - `SSID` (deprecated on iOS 13)
- `Locale`
    - `currentLanguage`
    - `currentTimeZone`
    - `currentTimeZoneName`
    - `currentCountry`
    - `currentCurrency`
    - `currentCurrencySymbol`
    - `usesMetricSystem`
    - `decimalSeparator`
- `Carrier`
    - `name`
    - `ISOCountryCode`
    - `mobileCountryCode`
    - `networkCountryCode` (deprecated, use `mobileNetworkCode` instead)
    - `mobileNetworkCode`
    - `allowsVOIP`
- `Hardware`
    - `SystemVersion`  struct
    - `processorsNumber`
    - `activeProcessorsNumber`
    - `physicalMemory`
    - `systemName`
    - `systemVersion` (this is a `SystemVersion` struct from version 2.1.0, no more a `String`)
    - `bootTime`
    - `isLowPowerModeEnabled`
    - `Screen`
        - `brightness`
        - `isScreenMirrored`
        - `nativeBounds`
        - `nativeScale`
        - `bounds`
        - `scale`
        - `snapshotOfCurrentView`
    - `Device`
        - `current` (returns a [Deviice](https://github.com/andrealufino/Deviice) object)
        - `identifierForVendor`
        - `orientation`
    - `Accessory`
        - `count`
        - `connectedAccessoriesNames`
        - `connectedAccessories`
    - `Sensors`
        - `isAccelerometerAvailable`
        - `isGyroAvailable`
        - `isMagnetometerAvailable`
        - `isDeviceMotionAvailable`
- `Audio`
    - `currentAudioOutputVolume`
    - `secondaryAudioShouldBeSilencedHint`
- `Disk`
    - `totalSpace`
    - `freeSpace`
    - `usedSpace`
    - `totalSpaceInBytes`
    - `freeSpaceInBytes`
    - `usedSpaceInBytes`
    - `freeSpaceInPercentage`
    - `usedSpaceInPercentage`
- `Battery`
    - `level`
    - `state`
- `Application`
    - `version`
    - `build`
    - `completeAppVersion`
    - `clipboardString`

## Why Luminous?

I'm sure you're asking yourself "Why this library is called Luminous?". Well, stop think about it. The reason is simple : I like the word "Luminous", it gives me a unique feeling of something that is bright and awesome! So, I chose to call this lib in that way! But you can think that "Luminous is because this library will light up your way of development speeding up it and giving you more time for yourself", this is more philosophical.

## Help

Any suggestion would be really appreciated. The library is designed using structs and static functions, but I'm still not sure of this choice. I'm struggling if the best is to use static functions or static vars, so this is the first point you can help me with.

## Author

[Andrea Mario Lufino](https://andrealufino.com).

## License

Luminous is available under the MIT license. See the LICENSE file for more info.
