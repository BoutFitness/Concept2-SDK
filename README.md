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

*See the iOS Example for a full implementation*

Import the SDK

```swift
import Concept2_SDK
```

The Concept2_SDK uses `Subject` to provide notification of value changes. Attach to the `isReady` property on the `BluetoothManager` singleton.

```swift
var isReadyDisposable:Disposable?
var performanceMonitorsDisposable:Disposable?

// ...

isReadyDisposable = BluetoothManager.isReady.attach {
  [weak self] (isReady:Bool) -> Void in
  // Do something when the manager is ready, usually enable the UI
}

performanceMonitorsDisposable = BluetoothManager.performanceMonitors.attach {
  [weak self] (performanceMonitors) -> Void in
  // Do something with the performance monitors, usually display to the user or connect
}
```

Begin scanning for performance monitors (they'll need to be in-range and have wireless on)

```swift
BluetoothManager.scanForPerformanceMonitors()
```

When performance monitors are found observers of `performanceMonitors` on `BluetoothManager` will be notified, at this point you may connect to one of the performance monitors

```swift
// You'll want to stop scanning to save power
BluetoothManager.stopScanningForPerformanceMonitors()

// Then connect to
let pm:PerformanceMonitor = performanceMonitors[indexOfMonitor]
BluetoothManager.connectPerformanceMonitor(pm)
```

The `PerformanceMonitor` has its own set of observable properties. At this point in time a connected monitor will automatically register itself to receive notifications of all bluetooth characteristic change events. In the future only those properties that you've expressed an interest in will be flagged for characteristic change events.

Attach to the properties you're interested in, your callback will be called once upon attachment, then whenever the value of the observed property changes.

```swift
var strokesPerMinuteDisposable:Disposable?
var distanceDisposable:Disposable?

// ...

strokesPerMinuteDisposable = performanceMonitor?.strokeRate.attach({
  [weak self] (strokeRate:C2StrokeRate) -> Void in
  if let weakSelf = self {
    DispatchQueue.main.async {
      weakSelf.strokesPerMinuteLabel.text = "\(strokeRate)"
    })
  }
})

distanceDisposable = performanceMonitor?.distance.attach({
  [weak self] (distance:C2Distance) -> Void in
  if let weakSelf = self {
    DispatchQueue.main.async {
      weakSelf.distanceLabel.text = "\(distance)"
    })
  }
})
```

You should now be able to see values streaming in.

## Author

jessecurry, jesse@jessecurry.net

## License

Concept2-SDK is available under the MIT license. See the LICENSE file for more info.
