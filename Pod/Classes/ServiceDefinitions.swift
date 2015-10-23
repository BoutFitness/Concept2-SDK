//
//  Services.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

/**
 See: http://www.concept2.com/files/pdf/us/monitors/PM5_BluetoothSmartInterfaceDefinition.pdf
 */

protocol ServiceDefinitionProtocol {
  var UUID:CBUUID { get }
  var characteristicUUIDs:[CBUUID] { get }
  var service:Service? { get }
}

public enum ServiceDefinition:ServiceDefinitionProtocol {
  case DeviceDiscovery
  case DeviceInformation
  case Control
  case Rowing
  
  var UUID:CBUUID {
    switch self {
    case .DeviceDiscovery:
      return CBUUID(string: "CE060000-43E5-11E4-916C-0800200C9A66")
    case .DeviceInformation:
      return CBUUID(string: "CE060010-43E5-11E4-916C-0800200C9A66")
    case .Control:
      return CBUUID(string: "CE060020-43E5-11E4-916C-0800200C9A66")
    case .Rowing:
      return CBUUID(string: "CE060030-43E5-11E4-916C-0800200C9A66")
    }
  }
  
  var characteristicUUIDs:[CBUUID] {
    switch self {
    case .DeviceInformation:
      return [
        DeviceInformationCharacteristicDefinition.SerialNumber.UUID,
        DeviceInformationCharacteristicDefinition.HardwareRevision.UUID,
        DeviceInformationCharacteristicDefinition.FirmwareRevision.UUID,
        DeviceInformationCharacteristicDefinition.ManufacturerName.UUID]
    default:
      return [DeviceInformationCharacteristicDefinition.SerialNumber.UUID]
    }
  }
  
  var service:Service? {
    switch self {
    case .DeviceDiscovery:
      return nil
    case .DeviceInformation:
      return DeviceInformationService()
    case .Control:
      return ControlService()
    case .Rowing:
      return RowingService()
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
protocol CharacteristicDefinitionProtocol {
  var UUID:CBUUID { get }
}

// MARK: Device Discovery
public enum DeviceDiscoveryCharacteristicDefinition:CharacteristicDefinitionProtocol {
  var UUID:CBUUID {
    switch self {
    default:
      return CBUUID()
    }
  }
}

// MARK: DeviceInformation
public enum DeviceInformationCharacteristicDefinition:CharacteristicDefinitionProtocol {
  case SerialNumber
  case HardwareRevision
  case FirmwareRevision
  case ManufacturerName
  
  var UUID:CBUUID {
    switch self {
    case .SerialNumber:
      return CBUUID(string: "CE060012-43E5-11E4-916C-0800200C9A66")
    case .HardwareRevision:
      return CBUUID(string: "CE060013-43E5-11E4-916C-0800200C9A66")
    case .FirmwareRevision:
      return CBUUID(string: "CE060014-43E5-11E4-916C-0800200C9A66")
    case .ManufacturerName:
      return CBUUID(string: "CE060015-43E5-11E4-916C-0800200C9A66")
    }
  }
}

// MARK: Control
public enum ControlCharacteristicDefinition:CharacteristicDefinitionProtocol {
  case Command
  case Response
  
  var UUID:CBUUID {
    switch self {
    case .Command:
      return CBUUID(string: "CE060021-43E5-11E4-916C-0800200C9A66")
    case .Response:
      return CBUUID(string: "CE060022-43E5-11E4-916C-0800200C9A66")
    }
  }
}

// MARK: Rowing
public enum RowingCharacteristicDefinition:CharacteristicDefinitionProtocol {
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
}
