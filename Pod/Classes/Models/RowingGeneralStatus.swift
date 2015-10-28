//
//  RowingGeneralStatus.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

struct RowingGeneralStatus: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 19
  
  /*
    Data bytes packed as follows:
    Elapsed Time Lo (0.01 sec lsb),
    Elapsed Time Mid,
    Elapsed Time High,
    Distance Lo (0.1 m lsb),
    Distance Mid,
    Distance High,
    Workout Type 2(enum)      CSAFE_PM_GET_WORKOUTTYPE3
    Interval Type4 (enum)     CSAFE_PM_GET_INTERVALTYPE
    Workout State (enum)      CSAFE_PM_GET_WORKOUTSTATE
    Rowing State (enum)       CSAFE_PM_GET_ROWINGSTATE
    Stroke State (enum)       CSAFE_PM_GET_STROKESTATE
    Total Work Distance Lo,   CSAFE_PM_GET_WORKDISTANCE
    Total Work Distance Mid,
    Total Work Distance Hi,
    Workout Duration Lo (if time, 0.01 sec lsb), CSAFE_PM_GET_WORKOUTDURATION
    Workout Duration Mid,
    Workout Duration Hi,
    Workout Duration Type (enum)    CSAFE_PM_GET_WORKOUTDURATION
    Drag Factor                     CSAFE_PM_GET_DRAGFACTOR
   */
  
  var elapsedTime:C2TimeInterval
  var distance:C2Distance
  var workoutType:WorkoutType?
  var intervalType:IntervalType?
  var workoutState:WorkoutState?
  var rowingState:RowingState?
  var strokeState:StrokeState?
  var totalWorkDistance:C2Distance
  var workoutDuration:C2TimeInterval
  var workoutDurationType:WorkoutDurationType?
  var dragFactor:C2DragFactor
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)

    elapsedTime = C2TimeInterval(timeWithLow: UInt32(arr[0]), mid: UInt32(arr[1]), high: UInt32(arr[2]))
    distance = C2Distance(distanceWithLow: UInt32(arr[3]), mid: UInt32(arr[4]), high: UInt32(arr[5]))
    workoutType = WorkoutType(rawValue: Int(arr[6]))
    intervalType = IntervalType(rawValue: Int(arr[7]))
    workoutState = WorkoutState(rawValue: Int(arr[8]))
    rowingState = RowingState(rawValue: Int(arr[9]))
    strokeState = StrokeState(rawValue: Int(arr[10]))
    totalWorkDistance = C2Distance(distanceWithLow: UInt32(arr[11]), mid: UInt32(arr[12]), high: UInt32(arr[13]))
    workoutDuration = C2TimeInterval(timeWithLow: UInt32(arr[14]), mid: UInt32(arr[15]), high: UInt32(arr[16]))
    workoutDurationType = WorkoutDurationType(rawValue: Int(arr[17]))
    dragFactor = C2DragFactor(arr[18])
  }
  
  // MARK: PerformanceMonitor
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    performanceMonitor.elapsedTime = elapsedTime
    performanceMonitor.distance = distance
    performanceMonitor.workoutType = workoutType
    performanceMonitor.intervalType = intervalType
    performanceMonitor.workoutState = workoutState
    performanceMonitor.rowingState = rowingState
    performanceMonitor.strokeState = strokeState
    performanceMonitor.totalWorkDistance = totalWorkDistance
    performanceMonitor.workoutDuration = workoutDuration
    performanceMonitor.workoutDurationType = workoutDurationType
    performanceMonitor.dragFactor = dragFactor
    
    performanceMonitor.postUpdateValueNotification()
  }
  
  // MARK: -
  var debugDescription:String {
    return "[RowingGeneralStatus]"
    + "\telapsed time: \(elapsedTime)"
    + "\tdistance: \(distance)"
    + "\tworkoutType: \(workoutType)"
    + "\tintervalType: \(intervalType)"
    + "\tworkoutState: \(workoutState)"
    + "\trowingState: \(rowingState)"
    + "\tstrokeState: \(strokeState)"
    + "\ttotalWorkDistance: \(totalWorkDistance)"
    + "\tworkoutDuration: \(workoutDuration)"
    + "\tworkoutDurationType: \(workoutDurationType)"
    + "\tdragFactor: \(dragFactor)"
  }
}
