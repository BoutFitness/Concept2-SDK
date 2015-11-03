//
//  BluetoothManagerTests.swift
//  Example-iOS
//
//  Created by Jesse Curry on 10/21/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import XCTest
import Concept2_SDK

class BluetoothManagerTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testScanning() {
    BluetoothManager.scanForPerformanceMonitors()
  }
}