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
  public var averageDriveForce = Subject<C2DriveForce>(value: 0)
  public var averagePace = Subject<C2Pace>(value: 0)
  public var currentPace = Subject<C2Pace>(value: 0)
  public var distance = Subject<C2Distance>(value: 0)
  public var dragFactor = Subject<C2DragFactor>(value: 0)
  public var driveLength = Subject<C2DriveLength>(value: 0)
  public var driveTime = Subject<C2DriveTime>(value: 0)
  public var elapsedTime = Subject<C2TimeInterval>(value: 0)
  public var heartRate = Subject<C2HeartRate>(value: 0)
  public var intervalAverageCalories = Subject<C2CalorieCount>(value: 0)
  public var intervalAveragePace = Subject<C2Pace>(value: 0)
  public var intervalAveragePower = Subject<C2Power>(value: 0)
  public var intervalAverageStrokeRate = Subject<C2StrokeRate>(value: 0)
  public var intervalCount = Subject<C2IntervalCount>(value: 0)
  public var intervalDistance = Subject<C2Distance>(value: 0)
  public var intervalNumber = Subject<C2IntervalCount>(value: 0)
  public var intervalPower = Subject<C2Power>(value: 0)
  public var intervalRestDistance = Subject<C2Distance>(value: 0)
  public var intervalRestHeartrate = Subject<C2HeartRate>(value: 0)
  public var intervalRestTime = Subject<C2TimeInterval>(value: 0)
  public var intervalSpeed = Subject<C2Speed>(value: 0)
  public var intervalTime = Subject<C2TimeInterval>(value: 0)
  public var intervalTotalCalories = Subject<C2CalorieCount>(value: 0)
  public var intervalType = Subject<IntervalType?>(value: nil)
  public var intervalWorkHeartrate = Subject<C2HeartRate>(value: 0)
  public var lastSplitDistance = Subject<C2Distance>(value: 0)
  public var lastSplitTime = Subject<C2TimeInterval>(value: 0)
  public var peakDriveForce = Subject<C2DriveForce>(value: 0)
  public var projectedWorkDistance = Subject<C2Distance>(value: 0)
  public var projectedWorkTime = Subject<C2TimeInterval>(value: 0)
  public var restDistance = Subject<C2Distance>(value: 0)
  public var restTime = Subject<C2TimeInterval>(value: 0)
  public var rowingState = Subject<RowingState?>(value: nil)
  public var sampleRate = Subject<RowingStatusSampleRateType?>(value: nil)
  public var speed = Subject<C2Speed>(value: 0)
  public var splitAverageDragFactor = Subject<C2DragFactor>(value: 0)
  public var strokeCalories = Subject<C2CalorieCount>(value: 0)
  public var strokeCount = Subject<C2StrokeCount>(value: 0)
  public var strokeDistance = Subject<C2Distance>(value: 0)
  public var strokePower = Subject<C2Power>(value: 0)
  public var strokeRate = Subject<C2StrokeRate>(value: 0)
  public var strokeRecoveryTime = Subject<C2TimeInterval>(value: 0)
  public var strokeState = Subject<StrokeState?>(value: nil)
  public var totalCalories = Subject<C2CalorieCount>(value: 0)
  public var totalWorkDistance = Subject<C2Distance>(value: 0)
  public var workoutDuration = Subject<C2TimeInterval>(value: 0)
  public var workoutDurationType = Subject<WorkoutDurationType?>(value: nil)
  public var workoutState = Subject<WorkoutState?>(value: nil)
  public var workoutType = Subject<WorkoutType?>(value: nil)
  public var workPerStroke = Subject<C2Work>(value: 0)
  
  // MARK: - Initialization
  init(withPeripheral peripheral:CBPeripheral) {
    self.peripheral = peripheral
    
    peripheralDelegate.performanceMonitor = self
    peripheral.delegate = peripheralDelegate
  }
  
  // MARK: API
  public func reset() {
    averageDriveForce.value = 0
    averagePace.value = 0
    currentPace.value = 0
    distance.value = 0
    dragFactor.value = 0
    driveLength.value = 0
    driveTime.value = 0
    elapsedTime.value = 0
    heartRate.value = 0
    intervalAverageCalories.value = 0
    intervalAveragePace.value = 0
    intervalAveragePower.value = 0
    intervalAverageStrokeRate.value = 0
    intervalCount.value = 0
    intervalDistance.value = 0
    intervalNumber.value = 0
    intervalPower.value = 0
    intervalRestDistance.value = 0
    intervalRestHeartrate.value = 0
    intervalRestTime.value = 0
    intervalSpeed.value = 0
    intervalTime.value = 0
    intervalTotalCalories.value = 0
    intervalWorkHeartrate.value = 0
    lastSplitDistance.value = 0
    lastSplitTime.value = 0
    peakDriveForce.value = 0
    projectedWorkDistance.value = 0
    projectedWorkTime.value = 0
    restDistance.value = 0
    restTime.value = 0
    speed.value = 0
    splitAverageDragFactor.value = 0
    strokeCalories.value = 0
    strokeCount.value = 0
    strokeDistance.value = 0
    strokePower.value = 0
    strokeRate.value = 0
    strokeRecoveryTime.value = 0
    totalCalories.value = 0
    totalWorkDistance.value = 0
    workoutDuration.value = 0
    workPerStroke.value = 0
  }
  
  // MARK: -
  func updatePeripheralObservers() {
    print("[PerformanceMonitor]updatePeripheralObservers")
    
    peripheral.services?.forEach({ (service:CBService) -> () in
      print("Requesting notifications for \(service.description)")
      
      if let svc = Service(uuid: service.UUID) {
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