//
//  ViewController.swift
//  FundamentalsAssignment
//
//  Created by egmars.janis.timma on 02/05/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import UIKit
import SFundamentals

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var yearLabel: UILabel!
    @IBAction func yearSlider(_ sender: UISlider) {
        self.yearLabel.text = String(Int(sender.value.self))
        return
    }
    
    @IBOutlet var priceLabel: UILabel!
    @IBAction func priceSlider(_ sender: UISlider) {
        self.priceLabel.text = "\(Int(sender.value.self)) $"
        return
    }
    
    @IBAction func switchTransmission(_ sender: UISwitch) {
        if (sender.isOn) {
            transmissionLabel.text = "automatic"
        } else {
            transmissionLabel.text = "manual"
        }
    }
    @IBOutlet var transmissionLabel: UILabel!
    
    
    var carsArray : [Car] = []
    var searchCar = [Car]()
    var searching = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchCar.count
        }
        return carsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        if searching {
            let newValue = searchCar[indexPath.row]
            cell.configureCell(car: newValue)
            
        } else {
            let newValue = carsArray[indexPath.row]
            cell.configureCell(car: newValue)
        }
        return cell
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSON.shared.fetch { (carValues) in
            Car.self
            DispatchQueue.main.async {
                let newData = self.carsArray
                self.carsArray = carValues
                print(carValues)
                self.tableView.reloadData()
                self.tableView.dataSource = self
                self.setUpSearchBar()
                self.searchCar = self.carsArray
            }
        }
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        
        
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        searchCar = carsArray.filter({$0.make.prefix(searchText.count) == searchText})
        tableView.reloadData()
    }
}
