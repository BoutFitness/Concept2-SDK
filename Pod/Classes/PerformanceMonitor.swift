//
//  PerformanceMonitor.swift
//  Pods
//
//  Created by Jesse Curry on 9/27/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth


public class PerformanceMonitor: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate
{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  // Service UUIDs
  let BLEBaseServiceUUID = CBUUID(string: "CE060000-43E5-11E4-916C-0800200C9A66")
  let BLEInformationServiceUUID = CBUUID(string: "CE060010-43E5-11E4-916C-0800200C9A66")
  
  public func scanForConnection()
  {
    let centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    centralManager.scanForPeripheralsWithServices([BLEBaseServiceUUID, BLEInformationServiceUUID],
      options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
  }
  
  // MARK: CBCentralManagerDelegate
  public func centralManagerDidUpdateState(central: CBCentralManager)
  {
    if central.state == .PoweredOn
    {
      central.scanForPeripheralsWithServices([BLEBaseServiceUUID, BLEInformationServiceUUID],
        options: nil)
    }
    else
    {
      print("Local device Bluetooth not available")
    }
  }
  
  public func centralManager(central: CBCentralManager, didDiscoverPeripheral
    peripheral: CBPeripheral,
    advertisementData: [String : AnyObject],
    RSSI: NSNumber)
  {
    central.stopScan()
    central.connectPeripheral(peripheral, options: nil)
  }
  
  public func centralManager(central: CBCentralManager, didConnectPeripheral
    peripheral: CBPeripheral)
  {
    peripheral.delegate = self
    peripheral.discoverServices(nil)
  }
  
  // MARK: CBPeripheralDelegate
}
