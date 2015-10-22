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
  
  var scanner:BluetoothManager?
  var peripherals = Array<CBPeripheral>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.reloadData()
  }
  
  @IBAction func scanAction(sender:AnyObject?)
  {
    scanner = Concept2_SDK.BluetoothManager(withDelegate: self)
    scanner?.scanForPeripherals()
  }
  
}

// MARK: BluetoothManagerDelegate
extension ViewController: BluetoothManagerDelegate {
  func didLoadPeripherals(bluetoothScanner: BluetoothManager, peripherals: Array<CBPeripheral>) {
    self.peripherals = peripherals
    tableView.reloadData()
  }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return peripherals.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("CBPeripheral") {
      let peripheral:CBPeripheral = peripherals[indexPath.row]
      
      cell.textLabel?.text = peripheral.name
      cell.detailTextLabel?.text = peripheral.identifier.UUIDString
      
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
    
    let peripheral:CBPeripheral = peripherals[indexPath.row]
    scanner?.connectPeripheral(peripheral)
  }
}

