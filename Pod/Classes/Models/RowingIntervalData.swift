//
//  RowingIntervalData.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

struct RowingIntervalData: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 18
  
  /*
    Data bytes packed as follows:
    Elapsed Time Lo (0.01 sec lsb),
    Elapsed Time Mid,
    Elapsed Time High,
    Distance Lo (0.1 m lsb),
    Distance Mid,
    Distance High,
    Split/Interval Time Lo (0.1 sec lsb),
    Split/Interval Time Mid,
    Split/Interval Time High,
    Split/Interval Distance Lo ( 1m lsb),
    Split/Interval Distance Mid,
    Split/Interval Distance High,
    Interval Rest Time Lo (1 sec lsb),
    Interval Rest Time Hi,
    Interval Rest Distance Lo (1m lsb),
    Interval Rest Distance Hi
    Split/Interval Type,
    Split/Interval Number
  */
  
  var elapsedTime:C2TimeInterval
  var distance:C2Distance
  var intervalTime:C2TimeInterval
  var intervalDistance:C2Distance
  var intervalRestTime:C2TimeInterval
  var intervalRestDistance:C2Distance
  var intervalType:IntervalType?
  var intervalNumber:C2IntervalCount
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
    
    elapsedTime = C2TimeInterval(timeWithLow: UInt32(arr[0]), mid: UInt32(arr[1]), high: UInt32(arr[2]))
    distance = C2Distance(distanceWithLow: UInt32(arr[3]), mid: UInt32(arr[4]), high: UInt32(arr[5]))
    intervalTime = C2TimeInterval(intervalTimeWithLow: UInt32(arr[6]), mid: UInt32(arr[7]), high: UInt32(arr[8]))
    intervalDistance = C2Distance(intervalDistanceWithLow: UInt32(arr[9]), mid: UInt32(arr[10]), high: UInt32(arr[11]))
    intervalRestTime = C2TimeInterval(restTimeWithLow: UInt16(arr[12]), high: UInt16(arr[13]))
    intervalRestDistance = C2Distance(restDistanceWithLow: UInt16(arr[14]), high: UInt16(arr[15]))
    intervalType = IntervalType(rawValue: Int(arr[16]))
    intervalNumber = C2IntervalCount(arr[17])
  }
  
  // MARK: PerformanceMonitor
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    performanceMonitor.elapsedTime.value = elapsedTime
    performanceMonitor.distance.value = distance
    performanceMonitor.intervalTime.value = intervalTime
    performanceMonitor.intervalDistance.value = intervalDistance
    performanceMonitor.intervalRestTime.value = intervalRestTime
    performanceMonitor.intervalRestDistance.value = intervalRestDistance
    performanceMonitor.intervalType.value = intervalType
    performanceMonitor.intervalNumber.value = intervalNumber
  }
  
  // MARK: -
  var debugDescription:String {
    return "[RowingIntervalData]"
  }
}