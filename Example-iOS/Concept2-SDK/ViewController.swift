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
  @IBOutlet
  var tableView:UITableView!
  
  var manager:BluetoothManager?
  var performanceMonitors = Array<PerformanceMonitor>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    manager = Concept2_SDK.BluetoothManager(withDelegate: self)
    tableView.reloadData()
  }
  
  @IBAction func scanAction(sender:AnyObject?)
  {
    manager?.scanForPerformanceMonitors()
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
    
    let pm:PerformanceMonitor = performanceMonitors[indexPath.row]
    manager?.connectPerformanceMonitor(pm)
  }
}

