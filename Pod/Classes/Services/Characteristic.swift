//
//  Characteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

protocol Characteristic {
  var UUID:CBUUID { get }
  
  func parse(data data:NSData?) -> CharacteristicModel?
}