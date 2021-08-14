//
//  Characteristic.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

import CoreBluetooth

protocol Characteristic {
  var uuid:CBUUID { get }
  
  func parse(data:Data?) -> CharacteristicModel?
}
