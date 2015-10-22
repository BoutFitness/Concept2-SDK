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
  
  public var peripheralName:String { get { return peripheral.name ?? "Unknown" } }
  public var peripheralIdentifier:String { get { return peripheral.identifier.UUIDString } }
  
  // MARK: Initialization
  init(withPeripheral peripheral:CBPeripheral) {
    peripheral.delegate = peripheralDelegate
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