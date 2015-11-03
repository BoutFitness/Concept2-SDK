//
//  RowingAdditionalWorkoutSummaryData.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

struct RowingAdditionalWorkoutSummaryData: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 20
  
  /*
    Data bytes packed as follows:
    Log Entry Date Lo,
    Log Entry Date Hi,
    Log Entry Time Lo,
    Log Entry Time Hi,
    Split/Interval Type,
    Split/Interval Size Lo, (meters or seconds)
    Split/Interval Size Hi,
    Split/Interval Count,
    Total Calories Lo,
    Total Calories Hi,
    Watts Lo,
    Watts Hi,
    Total Rest Distance Lo (1 m lsb),
    Total Rest Distance Mid,
    Total Rest Distance High
    Interval Rest Time Lo (seconds),
    Interval Rest Time Hi,
    Avg Calories Lo, (cals/hr)
    Avg Calories Hi
  */
  
  var logEntryDate:C2Date
  var logEntryTime:C2Time
  var intervalType:IntervalType?
  var intervalSize:C2IntervalSize
  var intervalCount:C2IntervalCount
  var totalCalories:C2CalorieCount
  var watts:C2Power
  var totalRestDistance:C2Distance
  var intervalRestTime:C2TimeInterval
  var averageCalories:C2CalorieCount
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
    
    logEntryDate = 0 // TODO: find date/time format
    logEntryTime = 0
    intervalType = IntervalType(rawValue: Int(arr[4]))
    intervalSize = C2IntervalSize(sizeWithLow: UInt16(arr[5]), high: UInt16(arr[6]))
    intervalCount = C2IntervalCount(arr[7])
    totalCalories = C2CalorieCount(calorieCountWithLow: UInt16(arr[8]), high: UInt16(arr[9]))
    watts = C2Power(powerWithLow: UInt16(arr[10]), high: UInt16(arr[11]))
    totalRestDistance = C2Distance(restDistanceWithLow: UInt32(arr[12]), mid: UInt32(arr[13]), high: UInt32(arr[14]))
    intervalRestTime = C2TimeInterval(restTimeWithLow: UInt16(arr[15]), high: UInt16(arr[16]))
    averageCalories = C2CalorieCount(calorieCountWithLow: UInt16(arr[17]), high: UInt16(arr[18]))
  }
  
  // MARK: PerformanceMonitor
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
//    performanceMonitor.logEntryDate.value = logEntryDate
//    performanceMonitor.logEntryTime.value = logEntryTime
    performanceMonitor.intervalType.value = intervalType
//    performanceMonitor.intervalSize.value = intervalSize
    performanceMonitor.intervalCount.value = intervalCount
    performanceMonitor.totalCalories.value = totalCalories
//    performanceMonitor.watts.value = watts
//    performanceMonitor.totalRestDistance.value = totalRestDistance
    performanceMonitor.intervalRestTime.value = intervalRestTime
//    performanceMonitor.averageCalories.value = averageCalories
  }
  
  // MARK: -
  var debugDescription:String {
      return "[RowingAdditionalWorkoutSummaryData]"
  }
}
