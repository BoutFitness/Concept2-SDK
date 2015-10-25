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
    
    var dataArray = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&dataArray, length: DataLength)
    
    let lo = UInt32(dataArray[0])
    let mid = UInt32(dataArray[1])
    let high = UInt32(dataArray[2])
    
    let elapsedTime = ((lo) | (mid << 8) | (high << 16))
    
    print("[RowingGeneralStatus]elapse time: \(elapsedTime)")
  }
}