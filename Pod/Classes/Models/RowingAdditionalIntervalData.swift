//
//  RowingAdditionalIntervalData.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

struct RowingAdditionalIntervalData: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 18
  
  /*
  Data bytes packed as follows:
  Elapsed Time Lo (0.01 sec lsb),
  Elapsed Time Mid,
  Elapsed Time High,
  Split/Interval Avg Stroke Rate,
  Split/Interval Work Heartrate,
  Split/Interval Rest Heartrate,
  Split/Interval Avg Pace Lo (0.1 sec lsb)
  Split/Interval Avg Pace Hi,
  Split/Interval Total Calories Lo (Cals),
  Split/Interval Total Calories Hi,
  Split/Interval Avg Calories Lo (Cals/Hr),
  Split/Interval Avg Calories Hi,
  Split/Interval Speed Lo (0.001 m/s, max=65.534 m/s)
  Split/Interval Speed Hi,
  Split/Interval Power Lo (Watts, max = 65.534 kW)
  Split/Interval Power Hi
  Split Avg Drag Factor,
  Split/Interval Number
  */
  
  var elapsedTime:C2TimeInterval
  var intervalAverageStrokeRate:C2StrokeRate
  var intervalWorkHeartrate:C2HeartRate
  var intervalRestHeartrate:C2HeartRate
  var intervalAveragePace:C2Pace
  var intervalTotalCalories:C2CalorieCount
  var intervalAverageCalories:C2CalorieCount
  var intervalSpeed:C2Speed
  var intervalPower:C2Power
  var splitAverageDragFactor:C2DragFactor
  var intervalNumber:C2IntervalCount
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
    
    elapsedTime = C2TimeInterval(timeWithLow: UInt32(arr[0]), mid: UInt32(arr[1]), high: UInt32(arr[2]))
    intervalAverageStrokeRate = C2StrokeRate(arr[3])
    intervalWorkHeartrate = C2HeartRate(arr[4])
    intervalRestHeartrate = C2HeartRate(arr[5])
    intervalAveragePace = C2Pace(paceWithLow: UInt16(arr[6]), high: UInt16(arr[7]))
    intervalTotalCalories = C2CalorieCount(calorieCountWithLow: UInt16(arr[8]), high: UInt16(arr[9]))
    intervalAverageCalories = C2CalorieCount(calorieCountWithLow: UInt16(arr[10]), high: UInt16(arr[11]))
    intervalSpeed = C2Speed(speedWithLow: UInt16(arr[12]), high: UInt16(arr[13]))
    intervalPower = C2Power(powerWithLow: UInt16(arr[14]), high: UInt16(arr[15]))
    splitAverageDragFactor = C2DragFactor(arr[16])
    intervalNumber = C2IntervalCount(arr[17])
  }
  
  // MARK: PerformanceMonitor
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    performanceMonitor.elapsedTime.value = elapsedTime
    performanceMonitor.intervalAverageStrokeRate.value = intervalAverageStrokeRate
    performanceMonitor.intervalWorkHeartrate.value = intervalWorkHeartrate
    performanceMonitor.intervalRestHeartrate.value = intervalRestHeartrate
    performanceMonitor.intervalAveragePace.value = intervalAveragePace
    performanceMonitor.intervalTotalCalories.value = intervalTotalCalories
    performanceMonitor.intervalAverageCalories.value = intervalAverageCalories
    performanceMonitor.intervalSpeed.value = intervalSpeed
    performanceMonitor.intervalPower.value = intervalPower
    performanceMonitor.splitAverageDragFactor.value = splitAverageDragFactor
    performanceMonitor.intervalNumber.value = intervalNumber
    
    performanceMonitor.postUpdateValueNotification()
  }
  
  // MARK: -
  var debugDescription:String {
      return "[RowingAdditionalIntervalData]"
  }
}
