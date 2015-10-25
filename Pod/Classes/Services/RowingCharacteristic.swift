//
//  RowingCharacteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

public enum RowingCharacteristic:String, Characteristic {
  case GeneralStatus = "CE060031-43E5-11E4-916C-0800200C9A66"
  case AdditionalStatus1 = "CE060032-43E5-11E4-916C-0800200C9A66"
  case AdditionalStatus2 = "CE060033-43E5-11E4-916C-0800200C9A66"
  case StatusSampleRate = "CE060034-43E5-11E4-916C-0800200C9A66"
  case StrokeData = "CE060035-43E5-11E4-916C-0800200C9A66"
  case AdditionalStrokeData = "CE060036-43E5-11E4-916C-0800200C9A66"
  case IntervalData = "CE060037-43E5-11E4-916C-0800200C9A66"
  case AdditionalIntervalData = "CE060038-43E5-11E4-916C-0800200C9A66"
  case WorkoutSummaryData = "CE060039-43E5-11E4-916C-0800200C9A66"
  case AdditionalWorkoutSummaryData = "CE06003A-43E5-11E4-916C-0800200C9A66"
  case HeartRateBeltInformation = "CE06003B-43E5-11E4-916C-0800200C9A66"
  case MutliplexedInformation = "CE060080-43E5-11E4-916C-0800200C9A66"
  
  var UUID:CBUUID { return CBUUID(string: self.rawValue) }
  
  func parse(data data:NSData?) -> CharacteristicModel? {
    if let data = data {
      switch self {
      case .GeneralStatus:
        return RowingGeneralStatus(fromData: data)
      case .AdditionalStatus1:
        return nil
      case .AdditionalStatus2:
        return nil
      case .StatusSampleRate:
        return nil
      case .StrokeData:
        return nil
      case .AdditionalStrokeData:
        return nil
      case .IntervalData:
        return nil
      case .AdditionalIntervalData:
        return nil
      case .WorkoutSummaryData:
        return nil
      case .AdditionalWorkoutSummaryData:
        return nil
      case .HeartRateBeltInformation:
        return nil
      case .MutliplexedInformation:
        return nil
      }
    }
    else {
      return nil
    }
  }
}
