//
//  PerformanceMonitorViewController.swift
//  Example-iOS
//
//  Created by Jesse Curry on 10/28/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import UIKit
import Concept2_SDK

class PerformanceMonitorViewController: UIViewController {
  var performanceMonitor:PerformanceMonitor?
  
  @IBOutlet var nameLabel:UILabel!
  @IBOutlet var strokesPerMinuteLabel:UILabel!
  @IBOutlet var distanceLabel:UILabel!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    registerForNotifications()
    updateUI()
  }
  
  override func viewDidDisappear(animated: Bool) {
    unregisterForNotifications()
    super.viewDidDisappear(animated)
  }
  
  @IBAction func dismissAction(sender:AnyObject?) {
    self.dismissViewControllerAnimated(true) { () -> Void in
    }
  }
  
  // MARK: View Updates
  private func updateUI() {
    nameLabel.text = performanceMonitor?.peripheralName ?? "Unknown"
    strokesPerMinuteLabel.text = "\(performanceMonitor?.strokeRate ?? 0)"
    distanceLabel.text = "\(performanceMonitor?.distance ?? 0)"
  }
  
  // MARK: Notifications
  private let notificationCenter = NSNotificationCenter.defaultCenter()
  private func registerForNotifications() {
    notificationCenter.addObserverForName(
      PerformanceMonitor.DidUpdateStateNotification,
      object:  performanceMonitor,
      queue: nil) { (notification) -> Void in
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          if let pm = self.performanceMonitor {
            if !pm.isConnected {
              self.dismissAction(nil)
            }
          }
        })
    }
    
    notificationCenter.addObserverForName(
      PerformanceMonitor.DidUpdateValueNotification,
      object:  performanceMonitor,
      queue: nil) { (notification) -> Void in
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.updateUI()
        })
    }
  }
  
  private func unregisterForNotifications() {
    notificationCenter.removeObserver(self,
      name: PerformanceMonitor.DidUpdateStateNotification, object: nil)
    notificationCenter.removeObserver(self,
      name: PerformanceMonitor.DidUpdateValueNotification, object: nil)
  }
}
