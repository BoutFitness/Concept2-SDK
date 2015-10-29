//
//  CharacteristicModelProtocol.swift
//  Pods
//
//  Created by Jesse Curry on 10/24/15.
//
//

protocol CharacteristicModel {
  init(fromData data:NSData)
  
  func updatePerformanceMonitor(performanceMonitor:PerformanceMonitor)
}
