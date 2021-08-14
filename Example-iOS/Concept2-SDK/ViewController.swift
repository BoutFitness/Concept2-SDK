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
    var isReadyDisposable:Disposable?
    var performanceMonitorsDisposable:Disposable?

    @IBOutlet var scanButton:UIButton!
    @IBOutlet var tableView:UITableView!

    //
    var performanceMonitors = Array<PerformanceMonitor>()

    // MARK: UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            forName: PerformanceMonitor.DidUpdateStateNotification,
            object:  nil,
            queue: nil) { (notification) -> Void in
            if let pm = notification.object as? PerformanceMonitor {

                DispatchQueue.main.async {
                    self.performanceMonitorStateDidUpdate(performanceMonitor: pm)
                }
            }
        }
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        isReadyDisposable = BluetoothManager.isReady.attach {
            [weak self] (isReady:Bool) -> Void in
            if let weakSelf = self {
                DispatchQueue.main.async {
                    weakSelf.updateUI()
                }
            }
        }

        performanceMonitorsDisposable = BluetoothManager.performanceMonitors.attach {
            [weak self] (performanceMonitors) -> Void in
            if let weakSelf = self {
                weakSelf.performanceMonitors = performanceMonitors

                DispatchQueue.main.async {
                    weakSelf.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        isReadyDisposable?.dispose()
        isReadyDisposable = nil

        performanceMonitorsDisposable?.dispose()
        performanceMonitorsDisposable = nil

        super.viewDidDisappear(animated)
    }

    @IBAction
    func scanAction(sender:AnyObject?)
    {
        BluetoothManager.scanForPerformanceMonitors()
    }

    func updateUI() {
        scanButton.isEnabled = BluetoothManager.isReady.value
    }


    func performanceMonitorStateDidUpdate(performanceMonitor:PerformanceMonitor) {
        print("PerformanceMonitorStateDidUpdate: \(performanceMonitor.peripheralName)")

        if let index = performanceMonitors.firstIndex(of: performanceMonitor) {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)],
                                 with: .automatic)
        }

        if performanceMonitor.isConnected {
            print("\tConnected - Enabling services")
            self.performSegue(withIdentifier: "PresentPerformanceMonitor", sender: performanceMonitor)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentPerformanceMonitor" {
            if let pm = sender as? PerformanceMonitor {
                if let vc = segue.destination as? PerformanceMonitorViewController {
                    vc.performanceMonitor = pm
                }
            }
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return performanceMonitors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CBPeripheral") {
            let pm:PerformanceMonitor = performanceMonitors[indexPath.row]

            cell.textLabel?.text = pm.peripheralName
            cell.detailTextLabel?.text = pm.peripheralIdentifier
            cell.accessoryType = pm.isConnected ? .checkmark : .none

            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // We've found a PM to connect to, stop scanning to save power
        BluetoothManager.stopScanningForPerformanceMonitors()

        // Attempt to connect to the PM
        let pm:PerformanceMonitor = performanceMonitors[indexPath.row]
        BluetoothManager.connectPerformanceMonitor(performanceMonitor: pm)
    }
}

