//
//  PerformanceMonitorStore.swift
//  Pods
//
//  Created by Jesse Curry on 9/30/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

final class PerformanceMonitorStore {
  // Singleton
  static let sharedInstance = PerformanceMonitorStore()
  
  //////////////////////////////////////////////////////////////////////////////////////////////////
  var performanceMonitors = Set<PerformanceMonitor>()

  func addPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    performanceMonitors.insert(performanceMonitor)
  }
  
  func removePerformanceMonitor(performanceMonitor:PerformanceMonitor) {
    performanceMonitors.remove(performanceMonitor)
  }
}