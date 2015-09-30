//
//  PerformanceMonitor.swift
//  Pods
//
//  Created by Jesse Curry on 9/27/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth


public final class PerformanceMonitor: NSObject, CBPeripheralDelegate
{
  var peripheral:CBPeripheral {
    didSet {
      peripheral.delegate = self
      peripheral.discoverServices([
        Service.DeviceInformation.UUID,
        Service.Control.UUID,
        Service.Rowing.UUID])
    }
  }
  
  init(withPeripheral peripheral:CBPeripheral) {
    self.peripheral = peripheral
    super.init()
  }
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - CBPeripheralDelegate -
  // MARK: Services
  public func peripheral(peripheral: CBPeripheral,
    didDiscoverServices
    error: NSError?) {
    print("[PerformanceMonitor]didDiscoverServices")
  }
  
  public func peripheral(peripheral: CBPeripheral,
    didDiscoverIncludedServicesForService
    service: CBService,
    error: NSError?) {
    print("[PerformanceMonitor]didDiscoverIncludedServicesForService")
  }
  
  public func peripheral(peripheral: CBPeripheral,
    didModifyServices
    invalidatedServices: [CBService]) {
    print("[PerformanceMonitor]didModifyServices")
  }
  
  // MARK: Characteristics
  public func peripheral(peripheral: CBPeripheral,
    didDiscoverCharacteristicsForService
    service: CBService,
    error: NSError?) {
    print("[PerformanceMonitor]didDiscoverCharacteristicsForService")
  }
  
  public func peripheral(peripheral: CBPeripheral,
    didDiscoverDescriptorsForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
    print("[PerformanceMonitor]didDiscoverDescriptorsForCharacteristic")
  }
  
  public func peripheral(peripheral: CBPeripheral,
    didUpdateValueForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
    print("[PerformanceMonitor]didUpdateValueForCharacteristic")
  }
  
  public func peripheral(peripheral: CBPeripheral,
    didUpdateValueForDescriptor
    descriptor: CBDescriptor,
    error: NSError?) {
    print("[PerformanceMonitor]didUpdateValueForDescriptor")
  }
  
  public func peripheral(peripheral: CBPeripheral,
    didWriteValueForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
    print("[PerformanceMonitor]didWriteValueForCharacteristic")
  }
  
  public func peripheral(peripheral: CBPeripheral,
    didWriteValueForDescriptor
    descriptor: CBDescriptor,
    error: NSError?) {
    print("[PerformanceMonitor]didWriteValueForDescriptor")
  }
  
  public func peripheral(peripheral: CBPeripheral,
    didUpdateNotificationStateForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
    print("[PerformanceMonitor]didUpdateNotificationStateForCharacteristic")
  }
  
  // MARK: Signal Strength
  public func peripheralDidUpdateRSSI(peripheral: CBPeripheral,
    error: NSError?) {
    print("[PerformanceMonitor]didUpdateRSSI")
  }
  
  // MARK: Name
  public func peripheralDidUpdateName(peripheral: CBPeripheral) {
    print("[PerformanceMonitor]didUpdateName")
  }
}
