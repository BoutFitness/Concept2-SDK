//
//  DeviceInformationCharacteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

public enum DeviceInformationCharacteristic:String, Characteristic {
  case SerialNumber = "CE060012-43E5-11E4-916C-0800200C9A66"
  case HardwareRevision = "CE060013-43E5-11E4-916C-0800200C9A66"
  case FirmwareRevision = "CE060014-43E5-11E4-916C-0800200C9A66"
  case ManufacturerName = "CE060015-43E5-11E4-916C-0800200C9A66"
  
  var UUID:CBUUID { return CBUUID(string: self.rawValue) }
  
  func parse(data data:NSData?) -> CharacteristicModel? {
    switch self {
    case .SerialNumber:
      return nil
    case .HardwareRevision:
      return nil
    case .FirmwareRevision:
      return nil
    case .ManufacturerName:
      return nil
    }
  }
}
