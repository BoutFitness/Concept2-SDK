//
//  C2HeartRateBeltID+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

extension C2HeartRateBeltID {
  /**
   */
  init(heartRateBeltIDWithLow low:UInt32, midLow:UInt32, midHigh:UInt32, high:UInt32) {
    self = C2HeartRateBeltID(low | (midLow << 8) | (midHigh << 16) | (high << 24))
  }
}
