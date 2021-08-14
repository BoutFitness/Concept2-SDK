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
    public static let DidUpdateStateNotification = Notification.Name("PerformanceMonitorDidUpdateStateNotification")
  
  //
  var peripheral:CBPeripheral
  lazy var peripheralDelegate = PeripheralDelegate()
  
  // MARK: Basic Information
  public var peripheralName:String { get { return peripheral.name ?? "Unknown" } }
  public var peripheralIdentifier:String { get { return peripheral.identifier.uuidString } }
  
  public var isConnected:Bool { get { return (peripheral.state == .connected) } }
  
  // MARK: Rowing Information
  public let averageCalories = Subject<C2CalorieCount>(value: 0)
  public let averageDriveForce = Subject<C2DriveForce>(value: 0)
  public let averageHeartRate = Subject<C2HeartRate>(value: 0)
  public let averagePace = Subject<C2Pace>(value: 0)
  public let averageStrokeRate = Subject<C2StrokeRate>(value: 0)
  public let currentPace = Subject<C2Pace>(value: 0)
  public let distance = Subject<C2Distance>(value: 0)
  public let dragFactor = Subject<C2DragFactor>(value: 0)
  public let dragFactorAverage = Subject<C2DragFactor>(value: 0)
  public let driveLength = Subject<C2DriveLength>(value: 0)
  public let driveTime = Subject<C2DriveTime>(value: 0)
  public let elapsedTime = Subject<C2TimeInterval>(value: 0)
  public let endingHeartRate = Subject<C2HeartRate>(value: 0)
  public let heartRate = Subject<C2HeartRate>(value: 0)
  public let intervalAverageCalories = Subject<C2CalorieCount>(value: 0)
  public let intervalAveragePace = Subject<C2Pace>(value: 0)
  public let intervalAveragePower = Subject<C2Power>(value: 0)
  public let intervalAverageStrokeRate = Subject<C2StrokeRate>(value: 0)
  public let intervalCount = Subject<C2IntervalCount>(value: 0)
  public let intervalDistance = Subject<C2Distance>(value: 0)
  public let intervalNumber = Subject<C2IntervalCount>(value: 0)
  public let intervalPower = Subject<C2Power>(value: 0)
  public let intervalRestDistance = Subject<C2Distance>(value: 0)
  public let intervalRestHeartrate = Subject<C2HeartRate>(value: 0)
  public let intervalRestTime = Subject<C2TimeInterval>(value: 0)
  public let intervalSize = Subject<C2IntervalSize>(value: 0)
  public let intervalSpeed = Subject<C2Speed>(value: 0)
  public let intervalTime = Subject<C2TimeInterval>(value: 0)
  public let intervalTotalCalories = Subject<C2CalorieCount>(value: 0)
  public let intervalType = Subject<IntervalType?>(value: nil)
  public let intervalWorkHeartrate = Subject<C2HeartRate>(value: 0)
  public let lastSplitDistance = Subject<C2Distance>(value: 0)
  public let lastSplitTime = Subject<C2TimeInterval>(value: 0)
  public let maximumHeartRate = Subject<C2HeartRate>(value: 0)
  public let minimumHeartRate = Subject<C2HeartRate>(value: 0)
  public let peakDriveForce = Subject<C2DriveForce>(value: 0)
  public let projectedWorkDistance = Subject<C2Distance>(value: 0)
  public let projectedWorkTime = Subject<C2TimeInterval>(value: 0)
  public let recoveryHeartRate = Subject<C2HeartRate>(value: 0)
  public let restDistance = Subject<C2Distance>(value: 0)
  public let restTime = Subject<C2TimeInterval>(value: 0)
  public let rowingState = Subject<RowingState?>(value: nil)
  public let sampleRate = Subject<RowingStatusSampleRateType?>(value: nil)
  public let speed = Subject<C2Speed>(value: 0)
  public let splitAverageDragFactor = Subject<C2DragFactor>(value: 0)
  public let strokeCalories = Subject<C2CalorieCount>(value: 0)
  public let strokeCount = Subject<C2StrokeCount>(value: 0)
  public let strokeDistance = Subject<C2Distance>(value: 0)
  public let strokePower = Subject<C2Power>(value: 0)
  public let strokeRate = Subject<C2StrokeRate>(value: 0)
  public let strokeRecoveryTime = Subject<C2TimeInterval>(value: 0)
  public let strokeState = Subject<StrokeState?>(value: nil)
  public let totalCalories = Subject<C2CalorieCount>(value: 0)
  public let totalRestDistance = Subject<C2Distance>(value: 0)
  public let totalWorkDistance = Subject<C2Distance>(value: 0)
  public let watts = Subject<C2Power>(value: 0)
  public let workoutDuration = Subject<C2TimeInterval>(value: 0)
  public let workoutDurationType = Subject<WorkoutDurationType?>(value: nil)
  public let workoutState = Subject<WorkoutState?>(value: nil)
  public let workoutType = Subject<WorkoutType?>(value: nil)
  public let workPerStroke = Subject<C2Work>(value: 0)
  
  // MARK: Heart Rate Belt
  public let manufacturerID = Subject<C2HeartRateBeltManufacturerID>(value: 0)
  public let deviceType = Subject<C2HeartRateBeltType>(value: 0)
  public let beltID = Subject<C2HeartRateBeltID>(value: 0)
  
  // MARK: - Initialization
  init(withPeripheral peripheral:CBPeripheral) {
    self.peripheral = peripheral
    
    peripheralDelegate.performanceMonitor = self
    peripheral.delegate = peripheralDelegate
  }
  
  // MARK: API
  public func reset() {
    averageCalories.value = 0
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
    intervalSize.value = 0
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
    totalRestDistance.value = 0
    totalWorkDistance.value = 0
    watts.value = 0
    workoutDuration.value = 0
    workPerStroke.value = 0
    
    manufacturerID.value = 0
    deviceType.value = 0
    beltID.value = 0
  }
  
  // MARK: -
  func updatePeripheralObservers() {
    print("[PerformanceMonitor]updatePeripheralObservers")
    
    peripheral.services?.forEach({ (service:CBService) -> () in
      print("Requesting notifications for \(service.description)")
      
      if let svc = Service(uuid: service.uuid) {
        peripheral.discoverCharacteristics(svc.characteristicUUIDs,
          for:  service)
        
        service.characteristics?.forEach({ (characteristic:CBCharacteristic) -> () in
          print("\t* \(characteristic)")
          peripheral.setNotifyValue(true, for: characteristic)
        })
      }
    })
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
    public func hash(into hasher: inout Hasher) {
        hasher.combine(peripheral.hashValue)
    }
}
