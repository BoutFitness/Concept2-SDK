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
    Elapsed Time Lo (0.01 sec lsb), Elapsed Time Mid,
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
  
  init(fromData data: NSData) {
    var arr = [UInt8](count: DataLength, repeatedValue: 0)
    data.getBytes(&arr, length: DataLength)
  }
  
  // MARK: -
  var debugDescription:String {
    return "[RowingStrokeData]"
  }
}
