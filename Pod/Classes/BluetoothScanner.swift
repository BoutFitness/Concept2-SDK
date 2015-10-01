//
//  BluetoothScanner.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//
//

import CoreBluetooth

public protocol BluetoothScannerDelegate {
  func didLoadPeripherals(bluetoothScanner:BluetoothScanner, peripherals:Array<CBPeripheral>)
}

public final class BluetoothScanner
{
  private var centralManager:CBCentralManager
  private let centralManagerDelegate = CentralManagerDelegate()
  private let centralManagerQueue = dispatch_queue_create(
    "com.boutfitness.concept2.bluetooth.central",
    DISPATCH_QUEUE_CONCURRENT
  )
  
  @available(iOS 9.0, *)
  var isScanningForPerformanceMonitors:Bool {
    get {
      return centralManager.isScanning
    }
  }
  
  public var delegate:BluetoothScannerDelegate
  
  // MARK: Initialization
  public init(withDelegate delegate:BluetoothScannerDelegate) {
    centralManager = CBCentralManager(delegate: centralManagerDelegate,
      queue: centralManagerQueue)
    self.delegate = delegate
    
    NSNotificationCenter.defaultCenter().addObserverForName(
      PeripheralStoreDidAddItemNotification,
      object: PeripheralStore.sharedInstance,
      queue: nil) { (notification) -> Void in
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          delegate.didLoadPeripherals(self,
            peripherals: Array(PeripheralStore.sharedInstance.peripherals))
        })

    }
  }
  
  public func scanForPerformanceMonitors() {
    centralManager.scanForPeripheralsWithServices([Service.DeviceDiscovery.UUID],
      options: nil)
  }
  
  public func stopScanningForPerformanceMonitors() {
    centralManager.stopScan()
  }
}