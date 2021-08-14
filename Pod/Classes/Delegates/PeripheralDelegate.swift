//
//  PeripheralDelegate.swift
//  Pods
//
//  Created by Jesse Curry on 9/30/15.
//  Copyright © 2015 Bout Fitness, LLC. All rights reserved.
//

import CoreBluetooth

final class PeripheralDelegate: NSObject, CBPeripheralDelegate {
    weak var performanceMonitor:PerformanceMonitor?
    
    // MARK: Services
    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverServices error: Error?
    ) {
        
        print("[PerformanceMonitor]didDiscoverServices:")
        peripheral.services?.forEach({ (service:CBService) -> () in
            print("\t* \(service.description)")
            
            if let svc = Service(uuid: service.uuid) {
                peripheral.discoverCharacteristics(svc.characteristicUUIDs, for: service)
            }
        })
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverIncludedServicesFor service: CBService, error: Error?) {
        print("[PerformanceMonitor]didDiscoverIncludedServicesForService")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        print("[PerformanceMonitor]didModifyServices")
    }
    
    // MARK: Characteristics
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("[PerformanceMonitor]didDiscoverCharacteristicsForService")
        service.characteristics?.forEach({ (characteristic:CBCharacteristic) -> () in
            peripheral.setNotifyValue(true, for: characteristic)
        })
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        print("[PerformanceMonitor]didDiscoverDescriptorsForCharacteristic")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        print("[PerformanceMonitor]didUpdateValueForCharacteristic: \(characteristic)")
        if let characteristicService = characteristic.service,
           let svc = Service(uuid: characteristicService.uuid) {
            if let c = svc.characteristic(uuid: characteristic.uuid) {
                let cm = c.parse(data: characteristic.value)
                if let pm = performanceMonitor {
                    cm?.updatePerformanceMonitor(performanceMonitor: pm)
                }
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        
        print("[PerformanceMonitor]didUpdateValueForDescriptor")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor descriptor: CBDescriptor, error: Error?) {
        
        print("[PerformanceMonitor]didWriteValueForDescriptor")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
        print("[PerformanceMonitor]didWriteValueForCharacteristic")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
        print("[PerformanceMonitor]didUpdateNotificationStateForCharacteristic")
    }
    
    // MARK: Signal Strength
    func peripheralDidUpdateRSSI(_ peripheral: CBPeripheral, error: Error?) {
        
        print("[PerformanceMonitor]didUpdateRSSI")
    }
    
    // MARK: Name
    func peripheralDidUpdateName(_ peripheral: CBPeripheral) {
        
        print("[PerformanceMonitor]didUpdateName")
    }
}
