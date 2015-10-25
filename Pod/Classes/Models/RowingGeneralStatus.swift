//
//  RowingGeneralStatus.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

final class RowingGeneralStatus: CharacteristicModel {
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
  
  init(fromData data: NSData) {
    assert(data.length == DataLength, "Unexpected data length!")
    
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
    
    let elapsedTime = (UInt32(arr[0]) | (UInt32(arr[1]) << 8) | (UInt32(arr[2]) << 16))
    let distance = (UInt32(arr[3]) | (UInt32(arr[4]) << 8) | (UInt32(arr[5]) << 16))
    let workoutType = WorkoutType(rawValue: Int(arr[6]))
    let intervalType = IntervalType(rawValue: Int(arr[7]))
    let workoutState = WorkoutState(rawValue: Int(arr[8]))
    let rowingState = RowingState(rawValue: Int(arr[9]))
    let strokeState = Int(arr[10])
    let totalWorkDistance = (UInt32(arr[11]) | (UInt32(arr[12]) << 8) | (UInt32(arr[13]) << 16))
    let workoutDuration = (UInt32(arr[14]) | (UInt32(arr[15]) << 8) | (UInt32(arr[16]) << 16))
    let workoutDurationType = Int(arr[17])
    let dragFactor = arr[18]
    
    print("[RowingGeneralStatus]")
    print("\telapsed time: \(Double(elapsedTime) * 0.01)")
    print("\tdistance: \(Double(distance) * 0.1)")
    print("\tworkoutType: \(workoutType)")
    print("\tintervalType: \(intervalType)")
    print("\tworkoutState: \(workoutState)")
    print("\trowingState: \(rowingState)")
    print("\tstrokeState: \(strokeState)")
    print("\ttotalWorkDistance: \(Double(totalWorkDistance) * 1.0))")
    print("\tworkoutDuration: \(Double(workoutDuration) * 0.01)")
    print("\tworkoutDurationType: \(workoutDurationType)")
    print("\tdragFactor: \(dragFactor)")
  }
}