//
//  C2DriveLength+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

extension C2DriveLength {
  /**
   */
  init(driveLengthWithLow low:UInt8) {
    let driveLengthMultiplier:C2DriveLength = 0.01
    
    self = C2DriveLength(low) * driveLengthMultiplier
  }
}

