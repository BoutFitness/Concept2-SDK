//
//  BluetoothManager.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//
//

import CoreBluetooth

public protocol BluetoothManagerDelegate {
  func didLoadPerformanceMonitors(bluetoothManager:BluetoothManager,
    performanceMonitors:Array<PerformanceMonitor>)
}

public final class BluetoothManager
{
  public static let sharedInstance = BluetoothManager()
  
  public static func scanForPerformanceMonitors() {
    sharedInstance.scanForPerformanceMonitors()
  }
  
  public static func stopScanningForPerformanceMonitors() {
    sharedInstance.stopScanningForPerformanceMonitors()
  }
  
  public static func connectPerformanceMonitor(performanceMonitor:PerformanceMonitor,
    exclusive:Bool) {
      sharedInstance.connectPerformanceMonitor(performanceMonitor, exclusive: exclusive)
  }
  
  public static func connectPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    sharedInstance.connectPerformanceMonitor(performanceMonitor)
  }
  
  public static func disconnectPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    sharedInstance.disconnectPerformanceMonitor(performanceMonitor)
  }
  
  public var isReady = Subject<Bool>(value: false)
  public var performanceMonitors = Subject<Array<PerformanceMonitor>>(value: Array<PerformanceMonitor>())
  
  // MARK: -
  private var centralManager:CBCentralManager
  private var centralManagerDelegate:CentralManagerDelegate {
    didSet {
      centralManagerDelegate.bluetoothManager = self
    }
  }
  private let centralManagerQueue = dispatch_queue_create(
    "com.boutfitness.concept2.bluetooth.central",
    DISPATCH_QUEUE_CONCURRENT
  )
  
  // MARK: Initialization
  init() {
    centralManagerDelegate = CentralManagerDelegate()
    centralManager = CBCentralManager(delegate: centralManagerDelegate,
      queue: centralManagerQueue)
    
    //
    NSNotificationCenter.defaultCenter().addObserverForName(
      PerformanceMonitorStoreDidAddItemNotification,
      object: PerformanceMonitorStore.sharedInstance,
      queue: nil) { [weak self] (notification) -> Void in
        if let weakSelf = self {
          dispatch_async(dispatch_get_main_queue(), { () -> Void in
            weakSelf.performanceMonitors.value = Array(PerformanceMonitorStore.sharedInstance.performanceMonitors)
          })
        }
    }
  }
  
  func scanForPerformanceMonitors() {
    centralManager.scanForPeripheralsWithServices([Service.DeviceDiscovery.UUID],
      options: nil)
  }
  
  func stopScanningForPerformanceMonitors() {
    centralManager.stopScan()
  }
  
  func connectPerformanceMonitor(performanceMonitor:PerformanceMonitor, exclusive:Bool) {
    // TODO: use the PerformanceMonitor abstraction instead of peripherals
    if exclusive == true {
      centralManager.retrieveConnectedPeripheralsWithServices([Service.DeviceDiscovery.UUID])
        .forEach { (peripheral) -> () in
        if peripheral.state == .Connected {
          if peripheral != performanceMonitor.peripheral {
            centralManager.cancelPeripheralConnection(peripheral)
          }
        }
      }
    }
    
    centralManager.connectPeripheral(performanceMonitor.peripheral, options: nil)
  }
  
  func connectPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    self.connectPerformanceMonitor(performanceMonitor, exclusive: true)
  }
  
  func disconnectPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    centralManager.cancelPeripheralConnection(performanceMonitor.peripheral)
  }
}