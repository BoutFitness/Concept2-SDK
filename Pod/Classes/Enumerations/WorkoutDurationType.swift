//
//  WorkoutDurationType.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

enum WorkoutDurationType:Int {
  case TimeDuration = 0
  case CaloriesDuration = 0x40
  case DistanceDuration = 0x80
  case WattsDuration = 0xC0
  
  var title:String {
    switch self {
    case .TimeDuration:
      return "Time duration"
    case .CaloriesDuration:
      return "Calories duration"
    case .DistanceDuration:
      return "Distance duration"
    case .WattsDuration:
      return "Watts duration"
    }
  }
}
