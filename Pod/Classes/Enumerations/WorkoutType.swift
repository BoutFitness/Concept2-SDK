//
//  WorkoutTypes.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

public enum WorkoutType:Int {
  case JustRowNoSplits = 0
  case JustRowSplits
  case FixedDistanceNoSplits
  case FixedDistanceSplits
  case FixedTimeNoSplits
  case FixedTimeSplits
  case FixedTimeInterval
  case FixedDistanceInterval
  case VariableInterval
  case VariableUndefinedRestInterval
  case FixedCalorie
  case FixedWattMinutes
  
  var title:String {
    switch self {
    case .JustRowNoSplits:
      return "Just row, no splits"
    case .JustRowSplits:
      return "Just row, with splits"
    case .FixedDistanceNoSplits:
      return "Fixed distance, no splits"
    case .FixedDistanceSplits:
      return "Fixed distance, with splits"
    case .FixedTimeNoSplits:
      return "Fixed time, no splits"
    case .FixedTimeSplits:
      return "Fixed time, with splits"
    case .FixedTimeInterval:
      return "Fixed time intervals"
    case .FixedDistanceInterval:
      return "Fixed distance intervals"
    case .VariableInterval:
      return "Variable intervals"
    case .VariableUndefinedRestInterval:
      return "Variable, with undefined rest intervals"
    case .FixedCalorie:
      return "Fixed calorie"
    case .FixedWattMinutes:
      return "Fixed watt-minutes"
    }
  }
}