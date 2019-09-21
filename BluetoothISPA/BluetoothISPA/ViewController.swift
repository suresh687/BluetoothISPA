//
//  ViewController.swift
//  BluetoothISPA
//
//  Created by Suresh on 9/19/19.
//  Copyright © 2019 Priya. All rights reserved.
//

import UIKit
import CoreBluetooth
let BLE_Service_CBUUID = CBUUID(string: "0x2A00")
class ViewController: UITableViewController {

    var centralManager: CBCentralManager!
    var mobileperipheral: CBPeripheral!
     var items = [CBPeripheral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        //centralManager.scanForPeripherals(withServices: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let itemObject = items[indexPath.row]
        //cell.IDLabel.text = itemObject.name
        //cell.NameLabel.text = itemObject.description
        //cell.DescriptionLabel.text = (itemObject.identifier as! String)
        //indextoEdit = indexPath.row
        
        // Configure the cell...
        
        return cell
    }

}
extension ViewController:CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state{
            
        case .unknown:
            print("unknown")
        case .resetting:
            print("reset")
        case .unsupported:
            print("unsupp")
        case .unauthorized:
            print("hi")
        case .poweredOff:
            print("oFF")
        case .poweredOn:
            print("on")
            self.centralManager.scanForPeripherals(withServices: [BLE_Service_CBUUID])        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("hi")
        print(peripheral)
        items.append(peripheral)
        mobileperipheral = peripheral
        mobileperipheral.delegate = self
       // centralManager.stopScan()
        //centralManager.connect(mobileperipheral)
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("connected")
        print(peripheral)
        peripheral.discoverServices(nil)
    }
    
    
}
extension ViewController:CBPeripheralDelegate{
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("service")
        guard let services = peripheral.services else { return }
        for service in services{
            print(service)
        }
        print("end")
    }
}
