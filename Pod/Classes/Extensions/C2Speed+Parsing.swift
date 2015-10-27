//
//  C2Speed+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

extension C2Speed {
  /**
   */
  init(speedWithLow low:UInt16, high:UInt16) {
    let speedMultiplier:C2Speed = 0.001
    
    self = C2Speed(low | (high << 8)) * speedMultiplier
  }
}
