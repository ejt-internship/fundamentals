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
    
    
    @IBOutlet var priceSliderOutlet: UISlider!
    @IBOutlet var priceLabel: UILabel!
    @IBAction func priceSlider(_ sender: UISlider) {
        self.priceLabel.text = "\(Int(priceSliderOutlet.minimumValue))"
        self.priceLabel.text = "\(Int(sender.value.self)) €"
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
                    print("minYear is: \(lowestYear)")
                }
                
                if let highestYear = carYearsWithOutDublicates.max() {
                    self.yearSlider.maximumValue = Float(highestYear)
                    print ("maxYear is:  \(highestYear)")
                    
                }
                
                let carPrice = carValues.map{$0.price}
                let carPriceWithOutDuplicate = carPrice.removingDuplicates()
                
                if let lowestPrice = carPriceWithOutDuplicate.min() {
                    print ("minPrice is:  \(lowestPrice)")
                    self.priceSliderOutlet.minimumValue = Float(lowestPrice)
                    self.priceLabel.text = "\(lowestPrice) €"
                }
                if let highestPrice = carPriceWithOutDuplicate.max() {
                    self.priceSliderOutlet.maximumValue = Float(highestPrice)
                    print("maxPrice is:  \(highestPrice)")
                }
            }
        }
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        searching = true
        let ongoingCars = searching ? searchCar : carsArray
        
        
        var results = Cars()
        var results2 = results
        var results3 = results2
        var results4 = results3
        var results5 = results4
        
        if !bodyCheckboxes.isEmpty {
            for checkbox in bodyCheckboxes {
                if checkbox.isChecked {
                    let filteredByBody = ongoingCars.filter({ (car) -> Bool in
                        return car.body == carBodyTypes[checkbox.tag]
                        
                    })
                    
                    results.append(contentsOf: filteredByBody)
                    print(filteredByBody)
                    results = filteredByBody
                    
                }
            }
        } else {
            results = ongoingCars
        }
        
        
        
        if !fuelTypeCheckBoxes.isEmpty {
            for checkBox in fuelTypeCheckBoxes {
                if checkBox.isChecked {
                    let filteredByFuelType = results.filter({ (car) -> Bool in
                        return car.fuelType == carFuelTypes[checkBox.tag]
                    })
                    
                    results2.append(contentsOf: filteredByFuelType)
                    print(filteredByFuelType)
                    
                }
            }
        } else {
            results2 = ongoingCars
        }
        
        if transmissionLabel.text == "automatic" {
            let filteredByTransmission = results2.filter({ (car) -> Bool in
                return car.transmission == .automatic
            })
            
            results3.append(contentsOf: filteredByTransmission)
            print(filteredByTransmission)
            
        } else {
            let filteredByTransmission = results2.filter({ (car) -> Bool in
                return car.transmission == .manual
            })
            
            results3.append(contentsOf: filteredByTransmission)
            print(filteredByTransmission)
            
        }

//        if let yearSliderValue = yearLabel.text {
//            print("this is current year label text: \(yearSliderValue)")
//            if let yearSliderFilter = Int(yearSliderValue) {
//                let carYearFilteredElements = yearSliderFilter...Int(Float(yearSlider.maximumValue))
//                if ongoingCars ~= carYearFilteredElements {
//                    let filteredByYear = results3.filter({ (car) -> Bool in
//                        return car.year == car.year
//                    })
//                    //            //TODO: safe-unwrap, uztaisˆt kopu, no izv´l´ta lidz maksimalas, parbaudit vai mashinas gads pieder kopai
//                    //            results.append(contentsOf: filteredByYear)
//                    //            print("yearFilter result is: \(filteredByYear)")
//                    results4.append(contentsOf: filteredByYear)
//                }
//            }
//            
//            
//            
//    }
//        if let priceSliderValue = priceLabel.text {
//            print("this is current price label text: \(priceSliderValue)")
//            if let priceSliderFilter = Int(priceSliderValue) {
//                let carPriceFilteredElements = priceSliderFilter...Int(Float(priceSliderOutlet.maximumValue))
//                if carsArray.capacity ~= carPriceFilteredElements {
//                    let filteredByPrice = results3.filter({ (car) -> Bool in
//                        return car.year == car.year
//                    })
//                    results5.append(contentsOf: filteredByPrice)
//}
//}
//            
//            
//        }
        
        print(results3.count)
        print(results2.count)
        print(results.count)
        searchCar = results3
        tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        searchCar = carsArray.filter({ (car) -> Bool in
            return (car.make.contains(searchText)) || (car.model.contains(searchText))
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


