# Concept2-SDK

[![CI Status](http://img.shields.io/travis/BoutFitness/Concept2-SDK.svg?style=flat)](https://travis-ci.org/BoutFitness/Concept2-SDK)
[![Version](https://img.shields.io/cocoapods/v/Concept2-SDK.svg?style=flat)](http://cocoapods.org/pods/Concept2-SDK)
[![License](https://img.shields.io/cocoapods/l/Concept2-SDK.svg?style=flat)](http://cocoapods.org/pods/Concept2-SDK)
[![Platform](https://img.shields.io/cocoapods/p/Concept2-SDK.svg?style=flat)](http://cocoapods.org/pods/Concept2-SDK)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Concept2-SDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Concept2-SDK"
```

## Usage

Import the SDK

```swift
import Concept2_SDK
```

Implement the `BluetoothManagerDelegate` and create a `BluetoothManager`

```swift
let manager = Concept2_SDK.BluetoothManager(withDelegate: self)
```

Register for notifications from the `BluetoothManager` and the `PerformaneMonitor`

```swift
NSNotificationCenter.defaultCenter().addObserverForName(
  BluetoothManager.DidUpdateStateNotification,
  object: manager,
  queue: nil) { (notification) -> Void in
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      // Do something here...
    })
}

NSNotificationCenter.defaultCenter().addObserverForName(
  PerformanceMonitor.DidUpdateStateNotification,
  object:  nil,
  queue: nil) { (notification) -> Void in
    if let pm = notification.object as? PerformanceMonitor {
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        // Do something here...
      })
    }
}
```

Begin scanning for performance monitors (they'll need to be in-range and have wireless on)

```swift
manager.scanForPerformanceMonitors()
```

When performance monitors are found the `BluetoothManager` will let its delegate know

```swift
func didLoadPerformanceMonitors(bluetoothManager: BluetoothManager, performanceMonitors: Array<PerformanceMonitor>) {
  // Do something with the monitors, usually display in a list...
}
```

Connect to one of the performance monitors

```swift
// You'll want to stop scanning to save power
manager.stopScanningForPerformanceMonitors()

// Then connect to
let pm:PerformanceMonitor = performanceMonitors[indexOfMonitor]
manager.connectPerformanceMonitor(pm)
```

When the monitor connects it will register for notification of value updates, if you're interested in knowing when that happens register to receive updates from the `PerformanceMonitor`

```swift
NSNotificationCenter.defaultCenter().addObserverForName(
  PerformanceMonitor.DidUpdateValueNotification,
  object:  performanceMonitor, // This will limit notifications to one monitor, otherwise pass nil
  queue: nil) { (notification) -> Void in
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      // Pull any updated values from the PerfomanceMonitor
    })
}
```

You should now be able to see values streaming in.

## Author

jessecurry, jesse@jessecurry.net

## License

Concept2-SDK is available under the MIT license. See the LICENSE file for more info.
