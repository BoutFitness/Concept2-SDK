//
//  NSTimeInterval+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

typealias C2TimeInterval = NSTimeInterval

extension C2TimeInterval {
  /**
   */
  init(timeWithLow low:UInt32, mid:UInt32, high:UInt32) {
    let timeMultiplier:C2TimeInterval = 0.01
    
    self = C2TimeInterval(UInt32(low)
      | (UInt32(mid) << 8)
      | (UInt32(high) << 16)) * timeMultiplier
  }
}
