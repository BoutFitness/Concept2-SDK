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
  
  var nameDisposable:Disposable?
  @IBOutlet var nameLabel:UILabel!
  var strokesPerMinuteDisposable:Disposable?
  @IBOutlet var strokesPerMinuteLabel:UILabel!
  var distanceDisposable:Disposable?
  @IBOutlet var distanceLabel:UILabel!
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    attachObservers()
    updateUI()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    detachObservers()
  }
  
  @IBAction func dismissAction(sender:AnyObject?) {
    self.dismissViewControllerAnimated(true) { () -> Void in
    }
  }
  
  // MARK: View Updates
  private func updateUI() {
    nameLabel.text = performanceMonitor?.peripheralName ?? "Unknown"
  }
  
  // MARK: Notifications
  private func attachObservers() {
    detachObservers()
    
    strokesPerMinuteDisposable = performanceMonitor?.strokeRate.attach({
      [weak self] (strokeRate:C2StrokeRate) -> Void in
      if let weakSelf = self {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          weakSelf.strokesPerMinuteLabel.text = "\(strokeRate)"
        })
      }
    })
    
    distanceDisposable = performanceMonitor?.distance.attach({
      [weak self] (distance:C2Distance) -> Void in
      if let weakSelf = self {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          weakSelf.distanceLabel.text = "\(distance)"
        })
      }
    })
  }
  
  private func detachObservers() {
    nameDisposable?.dispose()
    strokesPerMinuteDisposable?.dispose()
    distanceDisposable?.dispose()
  }
}
