//
//  RowingState.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

enum RowingState:Int {
  case Inactive = 0
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
