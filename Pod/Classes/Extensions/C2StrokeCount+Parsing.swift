//
//  C2StrokeCount+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

extension C2StrokeCount {
  /**
   */
  init(strokeCountWithLow low:UInt16, high:UInt16) {
    self = C2StrokeCount(low | (high << 8))
  }
}
