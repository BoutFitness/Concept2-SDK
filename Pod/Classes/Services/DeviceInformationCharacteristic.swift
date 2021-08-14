//
//  DeviceInformationCharacteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

public enum DeviceInformationCharacteristic:Characteristic {
  case serialNumber
  case hardwareRevision
  case firmwareRevision
  case manufacturerName
  
  init?(uuid:CBUUID) {
    switch uuid {
    case Self.serialNumber.uuid:
      self = .serialNumber
    case Self.hardwareRevision.uuid:
      self = .hardwareRevision
    case Self.firmwareRevision.uuid:
      self = .firmwareRevision
    case Self.manufacturerName.uuid:
      self = .manufacturerName
    default:
      return nil
    }
  }
  
  var uuid:CBUUID {
    switch self {
    case .serialNumber:
      return CBUUID(string: "CE060012-43E5-11E4-916C-0800200C9A66")
    case .hardwareRevision:
      return CBUUID(string: "CE060013-43E5-11E4-916C-0800200C9A66")
    case .firmwareRevision:
      return CBUUID(string: "CE060014-43E5-11E4-916C-0800200C9A66")
    case .manufacturerName:
      return CBUUID(string: "CE060015-43E5-11E4-916C-0800200C9A66")
    }
  }
  
  func parse(data:Data?) -> CharacteristicModel? {
    switch self {
    case .serialNumber:
      return nil
    case .hardwareRevision:
      return nil
    case .firmwareRevision:
      return nil
    case .manufacturerName:
      return nil
    }
  }
}
