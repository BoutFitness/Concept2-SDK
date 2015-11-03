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
    
    performanceMonitor?.strokeRate.attach({ [weak self] (strokeRate:C2StrokeRate?) -> Void in
      if let weakSelf = self {
        guard strokeRate != nil else {
          weakSelf.strokesPerMinuteLabel.text = "0"
          return
        }
        weakSelf.strokesPerMinuteLabel.text = "\(strokeRate!.value)"
      }
    })
    
    performanceMonitor?.distance.attach({ [weak self] (distance:C2Distance?) -> Void in
      if let weakSelf = self {
        guard distance != nil else {
          weakSelf.distanceLabel.text = "0"
          return
        }
        weakSelf.distanceLabel.text = "\(distance!.value)"
      }
    })
  }
  
  private func detachObservers() {
    nameDisposable?.dispose()
    strokesPerMinuteDisposable?.dispose()
    distanceDisposable?.dispose()
  }
}
