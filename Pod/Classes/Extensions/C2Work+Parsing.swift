//
//  C2Work+Parsing.swift
//  Pods
//
//  Created by Jesse Curry on 10/27/15.
//
//

extension C2Work {
  /**
   */
  init(workWithLow low:UInt16, high:UInt16) {
    let workMultiplier:C2Work = 0.1
    
    self = C2Work(low | (high << 8)) * workMultiplier
  }
}
