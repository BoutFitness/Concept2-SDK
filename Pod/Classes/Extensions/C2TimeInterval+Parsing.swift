//
//  NSTimeInterval+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

extension C2TimeInterval {
  /**
   */
  init(timeWithLow low:UInt32, mid:UInt32, high:UInt32) {
    let timeMultiplier:C2TimeInterval = 0.01
    
    self = C2TimeInterval(low | (mid << 8) | (high << 16)) * timeMultiplier
  }
}
