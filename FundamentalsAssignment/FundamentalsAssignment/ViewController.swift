//
//  ViewController.swift
//  FundamentalsAssignment
//
//  Created by egmars.janis.timma on 02/05/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import UIKit
import SFundamentals

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Car.init(make: "audi", model: "A4", body: .sedan, transmission: .automatic, year: 2019, fuelType: .diesel))
    }

}

