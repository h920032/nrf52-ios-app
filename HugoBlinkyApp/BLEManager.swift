import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject {
    private var centralManager: CBCentralManager!
    private var ledCharacteristic: CBCharacteristic?

    @Published var isConnected = false
    @Published var ledOn = false

    private let deviceName = "Hugo_Blinky"
    private let ledServiceUUID = CBUUID(string: "FFE0")
    private let ledCharacteristicUUID = CBUUID(string: "FFE1")

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }

    func toggleLED() {
        guard let characteristic = ledCharacteristic else { return }
        ledOn.toggle()
        let value: UInt8 = ledOn ? 1 : 0
        let data = Data([value])
        centralManager.writeValue(data, for: characteristic, type: .withoutResponse)
    }
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name == deviceName {
            central.stopScan()
            peripheral.delegate = self
            central.connect(peripheral, options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnected = true
        peripheral.discoverServices([ledServiceUUID])
    }
}

extension BLEManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services where service.uuid == ledServiceUUID {
            peripheral.discoverCharacteristics([ledCharacteristicUUID], for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics where characteristic.uuid == ledCharacteristicUUID {
            ledCharacteristic = characteristic
        }
    }
}
