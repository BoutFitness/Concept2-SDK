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
  
  init(intervalTimeWithLow low:UInt32, mid:UInt32, high:UInt32) {
    let timeMultiplier:C2TimeInterval = 0.1
    
    self = C2TimeInterval(low | (mid << 8) | (high << 16)) * timeMultiplier
  }
  
  init(projectedTimeWithLow low:UInt32, mid:UInt32, high:UInt32) {
    self = C2TimeInterval(low | (mid << 8) | (high << 16))
  }
  
  init(restTimeWithLow low:UInt16, high:UInt16) {
    self = C2TimeInterval(low | (high << 8))
  }
}
