//
//  PerformanceMonitor.swift
//  Pods
//
//  Created by Jesse Curry on 9/27/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

public final class PerformanceMonitor
{
  var peripheral:CBPeripheral
  let peripheralDelegate = PeripheralDelegate()
  
  // MARK: Initialization
  init(withPeripheral peripheral:CBPeripheral) {
    peripheral.delegate = peripheralDelegate
    peripheral.discoverServices([
      Service.DeviceInformation.UUID,
      Service.Control.UUID,
      Service.Rowing.UUID])
    self.peripheral = peripheral
  }
}

// MARK: Equatable
@warn_unused_result
public func ==(lhs:PerformanceMonitor, rhs:PerformanceMonitor) -> Bool {
  return (lhs.peripheral == rhs.peripheral)
}

// MARK: Hashable
extension PerformanceMonitor: Hashable {
  public var hashValue: Int {
    get {
      return peripheral.hashValue
    }
  }
}