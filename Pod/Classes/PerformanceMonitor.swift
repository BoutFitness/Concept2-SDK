//
//  PerformanceMonitor.swift
//  Pods
//
//  Created by Jesse Curry on 9/27/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

public final class PerformanceMonitor
{
  public static let DidUpdateStateNotification = "PerformanceMonitorDidUpdateStateNotification"
  public static let DidUpdateValueNotification = "PerformanceMonitorDidUpdateValueNotification"
  
  //
  var peripheral:CBPeripheral
  lazy var peripheralDelegate = PeripheralDelegate()
  
  // MARK: Basic Information
  public var peripheralName:String { get { return peripheral.name ?? "Unknown" } }
  public var peripheralIdentifier:String { get { return peripheral.identifier.UUIDString } }
  
  public var isConnected:Bool { get { return (peripheral.state == .Connected) } }
  
  // MARK: Rowing Information
  public var averageDriveForce:C2DriveForce = 0
  public var averagePace:C2Pace = 0
  public var currentPace:C2Pace = 0
  public var distance:C2Distance = 0
  public var dragFactor:C2DragFactor = 0
  public var driveLength:C2DriveLength = 0
  public var driveTime:C2DriveTime = 0
  public var elapsedTime:C2TimeInterval = 0
  public var heartRate:C2HeartRate = 0
  public var intervalAverageCalories:C2CalorieCount = 0
  public var intervalAveragePace:C2Pace = 0
  public var intervalAveragePower:C2Power = 0
  public var intervalAverageStrokeRate:C2StrokeRate = 0
  public var intervalCount:C2IntervalCount = 0
  public var intervalDistance:C2Distance = 0
  public var intervalNumber:C2IntervalCount = 0
  public var intervalPower:C2Power = 0
  public var intervalRestDistance:C2Distance = 0
  public var intervalRestHeartrate:C2HeartRate = 0
  public var intervalRestTime:C2TimeInterval = 0
  public var intervalSpeed:C2Speed = 0
  public var intervalTime:C2TimeInterval = 0
  public var intervalTotalCalories:C2CalorieCount = 0
  public var intervalType:IntervalType?
  public var intervalWorkHeartrate:C2HeartRate = 0
  public var lastSplitDistance:C2Distance = 0
  public var lastSplitTime:C2TimeInterval = 0
  public var peakDriveForce:C2DriveForce = 0
  public var projectedWorkDistance:C2Distance = 0
  public var projectedWorkTime:C2TimeInterval = 0
  public var restDistance:C2Distance = 0
  public var restTime:C2TimeInterval = 0
  public var rowingState:RowingState?
  public var sampleRate:RowingStatusSampleRateType?
  public var speed:C2Speed = 0
  public var splitAverageDragFactor:C2DragFactor = 0
  public var strokeCalories:C2CalorieCount = 0
  public var strokeCount:C2StrokeCount = 0
  public var strokeDistance:C2Distance = 0
  public var strokePower:C2Power = 0
  public var strokeRate:C2StrokeRate = 0
  public var strokeRecoveryTime:C2TimeInterval = 0
  public var strokeState:StrokeState?
  public var totalCalories:C2CalorieCount = 0
  public var totalWorkDistance:C2Distance = 0
  public var workoutDuration:C2TimeInterval = 0
  public var workoutDurationType:WorkoutDurationType?
  public var workoutState:WorkoutState?
  public var workoutType:WorkoutType?
  public var workPerStroke:C2Work = 0
  
  // MARK: - Initialization
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
  
  // MARK:
  func postUpdateValueNotification() {
    NSNotificationCenter.defaultCenter().postNotificationName(
      PerformanceMonitor.DidUpdateValueNotification,
      object: self)
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