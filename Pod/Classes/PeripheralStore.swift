//
//  PeripheralStore.swift
//  Pods
//
//  Created by Jesse Curry on 9/30/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

let PeripheralStoreDidAddItemNotification = "PeripheralStoreDidAddItemNotification"
let PeripheralStoreDidRemoveItemNotification = "PeripheralStoreDidRemoveItemNotification"

final class PeripheralStore {
  // Singleton
  static let sharedInstance = PeripheralStore()
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  var peripherals = Set<CBPeripheral>()
  
  func addPeripheral(peripheralMonitor:CBPeripheral) {
    
    peripherals.insert(peripheralMonitor)
    
    NSNotificationCenter.defaultCenter().postNotificationName(
      PeripheralStoreDidAddItemNotification,
      object: self)
  }
  
  func removePeripheral(peripheralMonitor:CBPeripheral) {
    peripherals.remove(peripheralMonitor)
    
    NSNotificationCenter.defaultCenter().postNotificationName(
      PeripheralStoreDidRemoveItemNotification,
      object: self)
  }
}