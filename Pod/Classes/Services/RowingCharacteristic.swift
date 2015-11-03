//
//  RowingCharacteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

public enum RowingCharacteristic:Characteristic {
  case GeneralStatus
  case AdditionalStatus1
  case AdditionalStatus2
  case StatusSampleRate
  case StrokeData
  case AdditionalStrokeData
  case IntervalData
  case AdditionalIntervalData
  case WorkoutSummaryData
  case AdditionalWorkoutSummaryData
  case HeartRateBeltInformation
  case MutliplexedInformation
  
  init?(uuid:CBUUID) {
    switch uuid {
    case GeneralStatus.UUID:
      self = .GeneralStatus
    case AdditionalStatus1.UUID:
      self = .AdditionalStatus1
    case AdditionalStatus2.UUID:
      self = .AdditionalStatus2
    case StatusSampleRate.UUID:
      self = .StatusSampleRate
    case StrokeData.UUID:
      self = .StrokeData
    case AdditionalStrokeData.UUID:
      self = .AdditionalStrokeData
    case IntervalData.UUID:
      self = .IntervalData
    case AdditionalIntervalData.UUID:
      self = .AdditionalIntervalData
    case WorkoutSummaryData.UUID:
      self = .WorkoutSummaryData
    case AdditionalWorkoutSummaryData.UUID:
      self = .AdditionalWorkoutSummaryData
    case HeartRateBeltInformation.UUID:
      self = .HeartRateBeltInformation
    case MutliplexedInformation.UUID:
      self = .MutliplexedInformation
    default:
      return nil
    }
  }
  
  var UUID:CBUUID {
    switch self {
    case .GeneralStatus:
      return CBUUID(string: "CE060031-43E5-11E4-916C-0800200C9A66")
    case .AdditionalStatus1:
      return CBUUID(string: "CE060032-43E5-11E4-916C-0800200C9A66")
    case .AdditionalStatus2:
      return CBUUID(string: "CE060033-43E5-11E4-916C-0800200C9A66")
    case .StatusSampleRate:
      return CBUUID(string: "CE060034-43E5-11E4-916C-0800200C9A66")
    case .StrokeData:
      return CBUUID(string: "CE060035-43E5-11E4-916C-0800200C9A66")
    case .AdditionalStrokeData:
      return CBUUID(string: "CE060036-43E5-11E4-916C-0800200C9A66")
    case .IntervalData:
      return CBUUID(string: "CE060037-43E5-11E4-916C-0800200C9A66")
    case .AdditionalIntervalData:
      return CBUUID(string: "CE060038-43E5-11E4-916C-0800200C9A66")
    case .WorkoutSummaryData:
      return CBUUID(string: "CE060039-43E5-11E4-916C-0800200C9A66")
    case .AdditionalWorkoutSummaryData:
      return CBUUID(string: "CE06003A-43E5-11E4-916C-0800200C9A66")
    case .HeartRateBeltInformation:
      return CBUUID(string: "CE06003B-43E5-11E4-916C-0800200C9A66")
    case .MutliplexedInformation:
      return CBUUID(string: "CE060080-43E5-11E4-916C-0800200C9A66")
    }
  }
  
  func parse(data data:NSData?) -> CharacteristicModel? {
    if let data = data {
      switch self {
      case .GeneralStatus:
        return RowingGeneralStatus(fromData: data)
      case .AdditionalStatus1:
        return RowingAdditionalStatus1(fromData: data)
      case .AdditionalStatus2:
        return RowingAdditionalStatus2(fromData: data)
      case .StatusSampleRate:
        return RowingStatusSampleRate(fromData: data)
      case .StrokeData:
        return RowingStrokeData(fromData: data)
      case .AdditionalStrokeData:
        return RowingAdditionalStrokeData(fromData: data)
      case .IntervalData:
        return RowingIntervalData(fromData: data)
      case .AdditionalIntervalData:
        return RowingAdditionalIntervalData(fromData: data)
      case .WorkoutSummaryData:
        return RowingWorkoutSummaryData(fromData: data)
      case .AdditionalWorkoutSummaryData:
        return RowingAdditionalWorkoutSummaryData(fromData: data)
      case .HeartRateBeltInformation:
        return RowingHeartRateBeltInformation(fromData: data)
      case .MutliplexedInformation:
        return nil // JLC: this service gives the same data as the others
      }
    }
    else {
      return nil
    }
  }
}
