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
    @IBOutlet var yearSlider: UISlider!
    
    @IBAction func didChangeYear(_ sender: UISlider) {
        self.yearLabel.text = "\(Int(yearSlider.minimumValue))"
        self.yearLabel.text = "\(Int(sender.value.self))"
    }
    
    
    @IBOutlet var priceLabel: UILabel!
    @IBAction func priceSlider(_ sender: UISlider) {
        
        self.priceLabel.text = "\(Int(sender.value.self)) €"
        return
    }
    
    @IBAction func switchTransmission(_ sender: UISwitch) {
        if (sender.isOn) {
            
            transmissionLabel.text = "automatic"
            let automatic = carsArray.filter {(car) -> Bool in
                return car.transmission == .automatic
                
            }
            searchByTransmission.append(Car.Transmission.automatic)
            print(carsArray)
        } else {
            transmissionLabel.text = "manual"
            let manual = carsArray.filter { (car) -> Bool in
                
                
                return car.transmission == .manual
            }
        }
        searchByTransmission.append(Car.Transmission.manual)
        print(carsArray)
    }
    
    @IBOutlet var transmissionLabel: UILabel!
    
    @IBOutlet var bodyCheckboxes: [CheckBox]!
    
    var carBodyTypes: [Int: Car.Body] = [0 : .sedan,
                                         1 : .hatchback,
                                         2 : .coupe,
                                         3 : .cabrio,
                                         4 : .wagon,
                                         5 : .crossover,
                                         6 : .minivan]
    
    
    @IBOutlet var fuelTypeCheckBoxes: [CheckBox]!
    
    var carFuelTypes: [Int: Car.FuelType] = [10 : .gasoline,
                                            11 : .diesel,
                                            12 : .electric,
                                            13 : .hydrogen,
                                            14 : .solar,
                                            15 : .vegetableOil]
    
    var carsArray : [Car] = []
    var searchCar = [Car]()
    var searching = false
    var searchByBody = [Car.Body]()
    var searchByTransmission = [Car.Transmission]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(yearLabel.text!)
        JSON.shared.fetch { (carValues) in
            DispatchQueue.main.async {
                self.carsArray = carValues
                self.searchCar = carValues
                //                print(carValues)
                self.tableView.reloadData()
                
                
                let carYears = carValues
                    .map { $0.year }
                
                let carYearsWithOutDublicates = carYears.removingDuplicates()
                print(carYearsWithOutDublicates)
                
                
                
                if let lowestYear = carYearsWithOutDublicates.min() {
                    print(lowestYear)
                    self.yearSlider.minimumValue = Float(lowestYear)
                    self.yearLabel.text = "\(lowestYear)"
                }
                
                if let highestYear = carYearsWithOutDublicates.max() {
                    self.yearSlider.maximumValue = Float(highestYear)
                    
                }
            }
        }
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        searching = true
        let ongoingCars = searching ? searchCar : carsArray
        
        
        var results = Cars()
        
        if !bodyCheckboxes.isEmpty {
            for checkbox in bodyCheckboxes {
                if checkbox.isChecked {
                    let filteredByBody = ongoingCars.filter({ (car) -> Bool in
                        return car.body == carBodyTypes[checkbox.tag]
                       
                    })
                    
                    results.append(contentsOf: filteredByBody)
                    print(filteredByBody)
                    results = filteredByBody
                    tableView.reloadData()

                }
            }
        } else {
            results = ongoingCars
        }
        searchCar = results
        tableView.reloadData()
        
        
        if !fuelTypeCheckBoxes.isEmpty {
            for checkBox in fuelTypeCheckBoxes {
                if checkBox.isChecked {
                    let filteredByFuelType = ongoingCars.filter({ (car) -> Bool in
                        return car.fuelType == carFuelTypes[checkBox.tag]
                    })
                    
                    results.append(contentsOf: filteredByFuelType)
                    print(filteredByFuelType)
                    searchCar = filteredByFuelType
                    tableView.reloadData()
                    
                }
            }
        } else {
            results = ongoingCars
                }
        searchCar = results
        tableView.reloadData()
            }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        searchCar = carsArray.filter({ (car) -> Bool in
            return (car.make.contains(searchText)) || (car.model.contains(searchText))
            //TODO: replace prefix (jāatrod arī otrā vārda sākums), check not by count
        })
        tableView.reloadData()
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}


