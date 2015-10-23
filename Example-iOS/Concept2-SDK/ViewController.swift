//
//  ViewController.swift
//  Concept2-SDK
//
//  Created by jessecurry on 09/27/2015.
//  Copyright (c) 2015 jessecurry. All rights reserved.
//

import UIKit
import Concept2_SDK
import CoreBluetooth

class ViewController: UIViewController {
  @IBOutlet var scanButton:UIButton!
  @IBOutlet var tableView:UITableView!
  
  //
  var manager:BluetoothManager?
  var performanceMonitors = Array<PerformanceMonitor>()
  
  // MARK: UIViewController lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    manager = Concept2_SDK.BluetoothManager(withDelegate: self)
    NSNotificationCenter.defaultCenter().addObserverForName(
      BluetoothManagerDidUpdateStateNotification,
      object: manager,
      queue: nil) { (notification) -> Void in
        self.managerStateDidUpdate()
    }
    
    NSNotificationCenter.defaultCenter().addObserverForName(
      PerformanceMonitorDidUpdateStateNotification,
      object:  nil,
      queue: nil) { (notification) -> Void in
        if let pm = notification.object as? PerformanceMonitor {
          self.performanceMonitorStateDidUpdate(pm)
        }
    }
    
    managerStateDidUpdate()
    tableView.reloadData()
  }
  
  @IBAction
  func scanAction(sender:AnyObject?)
  {
    manager?.scanForPerformanceMonitors()
  }
  
  //
  func managerStateDidUpdate() {
    scanButton.enabled = manager?.isReady ?? false
  }
  
  func performanceMonitorStateDidUpdate(performanceMonitor:PerformanceMonitor) {
    if performanceMonitor.isConnected {
      performanceMonitor.enableDeviceInformationService()
      performanceMonitor.enableControlService()
      performanceMonitor.enableRowingService()
    }
  }
}

// MARK: BluetoothManagerDelegate
extension ViewController: BluetoothManagerDelegate {
  func didLoadPerformanceMonitors(bluetoothManager: BluetoothManager, performanceMonitors: Array<PerformanceMonitor>) {
    self.performanceMonitors = performanceMonitors
    tableView.reloadData()
  }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return performanceMonitors.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("CBPeripheral") {
      let pm:PerformanceMonitor = performanceMonitors[indexPath.row]
      
      cell.textLabel?.text = pm.peripheralName
      cell.detailTextLabel?.text = pm.peripheralIdentifier
      
      return cell
    } else {
      return UITableViewCell()
    }
  }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    // We've found a PM to connect to, stop scanning to save power
    manager?.stopScanningForPerformanceMonitors()
    
    // Attempt to connect to the PM
    let pm:PerformanceMonitor = performanceMonitors[indexPath.row]
    manager?.connectPerformanceMonitor(pm)
  }
}

