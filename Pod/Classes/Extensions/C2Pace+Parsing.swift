//
//  C2Pace+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

extension C2Pace {
  /**
   */
  init(paceWithLow low:UInt16, high:UInt16) {
    let paceMultiplier:C2Pace = 0.01
    
    self = C2Pace(low | (high << 8)) * paceMultiplier
  }
}
