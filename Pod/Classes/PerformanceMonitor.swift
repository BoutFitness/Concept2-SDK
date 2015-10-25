//
//  PerformanceMonitor.swift
//  Pods
//
//  Created by Jesse Curry on 9/27/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

public let PerformanceMonitorDidUpdateStateNotification = "PerformanceMonitorDidUpdateStateNotification"

public final class PerformanceMonitor
{
  var peripheral:CBPeripheral
  lazy var peripheralDelegate = PeripheralDelegate()
  
  // MARK: Basic Information
  public var peripheralName:String { get { return peripheral.name ?? "Unknown" } }
  public var peripheralIdentifier:String { get { return peripheral.identifier.UUIDString } }
  
  public var isConnected:Bool { get { return (peripheral.state == .Connected) } }
  
  // MARK: Initialization
  init(withPeripheral peripheral:CBPeripheral) {
    self.peripheral = peripheral
    
    peripheralDelegate.performanceMonitor = self
    peripheral.delegate = peripheralDelegate
  }
  
  // MARK: -
  func updatePeripheralObservers() {
    print("[PerformanceMonitor]updatePeripheralObservers")
    
    peripheral.services?.forEach({ (service:CBService) -> () in
      print("Requesting notifications for \(service.description)")
      
      if let svc = Service(rawValue: service.UUID.UUIDString) {
        peripheral.discoverCharacteristics(svc.characteristicUUIDs,
          forService:  service)
        
        service.characteristics?.forEach({ (characteristic:CBCharacteristic) -> () in
          print("\t* \(characteristic)")
          peripheral.setNotifyValue(true, forCharacteristic: characteristic)
        })
      }
    })
  }
  
  // MARK: Device Information
  private var deviceInformationServiceEnabled = false
  public func enableDeviceInformationService() {
    if !deviceInformationServiceEnabled {
      print("[PerformanceMonitor]enabling device information service")
      peripheral.discoverServices([Service.DeviceInformation.UUID])
      deviceInformationServiceEnabled = true
    }
  }
  
  // MARK: Control
  private var controlServiceEnabled = false
  public func enableControlService() {
    if !controlServiceEnabled {
      print("[PerformanceMonitor]enabling control service")
      peripheral.discoverServices([Service.Control.UUID])
      controlServiceEnabled = true
    }
  }
  
  // MARK: Rowing
  private var rowingServiceEnabled = false
  public func enableRowingService() {
    if !rowingServiceEnabled {
      print("[PerformanceMonitor]enabling rowing service")
      peripheral.discoverServices([Service.Rowing.UUID])
      rowingServiceEnabled = true
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
// MARK: Equatable
@warn_unused_result
public func ==(lhs:PerformanceMonitor, rhs:PerformanceMonitor) -> Bool {
  return (lhs.peripheral == rhs.peripheral)
}

// MARK: Hashable
extension PerformanceMonitor: Hashable {
  public var hashValue: Int {
    get {
      return peripheral.hashValue
    }
  }
}