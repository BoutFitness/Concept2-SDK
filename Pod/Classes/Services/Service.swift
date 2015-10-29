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

public enum Service:String {
  case DeviceDiscovery = "CE060000-43E5-11E4-916C-0800200C9A66"
  case DeviceInformation = "CE060010-43E5-11E4-916C-0800200C9A66"
  case Control = "CE060020-43E5-11E4-916C-0800200C9A66"
  case Rowing = "CE060030-43E5-11E4-916C-0800200C9A66"
  
  var UUID:CBUUID { return CBUUID(string: self.rawValue) }
  
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
  
  func characteristic(string string:String) -> Characteristic? {
    switch self {
    case .DeviceInformation:
      return DeviceInformationCharacteristic(rawValue: string)
    case .Control:
      return ControlCharacteristic(rawValue: string)
    case .Rowing:
      return RowingCharacteristic(rawValue: string)
    default:
      return nil
    }
  }
}
