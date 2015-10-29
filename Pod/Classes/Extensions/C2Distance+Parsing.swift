//
//  CGFloat+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

extension C2Distance {
  /**
   */
  init(distanceWithLow low:UInt32, mid:UInt32, high:UInt32) {
    let distanceMultiplier:C2Distance = 0.1
    
    self = C2Distance(low | (mid << 8) | (high << 16)) * distanceMultiplier
  }
  
  init(intervalDistanceWithLow low:UInt32, mid:UInt32, high:UInt32) {
    self = C2Distance(low | (mid << 8) | (high << 16))
  }
  
  init(projectedDistanceWithLow low:UInt32, mid:UInt32, high:UInt32) {
    self = C2Distance(low | (mid << 8) | (high << 16))
  }
  
  init(restDistanceWithLow low:UInt16, high:UInt16) {
    self = C2Distance(low | (high << 8))
  }
  
  init(restDistanceWithLow low:UInt32, mid:UInt32, high:UInt32) {
    self = C2Distance(low | (mid << 8) | (high << 16))
  }
}
