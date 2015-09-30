//
//  BluetoothScanner.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//
//

import CoreBluetooth

public final class BluetoothScanner: NSObject
{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  var centralManager:CBCentralManager
  let centralManagerDelegate = CentralManagerDelegate()
  
  @available(iOS 9.0, *)
  var isScanningForPerformanceMonitors:Bool {
    get {
      return centralManager.isScanning
    }
  }
  
  override public init() {
    centralManager = CBCentralManager(delegate: centralManagerDelegate, queue: nil)
    super.init()
  }
  
  public func scanForPerformanceMonitors() {
    centralManager.scanForPeripheralsWithServices([Service.DeviceDiscovery.UUID],
      options: nil)
  }
  
  public func stopScanningForPerformanceMonitors() {
    centralManager.stopScan()
  }
}