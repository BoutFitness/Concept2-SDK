//
//  C2IntervalSize+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

extension C2IntervalSize {
  /**
   */
  init(sizeWithLow low:UInt16, high:UInt16) {
    self = C2IntervalSize(low | (high << 8))
  }
}
