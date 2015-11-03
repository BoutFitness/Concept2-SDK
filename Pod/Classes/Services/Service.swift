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

public enum Service {
  case DeviceDiscovery
  case DeviceInformation
  case Control
  case Rowing
  
  init?(uuid:CBUUID) {
    switch uuid {
    case DeviceDiscovery.UUID:
      self = .DeviceDiscovery
    case DeviceInformation.UUID:
      self = .DeviceInformation
    case Control.UUID:
      self = .Control
    case Rowing.UUID:
      self = .Rowing
    default:
      return nil
    }
  }
  
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
  
  var characteristicUUIDs:[CBUUID]? {
    switch self {
    case .DeviceInformation:
      return [
        DeviceInformationCharacteristic.SerialNumber.UUID,
        DeviceInformationCharacteristic.HardwareRevision.UUID,
        DeviceInformationCharacteristic.FirmwareRevision.UUID,
        DeviceInformationCharacteristic.ManufacturerName.UUID]
    case .Control:
      return [
        ControlCharacteristic.Response.UUID,
        ControlCharacteristic.Command.UUID]
    case .Rowing:
      return [
        RowingCharacteristic.GeneralStatus.UUID,
        RowingCharacteristic.AdditionalStatus1.UUID,
        RowingCharacteristic.AdditionalStatus2.UUID,
        RowingCharacteristic.StatusSampleRate.UUID,
        RowingCharacteristic.StrokeData.UUID,
        RowingCharacteristic.AdditionalStrokeData.UUID,
        RowingCharacteristic.IntervalData.UUID,
        RowingCharacteristic.AdditionalIntervalData.UUID,
        RowingCharacteristic.WorkoutSummaryData.UUID,
        RowingCharacteristic.AdditionalWorkoutSummaryData.UUID,
        RowingCharacteristic.HeartRateBeltInformation.UUID,
        RowingCharacteristic.MutliplexedInformation.UUID]
    default:
      return nil
    }
  }
  
  func characteristic(uuid uuid:CBUUID) -> Characteristic? {
    switch self {
    case .DeviceInformation:
      return DeviceInformationCharacteristic(uuid: uuid)
    case .Control:
      return ControlCharacteristic(uuid: uuid)
    case .Rowing:
      return RowingCharacteristic(uuid: uuid)
    default:
      return nil
    }
  }
}
