//
//  RowingCharacteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

public enum RowingCharacteristic:Characteristic {
  case generalStatus
  case additionalStatus1
  case additionalStatus2
  case statusSampleRate
  case strokeData
  case additionalStrokeData
  case intervalData
  case additionalIntervalData
  case workoutSummaryData
  case additionalWorkoutSummaryData
  case heartRateBeltInformation
  case mutliplexedInformation
  
  init?(uuid:CBUUID) {
      switch uuid {
      case Self.generalStatus.uuid:
      self = .generalStatus
      case Self.additionalStatus1.uuid:
      self = .additionalStatus1
      case Self.additionalStatus2.uuid:
      self = .additionalStatus2
      case Self.statusSampleRate.uuid:
      self = .statusSampleRate
      case Self.strokeData.uuid:
      self = .strokeData
      case Self.additionalStrokeData.uuid:
      self = .additionalStrokeData
      case Self.intervalData.uuid:
      self = .intervalData
      case Self.additionalIntervalData.uuid:
      self = .additionalIntervalData
      case Self.workoutSummaryData.uuid:
      self = .workoutSummaryData
      case Self.additionalWorkoutSummaryData.uuid:
      self = .additionalWorkoutSummaryData
      case Self.heartRateBeltInformation.uuid:
      self = .heartRateBeltInformation
      case Self.mutliplexedInformation.uuid:
      self = .mutliplexedInformation
    default:
      return nil
    }
  }

    var id: String {
        switch self {
        case .generalStatus:
          return "CE060031-43E5-11E4-916C-0800200C9A66"
        case .additionalStatus1:
          return "CE060032-43E5-11E4-916C-0800200C9A66"
        case .additionalStatus2:
          return "CE060033-43E5-11E4-916C-0800200C9A66"
        case .statusSampleRate:
          return "CE060034-43E5-11E4-916C-0800200C9A66"
        case .strokeData:
          return "CE060035-43E5-11E4-916C-0800200C9A66"
        case .additionalStrokeData:
          return "CE060036-43E5-11E4-916C-0800200C9A66"
        case .intervalData:
          return "CE060037-43E5-11E4-916C-0800200C9A66"
        case .additionalIntervalData:
          return "CE060038-43E5-11E4-916C-0800200C9A66"
        case .workoutSummaryData:
          return "CE060039-43E5-11E4-916C-0800200C9A66"
        case .additionalWorkoutSummaryData:
          return "CE06003A-43E5-11E4-916C-0800200C9A66"
        case .heartRateBeltInformation:
          return "CE06003B-43E5-11E4-916C-0800200C9A66"
        case .mutliplexedInformation:
          return "CE060080-43E5-11E4-916C-0800200C9A66"
        }
    }

  var uuid:CBUUID {
    switch self {
    case .generalStatus:
      return CBUUID(string: "CE060031-43E5-11E4-916C-0800200C9A66")
    case .additionalStatus1:
      return CBUUID(string: "CE060032-43E5-11E4-916C-0800200C9A66")
    case .additionalStatus2:
      return CBUUID(string: "CE060033-43E5-11E4-916C-0800200C9A66")
    case .statusSampleRate:
      return CBUUID(string: "CE060034-43E5-11E4-916C-0800200C9A66")
    case .strokeData:
      return CBUUID(string: "CE060035-43E5-11E4-916C-0800200C9A66")
    case .additionalStrokeData:
      return CBUUID(string: "CE060036-43E5-11E4-916C-0800200C9A66")
    case .intervalData:
      return CBUUID(string: "CE060037-43E5-11E4-916C-0800200C9A66")
    case .additionalIntervalData:
      return CBUUID(string: "CE060038-43E5-11E4-916C-0800200C9A66")
    case .workoutSummaryData:
      return CBUUID(string: "CE060039-43E5-11E4-916C-0800200C9A66")
    case .additionalWorkoutSummaryData:
      return CBUUID(string: "CE06003A-43E5-11E4-916C-0800200C9A66")
    case .heartRateBeltInformation:
      return CBUUID(string: "CE06003B-43E5-11E4-916C-0800200C9A66")
    case .mutliplexedInformation:
      return CBUUID(string: "CE060080-43E5-11E4-916C-0800200C9A66")
    }
  }
  
  func parse(data:Data?) -> CharacteristicModel? {
    if let data = data {
      switch self {
      case .generalStatus:
        return RowingGeneralStatus(fromData: data)
      case .additionalStatus1:
        return RowingAdditionalStatus1(fromData: data)
      case .additionalStatus2:
        return RowingAdditionalStatus2(fromData: data)
      case .statusSampleRate:
        return RowingStatusSampleRate(fromData: data)
      case .strokeData:
        return RowingStrokeData(fromData: data)
      case .additionalStrokeData:
        return RowingAdditionalStrokeData(fromData: data)
      case .intervalData:
        return RowingIntervalData(fromData: data)
      case .additionalIntervalData:
        return RowingAdditionalIntervalData(fromData: data)
      case .workoutSummaryData:
        return RowingWorkoutSummaryData(fromData: data)
      case .additionalWorkoutSummaryData:
        return RowingAdditionalWorkoutSummaryData(fromData: data)
      case .heartRateBeltInformation:
        return RowingHeartRateBeltInformation(fromData: data)
      case .mutliplexedInformation:
        return nil // JLC: this service gives the same data as the others
      }
    }
    else {
      return nil
    }
  }
}
