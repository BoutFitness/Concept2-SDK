//
//  ViewController.swift
//  Example-OSX
//
//  Created by Jesse Curry on 10/20/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import Cocoa
import Concept2_SDK
import CoreBluetooth

class ViewController: NSViewController {

  var pm:BluetoothScanner?
  var peripherals = Array<CBPeripheral>()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    pm = Concept2_SDK.BluetoothScanner(withDelegate: self)
  }
  
  override var representedObject: AnyObject? {
    didSet {
    // Update the view, if already loaded.
    }
  }
  
  @IBAction
  func scanDevicesAction(sender:AnyObject?) {
    pm?.scanForPerformanceMonitors()
  }
}

// MARK: BluetoothScannerDelegate
extension ViewController: BluetoothScannerDelegate {
  func didLoadPeripherals(bluetoothScanner: BluetoothScanner, peripherals: Array<CBPeripheral>) {
    self.peripherals = peripherals
  }
}