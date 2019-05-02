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

    @IBOutlet var search: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var carsArray : [Car] = []

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let newValue = carsArray[indexPath.row]
        cell.configureCell(car: newValue)
        
            return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        print(carsArray.count)

        
        JSON.shared.fetch { (carValues) in
            Car.self
            DispatchQueue.main.async {
                let newData = self.carsArray
                self.carsArray = carValues
                    
                print(carValues)
                self.tableView.reloadData()
            }
    }

}
}

