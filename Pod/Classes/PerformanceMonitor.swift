//
//  PerformanceMonitor.swift
//  Pods
//
//  Created by Jesse Curry on 9/27/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

public final class PerformanceMonitor: Hashable
{
  var peripheral:CBPeripheral {
    didSet {
      peripheral.delegate = peripheralDelegate
      peripheral.discoverServices([
        Service.DeviceInformation.UUID,
        Service.Control.UUID,
        Service.Rowing.UUID])
    }
  }
  let peripheralDelegate = PeripheralDelegate()
  
  // MARK: Initialization
  init(withPeripheral peripheral:CBPeripheral) {
    self.peripheral = peripheral
  }
  
  // MARK: Hashable
  public var hashValue: Int {
    get {
      return peripheral.hashValue
    }
  }
}

// MARK: Equatable
@warn_unused_result
public func ==(lhs:PerformanceMonitor, rhs:PerformanceMonitor) -> Bool {
  return (lhs.peripheral == rhs.peripheral)
}