//
//  CentralManagerDelegate.swift
//  Pods
//
//  Created by Jesse Curry on 9/30/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import Foundation
import CoreBluetooth

final class CentralManagerDelegate:NSObject, CBCentralManagerDelegate {
  weak var bluetoothManager:BluetoothManager?
    
  func centralManagerDidUpdateState(central: CBCentralManager)
  {
    switch central.state {
    case .Unknown:
      print("[BluetoothManager]state: unknown")
      break
    case .Resetting:
      print("[BluetoothManager]state: resetting")
      break
    case .Unsupported:
      print("[BluetoothManager]state: not available")
      break
    case .Unauthorized:
      print("[BluetoothManager]state: not authorized")
      break
    case .PoweredOff:
      print("[BluetoothManager]state: powered off")
      break
    case .PoweredOn:
      print("[BluetoothManager]state: powered on")
      break
    }
    
    NSNotificationCenter.defaultCenter().postNotificationName(
      BluetoothManagerDidUpdateStateNotification,
      object: bluetoothManager)
  }
  
  func centralManager(central: CBCentralManager,
    didDiscoverPeripheral
    peripheral: CBPeripheral,
    advertisementData: [String : AnyObject],
    RSSI: NSNumber)
  {
    print("[BluetoothManager]didDiscoverPeripheral \(peripheral)")
    PerformanceMonitorStore.sharedInstance.addPerformanceMonitor(
      PerformanceMonitor(withPeripheral: peripheral)
    )
  }
  
  func centralManager(central: CBCentralManager,
    didConnectPeripheral
    peripheral: CBPeripheral)
  {
    print("[BluetoothManager]didConnectPeripheral")
  }
  
  func centralManager(central: CBCentralManager,
    didFailToConnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
      print("[BluetoothManager]didFailToConnectPeripheral")
  }
  
  func centralManager(central: CBCentralManager,
    didDisconnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
      print("[BluetoothManager]didDisconnectPeripheral")
  }
}