//
//  C2DriveForce+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

extension C2DriveForce {
  /**
   */
  init(driveForceWithLow low:UInt16, high:UInt16) {
    let driveForceMultiplier:C2DriveForce = 0.1
    
    self = C2DriveForce(low | (high << 8)) * driveForceMultiplier
  }
}
