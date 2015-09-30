//
//  CentralManagerDelegate.swift
//  Pods
//
//  Created by Jesse Curry on 9/30/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import Foundation
import CoreBluetooth

class CentralManagerDelegate:NSObject, CBCentralManagerDelegate {
  func centralManagerDidUpdateState(central: CBCentralManager)
  {
    switch central.state {
    case .Unknown:
      print("[BluetoothScanner]state: unknown")
      break
    case .Resetting:
      print("[BluetoothScanner]state: resetting")
      break
    case .Unsupported:
      print("[BluetoothScanner]state: not available")
      break
    case .Unauthorized:
      print("[BluetoothScanner]state: not authorized")
      break
    case .PoweredOff:
      print("[BluetoothScanner]state: powered off")
      break
    case .PoweredOn:
      print("[BluetoothScanner]state: powered on")
      central.scanForPeripheralsWithServices([Service.DeviceDiscovery.UUID], options: nil)
      break
    }
  }
  
  func centralManager(central: CBCentralManager,
    didDiscoverPeripheral
    peripheral: CBPeripheral,
    advertisementData: [String : AnyObject],
    RSSI: NSNumber)
  {
    print("[BluetoothScanner]didDiscoverPeripheral")
    central.stopScan()
    
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
      central.connectPeripheral(peripheral, options: nil)
    }
  }
  
  func centralManager(central: CBCentralManager,
    didConnectPeripheral
    peripheral: CBPeripheral)
  {
    print("[BluetoothScanner]didConnectPeripheral")
    PerformanceMonitorStore.sharedInstance.addPerformanceMonitor(
      PerformanceMonitor(withPeripheral: peripheral)
    )
  }
  
  func centralManager(central: CBCentralManager,
    didFailToConnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
      print("[BluetoothScanner]didFailToConnectPeripheral")
  }
  
  func centralManager(central: CBCentralManager,
    didDisconnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
      print("[BluetoothScanner]didDisconnectPeripheral")
  }
}