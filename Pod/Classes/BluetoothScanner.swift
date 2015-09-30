//
//  BluetoothScanner.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//
//

import CoreBluetooth

public class BluetoothScanner: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate
{
  //////////////////////////////////////////////////////////////////////////////////////////////////
  
  var centralManager:CBCentralManager?
  
  public var performanceMonitors = []
  
  public func scanForConnection()
  {
    if (centralManager == nil)
    {
      centralManager = CBCentralManager(delegate: self, queue: dispatch_get_main_queue())
    }
  }
  
  // MARK: CBCentralManagerDelegate
  public func centralManagerDidUpdateState(central: CBCentralManager)
  {
    switch central.state {
    case .Unknown:
      print("Bluetooth unknown")
      break
    case .Resetting:
      print("Bluetooth resetting")
      break
    case .Unsupported:
      print("Local device Bluetooth not available")
      break
    case .Unauthorized:
      print("Local device Bluetooth not authorized")
      break
    case .PoweredOff:
      print("Bluetooth powered off")
      break
    case .PoweredOn:
      print("Bluetooth powered on")
      central.scanForPeripheralsWithServices([Service.DeviceDiscovery.UUID], options: nil)
      break
    }
  }
  
  public func centralManager(central: CBCentralManager,
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
  
  public func centralManager(central: CBCentralManager,
    didConnectPeripheral
    peripheral: CBPeripheral)
  {
    print("[BluetoothScanner]didConnectPeripheral")
    let pm = PerformanceMonitor(withPeripheral: peripheral)
    
    performanceMonitors = [pm]
  }
  
  public func centralManager(central: CBCentralManager,
    didFailToConnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
    print("[BluetoothScanner]didFailToConnectPeripheral")
  }
  
  public func centralManager(central: CBCentralManager,
    didDisconnectPeripheral
    peripheral: CBPeripheral,
    error: NSError?) {
    print("[BluetoothScanner]didDisconnectPeripheral")
  }
}
