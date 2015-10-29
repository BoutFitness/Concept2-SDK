//
//  RowingAdditionalStrokeData.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

struct RowingAdditionalStrokeData: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 15
  
  /*
  Data bytes packed as follows:
  Elapsed Time Lo (0.01 sec lsb),
  Elapsed Time Mid,
  Elapsed Time High,
  Stroke Power Lo (watts), CSAFE_PM_GET_STROKE_POWER
  Stroke Power Hi,
  Stroke Calories Lo (cal/hr), CSAFE_PM_GET_STROKE_CALORICBURNRATE
  Stroke Calories Hi,
  Stroke Count Lo, CSAFE_PM_GET_STROKESTATS
  Stroke Count Hi,
  Projected Work Time Lo (secs),
  Projected Work Time Mid,
  Projected Work Time Hi,
  Projected Work Distance Lo (meters),
  Projected Work Distance Mid,
  Projected Work Distance Hi
  */
  
  var elapsedTime:C2TimeInterval
  var strokePower:C2Power
  var strokeCalories:C2CalorieCount
  var strokeCount:C2StrokeCount
  var projectedWorkTime:C2TimeInterval
  var projectedWorkDistance:C2Distance
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
    
    elapsedTime = C2TimeInterval(timeWithLow: UInt32(arr[0]), mid: UInt32(arr[1]), high: UInt32(arr[2]))
    strokePower = C2Power(powerWithLow: UInt16(arr[3]), high: UInt16(arr[4]))
    strokeCalories = C2CalorieCount(calorieCountWithLow: UInt16(arr[5]), high: UInt16(arr[6]))
    strokeCount = C2StrokeCount(strokeCountWithLow: UInt16(arr[7]), high: UInt16(arr[8]))
    projectedWorkTime = C2TimeInterval(
      projectedTimeWithLow: UInt32(arr[9]), mid: UInt32(arr[10]), high: UInt32(arr[11]))
    projectedWorkDistance = C2Distance(
      projectedDistanceWithLow:  UInt32(arr[12]), mid: UInt32(arr[13]), high: UInt32(arr[14]))
  }
  
  // MARK: PerformanceMonitor
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
      
  }
  
  // MARK: -
  var debugDescription:String {
    return "[RowingAdditionalStrokeData]"
  }
}

