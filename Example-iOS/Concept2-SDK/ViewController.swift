//
//  ViewController.swift
//  Concept2-SDK
//
//  Created by jessecurry on 09/27/2015.
//  Copyright (c) 2015 jessecurry. All rights reserved.
//

import UIKit
import Concept2_SDK

class ViewController: UIViewController {
  @IBOutlet var scanButton:UIButton!
  @IBOutlet var tableView:UITableView!
  
  //
  var performanceMonitors = Array<PerformanceMonitor>()
  
  // MARK: UIViewController lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    BluetoothManager.sharedInstance.isReady.attach { [weak self] (isReady:Bool?) -> Void in
      if let weakSelf = self {
        weakSelf.updateUI()
      }
    }
    
    
    NSNotificationCenter.defaultCenter().addObserverForName(
      PerformanceMonitor.DidUpdateStateNotification,
      object:  nil,
      queue: nil) { (notification) -> Void in
        if let pm = notification.object as? PerformanceMonitor {
          dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.performanceMonitorStateDidUpdate(pm)
          })
        }
    }
    
    tableView.reloadData()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  @IBAction
  func scanAction(sender:AnyObject?)
  {
    BluetoothManager.scanForPerformanceMonitors()
  }
  
  func updateUI() {
    scanButton.enabled = BluetoothManager.sharedInstance.isReady.value ?? false
  }
  
  
  func performanceMonitorStateDidUpdate(performanceMonitor:PerformanceMonitor) {
    print("PerformanceMonitorStateDidUpdate: \(performanceMonitor.peripheralName)")
    
    if let index = performanceMonitors.indexOf(performanceMonitor) {
      tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)],
        withRowAnimation: .Automatic)
    }
    
    if performanceMonitor.isConnected {
      print("\tConnected - Enabling services")
      self.performSegueWithIdentifier("PresentPerformanceMonitor", sender: performanceMonitor)
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "PresentPerformanceMonitor" {
      if let pm = sender as? PerformanceMonitor {
        if let vc = segue.destinationViewController as? PerformanceMonitorViewController {
          vc.performanceMonitor = pm
        }
      }
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
      cell.accessoryType = pm.isConnected ? .Checkmark : .None
      
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
    BluetoothManager.stopScanningForPerformanceMonitors()
    
    // Attempt to connect to the PM
    let pm:PerformanceMonitor = performanceMonitors[indexPath.row]
    BluetoothManager.connectPerformanceMonitor(pm)
  }
}

