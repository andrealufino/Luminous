[![CI Status](https://img.shields.io/travis/Andrea%20Mario%20Lufino/Deviice.svg?style=flat)](https://travis-ci.org/Andrea%20Mario%20Lufino/Deviice)
[![Version](https://img.shields.io/cocoapods/v/Deviice.svg?style=flat)](http://cocoapods.org/pods/Deviice)
[![License](https://img.shields.io/cocoapods/l/Deviice.svg?style=flat)](http://cocoapods.org/pods/Deviice)
[![Platform](https://img.shields.io/cocoapods/p/Deviice.svg?style=flat)](http://cocoapods.org/pods/Deviice)

![Logo](./Example/Deviice/Deviice.png)

## Version 2

The library has been completely rewritten from scratch. This version still offers the `Deviice` structure, but it has been marked as deprecated and will be removed in future versions. Now, the whole magic is done via the `Device` class. 

## Usage

There is documentation for all the classes, methods and properties in the code. 
To give a general idea, this is how things work. 

```swift
let device = Device.init()  // This instantiate a `Device` object based on the current device.

print(device.model.marketingName)   // This prints "iPhone 12 Pro" in case it is running on an iPhone 12 Pro

```

There is also the possibility to get the actual device being simulated on a Mac. 

```swift
let device = Device.init()

print(device.model.marketingName)           // This will print "Simulator"
print(device.actualModel.marketingName)     // This will print "iPhone 12 Pro" in case you're simulating an iPhone 12 Pro
```

With the first release, there's no chance to get the type of connectivity of a specific device. This will be probably added later. 

## Requirements
 
This library works on iOS 12 or higher.

## Installation

Deviice is available through Swift Package Manager and [CocoaPods](http://cocoapods.org).

### Swift Package Manager

You can add this library via Swift Package Manager, using this url `https://github.com/andrealufino/Deviice`.

### CocoaPods

To install
it, simply add the following line to your Podfile:

```ruby
pod "Deviice"
```

## Author

Andrea Mario Lufino, [andrealufino.com](https://andrealufino.com). Thanks to all the contributors.

## License

Deviice is available under the MIT license. See the LICENSE file for more info.
