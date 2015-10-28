//
//  StrokeState.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

public enum StrokeState:Int {
  case WaitingForWheelToReachMinSpeed = 0
  case WaitingForWheelToAccelerate
  case Driving
  case DwellingAfterDrive
  case Recovery
  
  var title:String {
    switch self {
    case .WaitingForWheelToReachMinSpeed:
      return "Waiting for wheel to reach minimum speed"
    case .WaitingForWheelToAccelerate:
      return "Waiting for wheel to accelerate"
    case .Driving:
      return "Driving"
    case .DwellingAfterDrive:
      return "Dwelling after drive"
    case .Recovery:
      return "Recovery"
    }
  }
}
