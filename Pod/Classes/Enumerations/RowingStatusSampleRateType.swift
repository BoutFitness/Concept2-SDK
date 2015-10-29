//
//  RowingStatusSampleRateType.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

public enum RowingStatusSampleRateType:UInt8 {
  case OneSecond = 0
  case HalfSecond = 1
  case QuarterSecond = 2
  case TenthSecond = 3
  
  var title:String {
    switch self {
    case .OneSecond:
      return "1 sec"
    case .HalfSecond:
      return "500 ms"
    case .QuarterSecond:
      return "250 ms"
    case .TenthSecond:
      return "100 ms"
    }
  }
}
