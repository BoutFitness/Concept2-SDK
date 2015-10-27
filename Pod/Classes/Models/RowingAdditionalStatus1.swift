//
//  RowingAdditionalStatus.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

struct RowingAdditionalStatus1: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 16
  
  /*
    Data bytes packed as follows:
    Elapsed Time Lo (0.01 sec lsb),
    Elapsed Time Mid,
    Elapsed Time High,
    Speed Lo (0.001m/s lsb), CSAFE_GETSPEED_CMD5
    Speed Hi,
    Stroke Rate (strokes/min), CSAFE_PM_GET_STROKERATE
    Heartrate (bpm, 255=invalid), CSAFE_PM_GET_AVG_HEARTRATE
    Current Pace Lo (0.01 sec lsb), CSAFE_PM_GET_STROKE_500MPACE
    Current Pace Hi,
    Average Pace Lo (0.01 sec lsb), CSAFE_PM_GET_TOTAL_AVG_500MPACE
    Average Pace Hi,
    Rest Distance Lo, CSAFE_PM_GET_RESTDISTANCE
    Rest Distance Hi,
    Rest Time Lo, (0.01 sec lsb) CSAFE_PM_GET_RESTTIME
    Rest Time Mid,
    Rest Time Hi
  */
  
  var elapsedTime:C2TimeInterval
  var speed:C2Speed
  var strokeRate:C2StrokeRate
  var heartRate:C2HeartRate
  var currentPace:C2Pace
  var averagePace:C2Pace
  var restDistance:C2Distance
  var restTime:C2TimeInterval
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
    
    elapsedTime = C2TimeInterval(timeWithLow: UInt32(arr[0]), mid: UInt32(arr[1]), high: UInt32(arr[2]))
    speed = C2Speed(speedWithLow: UInt16(arr[3]), high: UInt16(arr[4]))
    strokeRate = C2StrokeRate(arr[5])
    heartRate = C2HeartRate(arr[6])
    currentPace = C2Pace(paceWithLow: UInt16(arr[7]), high: UInt16(arr[8]))
    averagePace = C2Pace(paceWithLow: UInt16(arr[9]), high: UInt16(arr[10]))
    restDistance = C2Distance(distanceWithLow: UInt32(arr[11]), mid: UInt32(arr[12]), high: 0)
    restTime = C2TimeInterval(timeWithLow: UInt32(arr[13]), mid: UInt32(arr[14]), high: UInt32(arr[15]))
  }
  
  // MARK: -
  var debugDescription:String {
      return "[RowingAdditionalStatus1]"
  }
}
