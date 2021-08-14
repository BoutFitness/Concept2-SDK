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
  case deviceDiscovery
  case deviceInformation
  case control
  case rowing
  
  init?(uuid:CBUUID) {
    switch uuid {
    case Self.deviceDiscovery.uuid:
      self = .deviceDiscovery
    case Self.deviceInformation.uuid:
      self = .deviceInformation
    case Self.control.uuid:
      self = .control
    case Self.rowing.uuid:
      self = .rowing
    default:
      return nil
    }
  }
  
  var uuid:CBUUID {
    switch self {
    case .deviceDiscovery:
      return CBUUID(string: "CE060000-43E5-11E4-916C-0800200C9A66")
    case .deviceInformation:
      return CBUUID(string: "CE060010-43E5-11E4-916C-0800200C9A66")
    case .control:
      return CBUUID(string: "CE060020-43E5-11E4-916C-0800200C9A66")
    case .rowing:
      return CBUUID(string: "CE060030-43E5-11E4-916C-0800200C9A66")
    }
  }
  
  var characteristicUUIDs:[CBUUID]? {
    switch self {
    case .deviceInformation:
      return [
        DeviceInformationCharacteristic.serialNumber.uuid,
        DeviceInformationCharacteristic.hardwareRevision.uuid,
        DeviceInformationCharacteristic.firmwareRevision.uuid,
        DeviceInformationCharacteristic.manufacturerName.uuid]
    case .control:
      return [
        ControlCharacteristic.response.uuid,
        ControlCharacteristic.command.uuid]
    case .rowing:
      return [
        RowingCharacteristic.generalStatus.uuid,
        RowingCharacteristic.additionalStatus1.uuid,
        RowingCharacteristic.additionalStatus2.uuid,
        RowingCharacteristic.statusSampleRate.uuid,
        RowingCharacteristic.strokeData.uuid,
        RowingCharacteristic.additionalStrokeData.uuid,
        RowingCharacteristic.intervalData.uuid,
        RowingCharacteristic.additionalIntervalData.uuid,
        RowingCharacteristic.workoutSummaryData.uuid,
        RowingCharacteristic.additionalWorkoutSummaryData.uuid,
        RowingCharacteristic.heartRateBeltInformation.uuid,
        RowingCharacteristic.mutliplexedInformation.uuid]
    default:
      return nil
    }
  }
  
  func characteristic(uuid:CBUUID) -> Characteristic? {
    switch self {
    case .deviceInformation:
      return DeviceInformationCharacteristic(uuid: uuid)
    case .control:
      return ControlCharacteristic(uuid: uuid)
    case .rowing:
      return RowingCharacteristic(uuid: uuid)
    default:
      return nil
    }
  }
}
