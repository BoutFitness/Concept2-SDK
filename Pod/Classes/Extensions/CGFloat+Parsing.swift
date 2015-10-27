//
//  CGFloat+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/26/15.
//
//

typealias C2Distance = Double

extension C2Distance {
  /**
   */
  init(distanceWithLow low:UInt32, mid:UInt32, high:UInt32) {
    let distanceMultiplier:C2Distance = 0.1
    
    self = C2Distance(UInt32(low)
      | (UInt32(mid) << 8)
      | (UInt32(high) << 16)) * distanceMultiplier
  }
}
