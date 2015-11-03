//
//  RowingStrokeData.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

struct RowingStrokeData: CharacteristicModel, CustomDebugStringConvertible {
  let DataLength = 20
  
  /*
    Data bytes packed as follows:
    Elapsed Time Lo (0.01 sec lsb),
    Elapsed Time Mid,
    Elapsed Time High,
    Distance Lo (0.1 m lsb),
    Distance Mid,
    Distance High,
    Drive Length (0.01 meters, max = 2.55m), CSAFE_PM_GET_STROKESTATS
    Drive Time (0.01 sec, max = 2.55 sec),
    Stroke Recovery Time Lo (0.01 sec, max = 655.35 sec), CSAFE_PM_GET_STROKESTATS
    Stroke Recovery Time Hi, CSAFE_PM_GET_STROKESTATS7
    Stroke Distance Lo (0.01 m, max=655.35m), CSAFE_PM_GET_STROKESTATS
    Stroke Distance Hi,
    Peak Drive Force Lo (0.1 lbs of force, max=6553.5m), CSAFE_PM_GET_STROKESTATS
    Peak Drive Force Hi,
    Average Drive Force Lo (0.1 lbs of force, max=6553.5m), CSAFE_PM_GET_STROKESTATS Average Drive Force Hi,
    Work Per Stroke Lo (0.1 Joules, max=6553.5 Joules), CSAFE_PM_GET_STROKESTATS
    Work Per Stroke Hi
    Stroke Count Lo, CSAFE_PM_GET_STROKESTATS
    Stroke Count Hi,
  */
  
  var elapsedTime:C2TimeInterval
  var distance:C2Distance
  var driveLength:C2DriveLength
  var driveTime:C2DriveTime
  var strokeRecoveryTime:C2TimeInterval
  var strokeDistance:C2Distance
  var peakDriveForce:C2DriveForce
  var averageDriveForce:C2DriveForce
  var workPerStroke:C2Work
  var strokeCount:C2StrokeCount
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
      
    elapsedTime = C2TimeInterval(timeWithLow: UInt32(arr[0]), mid: UInt32(arr[1]), high: UInt32(arr[2]))
    distance = C2Distance(distanceWithLow: UInt32(arr[3]), mid: UInt32(arr[4]), high: UInt32(arr[5]))
    driveLength = C2DriveLength(driveLengthWithLow: arr[6])
    driveTime = C2DriveTime(timeWithLow: UInt32(arr[7]), mid: 0, high: 0)
    strokeRecoveryTime = C2TimeInterval(timeWithLow: UInt32(arr[8]), mid: UInt32(arr[9]), high: 0)
    strokeDistance = C2Distance(distanceWithLow: UInt32(arr[10]), mid: UInt32(arr[11]), high: 0)
    peakDriveForce = C2DriveForce(driveForceWithLow: UInt16(arr[12]), high: UInt16(arr[13]))
    averageDriveForce = C2DriveForce(driveForceWithLow: UInt16(arr[14]), high: UInt16(arr[15]))
    workPerStroke = C2Work(workWithLow: UInt16(arr[16]), high: UInt16(arr[17]))
    strokeCount = C2StrokeCount(strokeCountWithLow: UInt16(arr[18]), high: UInt16(arr[19]))
  }
  
  // MARK: PerformanceMonitor
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    performanceMonitor.elapsedTime.value = elapsedTime
    performanceMonitor.distance.value = distance
    performanceMonitor.driveLength.value = driveLength
    performanceMonitor.driveTime.value = driveTime
    performanceMonitor.strokeRecoveryTime.value = strokeRecoveryTime
    performanceMonitor.strokeDistance.value = strokeDistance
    performanceMonitor.peakDriveForce.value = peakDriveForce
    performanceMonitor.averageDriveForce.value = averageDriveForce
    performanceMonitor.workPerStroke.value = workPerStroke
    performanceMonitor.strokeCount.value = strokeCount
  }
  
  // MARK: -
  var debugDescription:String {
    return "[RowingStrokeData]"
  }
}
