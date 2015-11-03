//
//  RowingWorkoutSummaryData.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

struct RowingWorkoutSummaryData: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 20
  
  /*
    Data bytes packed as follows:
    Log Entry Date Lo,
    Log Entry Date Hi,
    Log Entry Time Lo,
    Log Entry Time Hi,
    Elapsed Time Lo (0.01 sec lsb),
    Elapsed Time Mid,
    Elapsed Time High,
    Distance Lo (0.1 m lsb),
    Distance Mid,
    Distance High,
    Average Stroke Rate,
    Ending Heartrate,
    Average Heartrate,
    Min Heartrate,
    Max Heartrate,
    Drag Factor Average,
    Recovery Heart Rate, (zero = not valid data. Updated after 1 minute of rest/recovery)
    Workout Type,
    Avg Pace Lo (0.1 sec lsb)
    Avg Pace Hi
  */
  
  var logEntryDate:C2Date
  var logEntryTime:C2Time
  var elapsedTime:C2TimeInterval
  var distance:C2Distance
  var averageStrokeRate:C2StrokeRate
  var endingHeartRate:C2HeartRate
  var averageHeartRate:C2HeartRate
  var minimumHeartRate:C2HeartRate
  var maximumHeartRate:C2HeartRate
  var dragFactorAverage:C2DragFactor
  var recoveryHeartRate:C2HeartRate
  var workoutType:WorkoutType?
  var averagePace:C2Pace
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
    
    logEntryDate = 0 // TODO: find date/time format
    logEntryTime = 0
    elapsedTime = C2TimeInterval(timeWithLow: UInt32(arr[4]), mid: UInt32(arr[5]), high: UInt32(arr[6]))
    distance = C2Distance(distanceWithLow: UInt32(arr[7]), mid: UInt32(arr[8]), high: UInt32(arr[9]))
    averageStrokeRate = C2StrokeRate(arr[10])
    endingHeartRate = C2HeartRate(arr[11])
    averageHeartRate = C2HeartRate(arr[12])
    minimumHeartRate = C2HeartRate(arr[13])
    maximumHeartRate = C2HeartRate(arr[14])
    dragFactorAverage = C2DragFactor(arr[15])
    recoveryHeartRate = C2HeartRate(arr[16])
    workoutType = WorkoutType(rawValue: Int(arr[17]))
    averagePace = C2Pace(paceWithLow: UInt16(arr[18]), high: UInt16(arr[19]))
  }
  
  // MARK: PerformanceMonitor
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
//    performanceMonitor.logEntryDate.value = logEntryDate
//    performanceMonitor.logEntryTime.value = logEntryTime
    performanceMonitor.elapsedTime.value = elapsedTime
    performanceMonitor.distance.value = distance
//    performanceMonitor.averageStrokeRate.value = averageStrokeRate
//    performanceMonitor.endingHeartRate.value = endingHeartRate
//    performanceMonitor.averageHeartRate.value = averageHeartRate
//    performanceMonitor.minimumHeartRate.value = minimumHeartRate
//    performanceMonitor.maximumHeartRate.value = maximumHeartRate
//    performanceMonitor.dragFactorAverage.value = dragFactorAverage
//    performanceMonitor.recoveryHeartRate.value = recoveryHeartRate
    performanceMonitor.workoutType.value = workoutType
    performanceMonitor.averagePace.value = averagePace
    
    performanceMonitor.postUpdateValueNotification()
  }
  
  // MARK: -
  var debugDescription:String {
      return "[RowingWorkoutSummaryData]"
  }
}
