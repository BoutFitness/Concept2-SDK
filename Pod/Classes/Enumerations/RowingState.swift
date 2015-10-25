//
//  RowingState.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

enum RowingState {
  case Inactive
  case Active
  
  var title:String {
    switch self {
    case .Inactive:
      return "Inactive"
    case .Active:
      return "Active"
    }
  }
}
