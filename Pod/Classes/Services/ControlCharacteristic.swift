//
//  ControlCharacteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

public enum ControlCharacteristic:String, Characteristic {
  case Command = "CE060021-43E5-11E4-916C-0800200C9A66"
  case Response = "CE060022-43E5-11E4-916C-0800200C9A66"
  
  var UUID:CBUUID { return CBUUID(string: self.rawValue) }
  
  func parse(data data:NSData?) -> CharacteristicModel? {
    switch self {
    case .Command:
      return nil
    case .Response:
      return nil
    }
  }
}
