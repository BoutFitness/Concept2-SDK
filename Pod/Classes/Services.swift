//
//  Services.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

protocol ServiceProtocol {
  var UUID:CBUUID { get }
}

public enum Service:ServiceProtocol {
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
}