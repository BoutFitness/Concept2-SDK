//
//  ControlCharacteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

public enum ControlCharacteristic:Characteristic {
  case command
  case response
  
  init?(uuid:CBUUID) {
    switch uuid {
    case Self.command.uuid:
      self = .command
    case Self.response.uuid:
      self = .response
    default:
      return nil
    }
  }
  
  var uuid:CBUUID {
    switch self {
    case .command:
      return CBUUID(string: "CE060021-43E5-11E4-916C-0800200C9A66")
    case .response:
      return CBUUID(string: "CE060022-43E5-11E4-916C-0800200C9A66")
    }
  }
  
  func parse(data:Data?) -> CharacteristicModel? {
    switch self {
    case .command:
      return nil
    case .response:
      return nil
    }
  }
}
