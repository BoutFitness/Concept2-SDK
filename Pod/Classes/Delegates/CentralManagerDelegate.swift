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
  // MARK: Central Manager Status
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
    
    BluetoothManager.isReady.value = (central.state == .PoweredOn)
  }
  
  // MARK: Peripheral Discovery
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
  
  // MARK: Peripheral Connections
  func centralManager(central: CBCentralManager,
    didConnectPeripheral
    peripheral: CBPeripheral)
  {
    print("[BluetoothManager]didConnectPeripheral")
    peripheral.discoverServices([
      Service.DeviceDiscovery.UUID,
      Service.DeviceInformation.UUID,
      Service.Control.UUID,
      Service.Rowing.UUID])
    postPerformanceMonitorNotificationForPeripheral(peripheral)
  }
  
  func centralManager(central: CBCentralManager,
    didFailToConnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
      print("[BluetoothManager]didFailToConnectPeripheral")
      postPerformanceMonitorNotificationForPeripheral(peripheral)
  }
  
  func centralManager(central: CBCentralManager,
    didDisconnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
      print("[BluetoothManager]didDisconnectPeripheral")
      postPerformanceMonitorNotificationForPeripheral(peripheral)
  }
  
  // MARK: -
  
  private func postPerformanceMonitorNotificationForPeripheral(peripheral:CBPeripheral) {
    let performanceMonitorStore = PerformanceMonitorStore.sharedInstance
    if let pm = performanceMonitorStore.performanceMonitorWithPeripheral(peripheral) {
      pm.updatePeripheralObservers()
      NSNotificationCenter.defaultCenter().postNotificationName(
        PerformanceMonitor.DidUpdateStateNotification,
        object: pm)
    }
  }
}