//
//  BluetoothManager.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//
//

import CoreBluetooth

public protocol BluetoothManagerDelegate {
  func didLoadPeripherals(bluetoothScanner:BluetoothManager, peripherals:Array<CBPeripheral>)
}

public final class BluetoothManager
{
  private var centralManager:CBCentralManager
  private let centralManagerDelegate = CentralManagerDelegate()
  private let centralManagerQueue = dispatch_queue_create(
    "com.boutfitness.concept2.bluetooth.central",
    DISPATCH_QUEUE_CONCURRENT
  )
  
  #if os(iOS)
  @available(iOS 9.0, *)
  var isScanningForPerformanceMonitors:Bool { get { return centralManager.isScanning } }
  #endif
  
  var isReady:Bool { get { return centralManager.state == .PoweredOn } }
  
  public var delegate:BluetoothManagerDelegate
  
  // MARK: Initialization
  public init(withDelegate delegate:BluetoothManagerDelegate) {
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
  
  public func scanForPeripherals() {
    centralManager.scanForPeripheralsWithServices([Service.DeviceDiscovery.UUID],
      options: nil)
  }
  
  public func stopScanningForPeripherals() {
    centralManager.stopScan()
  }
  
  public func connectPeripheral(peripheral:CBPeripheral) {
    centralManager.connectPeripheral(peripheral, options: nil)
  }
  
  public func disconnectPeripheral(peripheral:CBPeripheral) {
    centralManager.cancelPeripheralConnection(peripheral)
  }
}