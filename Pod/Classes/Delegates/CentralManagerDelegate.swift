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
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .unknown:
      print("[BluetoothManager]state: unknown")
      break
    case .resetting:
      print("[BluetoothManager]state: resetting")
      break
    case .unsupported:
      print("[BluetoothManager]state: not available")
      break
    case .unauthorized:
      print("[BluetoothManager]state: not authorized")
      break
    case .poweredOff:
      print("[BluetoothManager]state: powered off")
      break
    case .poweredOn:
      print("[BluetoothManager]state: powered on")
      break
    }
    
    BluetoothManager.isReady.value = (central.state == .poweredOn)
  }
  
  // MARK: Peripheral Discovery
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
    print("[BluetoothManager]didDiscoverPeripheral \(peripheral)")
    PerformanceMonitorStore.sharedInstance.addPerformanceMonitor(
        performanceMonitor: PerformanceMonitor(withPeripheral: peripheral)
    )
  }
  
  // MARK: Peripheral Connections
  func centralManager(central: CBCentralManager,
    didConnectPeripheral
    peripheral: CBPeripheral)
  {
    print("[BluetoothManager]didConnectPeripheral")
    peripheral.discoverServices([
      Service.deviceDiscovery.uuid,
      Service.deviceInformation.uuid,
      Service.control.uuid,
      Service.rowing.uuid])
      postPerformanceMonitorNotificationForPeripheral(peripheral: peripheral)
  }
  
  func centralManager(central: CBCentralManager,
    didFailToConnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
      print("[BluetoothManager]didFailToConnectPeripheral")
      postPerformanceMonitorNotificationForPeripheral(peripheral: peripheral)
  }
  
  func centralManager(central: CBCentralManager,
    didDisconnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
      print("[BluetoothManager]didDisconnectPeripheral")
      postPerformanceMonitorNotificationForPeripheral(peripheral: peripheral)
  }
  
  // MARK: -
  
  private func postPerformanceMonitorNotificationForPeripheral(peripheral:CBPeripheral) {
    let performanceMonitorStore = PerformanceMonitorStore.sharedInstance
      if let pm = performanceMonitorStore.performanceMonitorWithPeripheral(peripheral: peripheral) {
      pm.updatePeripheralObservers()
          NotificationCenter.default.post(
            name: PerformanceMonitor.DidUpdateStateNotification,
        object: pm
          )
    }
  }
}
