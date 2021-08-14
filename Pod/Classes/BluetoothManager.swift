//
//  BluetoothManager.swift
//  Pods
//
//  Created by Jesse Curry on 9/29/15.
//
//

import CoreBluetooth

public final class BluetoothManager
{
    public static let sharedInstance = BluetoothManager()
    
    public static func scanForPerformanceMonitors() {
        sharedInstance.scanForPerformanceMonitors()
    }
    
    public static func stopScanningForPerformanceMonitors() {
        sharedInstance.stopScanningForPerformanceMonitors()
    }
    
    public static func connectPerformanceMonitor(performanceMonitor:PerformanceMonitor,
                                                 exclusive:Bool) {
        sharedInstance.connectPerformanceMonitor(performanceMonitor: performanceMonitor, exclusive: exclusive)
    }
    
    public static func connectPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
        sharedInstance.connectPerformanceMonitor(performanceMonitor: performanceMonitor)
    }
    
    public static func disconnectPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
        sharedInstance.disconnectPerformanceMonitor(performanceMonitor: performanceMonitor)
    }
    
    public static var isReady:Subject<Bool> {
        get {
            return sharedInstance.isReady
        }
    }
    
    public static var performanceMonitors:Subject<Array<PerformanceMonitor>> {
        get {
            return sharedInstance.performanceMonitors
        }
    }
    
    private let isReady = Subject<Bool>(value: false)
    private let performanceMonitors = Subject<Array<PerformanceMonitor>>(value: Array<PerformanceMonitor>())
    
    // MARK: -
    private var centralManager:CBCentralManager
    private var centralManagerDelegate:CentralManagerDelegate
    private let centralManagerQueue = DispatchQueue(label: "com.boutfitness.concept2.bluetooth.central", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    
    // MARK: Initialization
    init() {
        centralManagerDelegate = CentralManagerDelegate()
        centralManager = CBCentralManager(delegate: centralManagerDelegate,
                                          queue: centralManagerQueue)
        
        self.isReady.value = (centralManager.state == .poweredOn)
        
        //
        NotificationCenter.default.addObserver(
            forName: PerformanceMonitorStoreDidAddItemNotification,
            object: PerformanceMonitorStore.sharedInstance,
            queue: nil) { [weak self] (notification) -> Void in
            if let weakSelf = self {
                DispatchQueue.main.async {
                    weakSelf.performanceMonitors.value = Array(PerformanceMonitorStore.sharedInstance.performanceMonitors)
                }
            }
        }
    }
    
    func scanForPerformanceMonitors() {
        centralManager.scanForPeripherals(withServices: [Service.deviceDiscovery.uuid],
                                          options: nil)
    }
    
    func stopScanningForPerformanceMonitors() {
        centralManager.stopScan()
    }
    
    func connectPerformanceMonitor(performanceMonitor:PerformanceMonitor, exclusive:Bool) {
        // TODO: use the PerformanceMonitor abstraction instead of peripherals
        if exclusive == true {
            
            centralManager.retrieveConnectedPeripherals(withServices: [Service.deviceDiscovery.uuid])
                .forEach { (peripheral) -> () in
                    if peripheral.state == .connected {
                        if peripheral != performanceMonitor.peripheral {
                            centralManager.cancelPeripheralConnection(peripheral)
                        }
                    }
                }
        }
        centralManager.connect(performanceMonitor.peripheral, options: nil)
    }
    
    func connectPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
        self.connectPerformanceMonitor(performanceMonitor: performanceMonitor, exclusive: true)
    }
    
    func disconnectPerformanceMonitor(performanceMonitor:PerformanceMonitor) {
        centralManager.cancelPeripheralConnection(performanceMonitor.peripheral)
    }
}
