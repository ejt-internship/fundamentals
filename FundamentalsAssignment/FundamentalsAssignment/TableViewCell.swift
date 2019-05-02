//
//  TableViewCell.swift
//  FundamentalsAssignment
//
//  Created by egmars.janis.timma on 02/05/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import UIKit
import  SFundamentals

class TableViewCell: UITableViewCell {

    
    @IBOutlet var make: UILabel!
    @IBOutlet var model: UILabel!
    @IBOutlet var body: UILabel!
    @IBOutlet var transmission: UILabel!
    @IBOutlet var year: UILabel!
    @IBOutlet var fuelType: UILabel!
    @IBOutlet var fuelCompsumtion: UILabel!
    @IBOutlet var acceleration: UILabel!
    @IBOutlet var horsepower: UILabel!
    @IBOutlet var price: UILabel!
    
    
    func configureCell(car: Car) {
        self.make.text = "Brand: \(car.make)"
        self.model.text = "Model: \(car.model)"
        self.body.text = "Body: \(car.body)"
        self.transmission.text = "Transmission: \(car.transmission)"
        self.year.text = "Year: \(car.year)"
        self.fuelType.text = "Fuel Type: \(car.fuelType)"
        self.fuelCompsumtion.text = "Fuel consumption: \(car.fuelConsumption) (l/100km)"
        self.acceleration.text = "Acceleration: \(car.acceleration) Sec"
        self.horsepower.text = "Horsepower: \(car.horsepower)"
        self.price.text = "Price: \(car.price) $"
    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
