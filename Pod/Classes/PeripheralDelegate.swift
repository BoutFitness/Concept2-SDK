//
//  PeripheralDelegate.swift
//  Pods
//
//  Created by Jesse Curry on 9/30/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

class PeripheralDelegate: NSObject, CBPeripheralDelegate {
  // MARK: Services
  func peripheral(peripheral: CBPeripheral,
    didDiscoverServices
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverServices")
  }
  
  func peripheral(peripheral: CBPeripheral,
    didDiscoverIncludedServicesForService
    service: CBService,
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverIncludedServicesForService")
  }
  
  func peripheral(peripheral: CBPeripheral,
    didModifyServices
    invalidatedServices: [CBService]) {
      print("[PerformanceMonitor]didModifyServices")
  }
  
  // MARK: Characteristics
  func peripheral(peripheral: CBPeripheral,
    didDiscoverCharacteristicsForService
    service: CBService,
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverCharacteristicsForService")
  }
  
  func peripheral(peripheral: CBPeripheral,
    didDiscoverDescriptorsForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverDescriptorsForCharacteristic")
  }
  
  func peripheral(peripheral: CBPeripheral,
    didUpdateValueForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
      print("[PerformanceMonitor]didUpdateValueForCharacteristic")
  }
  
  func peripheral(peripheral: CBPeripheral,
    didUpdateValueForDescriptor
    descriptor: CBDescriptor,
    error: NSError?) {
      print("[PerformanceMonitor]didUpdateValueForDescriptor")
  }
  
  func peripheral(peripheral: CBPeripheral,
    didWriteValueForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
      print("[PerformanceMonitor]didWriteValueForCharacteristic")
  }
  
  func peripheral(peripheral: CBPeripheral,
    didWriteValueForDescriptor
    descriptor: CBDescriptor,
    error: NSError?) {
      print("[PerformanceMonitor]didWriteValueForDescriptor")
  }
  
  func peripheral(peripheral: CBPeripheral,
    didUpdateNotificationStateForCharacteristic
    characteristic: CBCharacteristic,
    error: NSError?) {
      print("[PerformanceMonitor]didUpdateNotificationStateForCharacteristic")
  }
  
  // MARK: Signal Strength
  func peripheralDidUpdateRSSI(peripheral: CBPeripheral,
    error: NSError?) {
      print("[PerformanceMonitor]didUpdateRSSI")
  }
  
  // MARK: Name
  func peripheralDidUpdateName(peripheral: CBPeripheral) {
    print("[PerformanceMonitor]didUpdateName")
  }
}