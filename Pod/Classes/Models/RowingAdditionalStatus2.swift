//
//  RowingAdditionalStatus2.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

struct RowingAdditionalStatus2: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 18
  
  /*
    Data bytes packed as follows:
    Elapsed Time Lo (0.01 sec lsb),
    Elapsed Time Mid,
    Elapsed Time High,
    Interval Count, CSAFE_PM_GET_WORKOUTINTERVALCOUNT14
    Total Calories Lo (cals), CSAFE_PM_GET_TOTAL_AVG_CALORIES
    Total Calories Hi,
    Split/Int Avg Pace Lo (0.01 sec lsb), CSAFE_PM_GET_SPLIT_AVG_500MPACE
    Split/Int Avg Pace Hi,
    Split/Int Avg Power Lo (watts), CSAFE_PM_GET_SPLIT_AVG_POWER
    Split/Int Avg Power Hi,
    Split/Int Avg Calories Lo (cals/hr), CSAFE_PM_GET_SPLIT_A VG_CALORIES
    Split/Interval Avg Calories Hi,
    Last Split Time Lo (0.1 sec lsb), CSAFE_PM_GET_LAST_SPLITTIME
    Last Split Time Mid,
    Last Split Time High,
    Last Split Distance Lo, CSAFE_PM_GET_LAST_SPLITDISTANCE (in meters)
    Last Split Distance Mid,
    Last Split Distance Hi
   */
  
  var elapsedTime:C2TimeInterval
  var intervalCount:C2IntervalCount
  var totalCalories:C2CalorieCount
  var intervalAveragePace:C2Pace
  var intervalAveragePower:C2Power
  var intervalAverageCalories:C2CalorieCount
  var lastSplitTime:C2TimeInterval
  var lastSplitDistance:C2Distance
  
  init(fromData data: Data) {
    var arr = [UInt8](repeating: 0, count: DataLength)
    (data as NSData).getBytes(&arr, length: DataLength)
    
    elapsedTime = C2TimeInterval(timeWithLow: UInt32(arr[0]), mid: UInt32(arr[1]), high: UInt32(arr[2]))
    intervalCount = C2IntervalCount(arr[3])
    totalCalories = C2CalorieCount(calorieCountWithLow: UInt16(arr[4]), high: UInt16(arr[5]))
    intervalAveragePace = C2Pace(paceWithLow: UInt16(arr[6]), high: UInt16(arr[7]))
    intervalAveragePower = C2Power(powerWithLow: UInt16(arr[8]), high: UInt16(arr[9]))
    intervalAverageCalories = C2CalorieCount(calorieCountWithLow: UInt16(arr[10]), high: UInt16(arr[11]))
    lastSplitTime = C2TimeInterval(timeWithLow: UInt32(arr[12]), mid: UInt32(arr[13]), high: UInt32(arr[14]))
    lastSplitDistance = C2Distance(distanceWithLow: UInt32(arr[15]), mid: UInt32(arr[16]), high: UInt32(arr[17]))
  }
  
  // MARK: PerformanceMonitor
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    performanceMonitor.elapsedTime.value = elapsedTime
    performanceMonitor.intervalCount.value = intervalCount
    performanceMonitor.totalCalories.value = totalCalories
    performanceMonitor.intervalAveragePace.value = intervalAveragePace
    performanceMonitor.intervalAveragePower.value = intervalAveragePower
    performanceMonitor.intervalAverageCalories.value = intervalAverageCalories
    performanceMonitor.lastSplitTime.value = lastSplitTime
    performanceMonitor.lastSplitDistance.value = lastSplitDistance
  }
  
  // MARK: -
  var debugDescription:String {
    return "[RowingAdditionalStatus2]"
  }
}
