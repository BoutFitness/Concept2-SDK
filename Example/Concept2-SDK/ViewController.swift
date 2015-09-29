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
  let pm = Concept2_SDK.PerformanceMonitor()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func scanAction(sender:AnyObject?)
  {
    pm.scanForConnection()
  }
  
}

