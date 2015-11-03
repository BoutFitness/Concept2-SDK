//
//  PeripheralDelegate.swift
//  Pods
//
//  Created by Jesse Curry on 9/30/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

final class PeripheralDelegate: NSObject, CBPeripheralDelegate {
  weak var performanceMonitor:PerformanceMonitor?
  
  // MARK: Services
  func peripheral(peripheral: CBPeripheral,
    didDiscoverServices
    error: NSError?) {
      print("[PerformanceMonitor]didDiscoverServices:")
      peripheral.services?.forEach({ (service:CBService) -> () in
        print("\t* \(service.description)")

        if let svc = Service(uuid: service.UUID) {
          peripheral.discoverCharacteristics(svc.characteristicUUIDs,
            forService:  service)
        }
      })
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
      service.characteristics?.forEach({ (characteristic:CBCharacteristic) -> () in
        peripheral.setNotifyValue(true, forCharacteristic: characteristic)
      })
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
      print("[PerformanceMonitor]didUpdateValueForCharacteristic: \(characteristic)")
      if let svc = Service(uuid: characteristic.service.UUID) {
        if let c = svc.characteristic(uuid: characteristic.UUID) {
          let cm = c.parse(data: characteristic.value)
          if let pm = performanceMonitor {
            cm?.updatePerformanceMonitor(pm)
          }
        }
      }
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