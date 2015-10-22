//
//  BluetoothManagerTests.swift
//  Example-iOS
//
//  Created by Jesse Curry on 10/21/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import XCTest
import Concept2_SDK
import CoreBluetooth

let scannerDelegate = BluetoothManagerTestDelegate()

class BluetoothManagerTests: XCTestCase {
  let scanner = BluetoothManager(withDelegate: scannerDelegate)
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testScanning() {
    scanner.scanForPerformanceMonitors()
  }
}

class BluetoothManagerTestDelegate: BluetoothManagerDelegate {
  func didLoadPerformanceMonitors(bluetoothManager: BluetoothManager,
    performanceMonitors: Array<PerformanceMonitor>) {
    
  }
}
