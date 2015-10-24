//
//  IntervalType.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

enum IntervalType:Int {
  case Time = 0
  case Distance
  case Rest
  case TimeRestUndefined
  case DistanceRestUndefined
  case RestUndefined
  case Calorie
  case CalorieRestUndefined
  case WattMinute
  case WattMinuteRestUndefined
  case None = 255
  
  var title:String {
    switch self {
    case .Time:
      return "Time"
    case .Distance:
      return "Distance"
    case .Rest:
      return "Rest"
    case .TimeRestUndefined:
      return "Time, rest undefined"
    case .DistanceRestUndefined:
      return "Distance, rest undefined"
    case .RestUndefined:
      return "Rest undefined"
    case .Calorie:
      return "Calorie"
    case .CalorieRestUndefined:
      return "Calorie, rest undefined"
    case .WattMinute:
      return "Watt minute"
    case .WattMinuteRestUndefined:
      return "Watt minute, rest undefined"
    case .None:
      return "None"
    }
  }
}
