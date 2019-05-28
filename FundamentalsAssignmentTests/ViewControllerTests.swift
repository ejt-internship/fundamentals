//
//  ViewControllerTests.swift
//  ViewControllerTests
//
//  Created by e.vanags on 14/05/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import XCTest
import SFundamentals

@testable import FundamentalsAssignment

class ViewControllerTests: XCTestCase {

    private var viewController: ViewController!
    private lazy var sender = UIButton(type: .system)

    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
            return
        }

        viewController.loadView()

        self.viewController = viewController
    }

    override func tearDown() {
        viewController = nil
    }

    func testCarSingleBodyCheckboxFilter() {
        let allCars = [
            Car(identifier: "1", body: .cabrio),
            Car(identifier: "2", body: .cabrio),
            Car(identifier: "3", body: .hatchback),
            Car(identifier: "4", body: .cabrio)
        ]

        let expectedCars = [
            Car(identifier: "1", body: .cabrio),
            Car(identifier: "2", body: .cabrio),
            Car(identifier: "4", body: .cabrio)
        ]

        let success = expectation(description: "Filters out cars that not have selected checkbox body type.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            viewController.yearSlider.minimumValue = 0
            viewController.yearSlider.value = 0

            viewController.priceSliderOutlet.minimumValue = 0
            viewController.priceSliderOutlet.maximumValue = 179993
            viewController.priceSliderOutlet.value = 179993

            let cabrioBodyCheckbox = viewController.bodyCheckboxes.first { $0.tag == 3 }
            cabrioBodyCheckbox?.isChecked = true

            viewController.searchButton(self.sender)

            XCTAssert(viewController.searchCar == expectedCars, "Filtered result did not match expectation.")
            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCarMultipleBodyCheckboxFilter() {
        let allCars = [
            Car(identifier: "1", body: .cabrio),
            Car(identifier: "2", body: .cabrio),
            Car(identifier: "3", body: .hatchback),
            Car(identifier: "4", body: .hatchback),
            Car(identifier: "5", body: .cabrio),
            Car(identifier: "6", body: .hatchback),
            Car(identifier: "7", body: .minivan),
            Car(identifier: "8", body: .cabrio),
            Car(identifier: "9", body: .hatchback)
        ]

        let expectedCars = [
            Car(identifier: "3", body: .hatchback),
            Car(identifier: "4", body: .hatchback),
            Car(identifier: "6", body: .hatchback),
            Car(identifier: "9", body: .hatchback),
            Car(identifier: "7", body: .minivan),
        ]

        let success = expectation(description: "Filters out cars that not have selected checkbox body type.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            viewController.yearSlider.minimumValue = 0
            viewController.yearSlider.value = 0

            viewController.priceSliderOutlet.minimumValue = 0
            viewController.priceSliderOutlet.maximumValue = 179993
            viewController.priceSliderOutlet.value = 179993

            let hatchbackBodyCheckbox = viewController.bodyCheckboxes.first { $0.tag == 1 }
            hatchbackBodyCheckbox?.isChecked = true

            let minivanBodyCheckbox = viewController.bodyCheckboxes.first { $0.tag == 6 }
            minivanBodyCheckbox?.isChecked = true

            viewController.searchButton(self.sender)

            XCTAssert(viewController.searchCar == expectedCars, "Filtered result did not match expectation.")
            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCarFuelCheckboxFilter() {
        let allCars = [
            Car(identifier: "1", fuelType: .electric),
            Car(identifier: "2", fuelType: .vegetableOil),
            Car(identifier: "3", fuelType: .electric),
            Car(identifier: "4", fuelType: .hydrogen)
        ]

        let expectedCars = [
            Car(identifier: "1", fuelType: .electric),
            Car(identifier: "3", fuelType: .electric)
        ]

        let success = expectation(description: "Filters out cars that not have selected checkbox fuel type.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            viewController.yearSlider.minimumValue = 0
            viewController.yearSlider.value = 0

            viewController.priceSliderOutlet.minimumValue = 0
            viewController.priceSliderOutlet.maximumValue = 179993
            viewController.priceSliderOutlet.value = 179993

            let electricFuelCheckbox = viewController.fuelTypeCheckBoxes.first { $0.tag == 12 }
            electricFuelCheckbox?.isChecked = true

            viewController.searchButton(self.sender)

            XCTAssert(viewController.searchCar == expectedCars, "Filtered result did not match expectation.")
            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCarBodyAndFuelCheckboxFilter() {
        let allCars = [
            Car(identifier: "1", body: .cabrio, fuelType: .electric),
            Car(identifier: "2", body: .cabrio, fuelType: .vegetableOil),
            Car(identifier: "3", body: .hatchback, fuelType: .electric),
            Car(identifier: "4", body: .cabrio, fuelType: .hydrogen),
            Car(identifier: "5", body: .cabrio, fuelType: .electric)
        ]

        let expectedCars = [
            Car(identifier: "1", body: .cabrio, fuelType: .electric),
            Car(identifier: "5", body: .cabrio, fuelType: .electric)
        ]

        let success = expectation(description: "Filters out cars that not have selected checkbox body and fuel type.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            viewController.yearSlider.minimumValue = 0
            viewController.yearSlider.value = 0

            viewController.priceSliderOutlet.minimumValue = 0
            viewController.priceSliderOutlet.maximumValue = 179993
            viewController.priceSliderOutlet.value = 179993

            let cabrioBodyCheckbox = viewController.bodyCheckboxes.first { $0.tag == 3 }
            cabrioBodyCheckbox?.isChecked = true

            let electricFuelCheckbox = viewController.fuelTypeCheckBoxes.first { $0.tag == 12 }
            electricFuelCheckbox?.isChecked = true

            viewController.searchButton(self.sender)

            XCTAssert(viewController.searchCar == expectedCars, "Filtered result did not match expectation.")
            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testTransmissionFilter() {
        let allCars = [
            Car(identifier: "1", transmission: .manual),
            Car(identifier: "2", transmission: .manual),
            Car(identifier: "3", transmission: .automatic),
            Car(identifier: "4", transmission: .manual)
        ]

        let expectedCars = [
            Car(identifier: "1", transmission: .manual),
            Car(identifier: "2", transmission: .manual),
            Car(identifier: "4", transmission: .manual)
        ]

        let success = expectation(description: "Filters cars to have manual transmission.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            viewController.yearSlider.minimumValue = 0
            viewController.yearSlider.value = 0

            viewController.priceSliderOutlet.minimumValue = 0
            viewController.priceSliderOutlet.maximumValue = 179993
            viewController.priceSliderOutlet.value = 179993

            let transmissionSwitch = viewController.gearSwitch
            transmissionSwitch?.isOn = false

            viewController.searchButton(self.sender)

            XCTAssert(viewController.searchCar == expectedCars, "Filtered result did not match expectation.")
            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testCheckboxAndTramsmissionFilter() {
        let allCars = [
            Car(identifier: "1", body: .minivan, transmission: .manual, fuelType: .electric),
            Car(identifier: "2", body: .cabrio, transmission: .automatic, fuelType: .vegetableOil),
            Car(identifier: "3", body: .hatchback, transmission: .automatic, fuelType: .electric),
            Car(identifier: "4", body: .cabrio, transmission: .manual, fuelType: .hydrogen),
            Car(identifier: "5", body: .cabrio, transmission: .manual, fuelType: .electric),
            Car(identifier: "6", body: .hatchback, transmission: .automatic, fuelType: .electric),
            Car(identifier: "7", body: .cabrio, transmission: .automatic, fuelType: .hydrogen),
            Car(identifier: "8", body: .cabrio, transmission: .manual, fuelType: .electric)
        ]

        let expectedCars = [
            Car(identifier: "5", body: .cabrio, transmission: .manual, fuelType: .electric),
            Car(identifier: "8", body: .cabrio, transmission: .manual, fuelType: .electric)
        ]

        let success = expectation(description: "Filters out cars that not have selected checkbox body and fuel type and automatic transmission.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            viewController.yearSlider.minimumValue = 0
            viewController.yearSlider.value = 0

            viewController.priceSliderOutlet.minimumValue = 0
            viewController.priceSliderOutlet.maximumValue = 179993
            viewController.priceSliderOutlet.value = 179993

            let cabrioBodyCheckbox = viewController.bodyCheckboxes.first { $0.tag == 3 }
            cabrioBodyCheckbox?.isChecked = true

            let electricFuelCheckbox = viewController.fuelTypeCheckBoxes.first { $0.tag == 12 }
            electricFuelCheckbox?.isChecked = true

            let transmissionSwitch = viewController.gearSwitch
            transmissionSwitch?.isOn = false

            viewController.searchButton(self.sender)

            XCTAssert(viewController.searchCar == expectedCars, "Filtered result did not match expectation.")
            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testYearSliderFilter() {
        let minimumYear = 1900
        let maximumYear = 2002

        let allCars = [
            Car(identifier: "1", year: minimumYear),
            Car(identifier: "2", year: 1905),
            Car(identifier: "3", year: 2000),
            Car(identifier: "4", year: maximumYear),
            Car(identifier: "5", year: 1999),
            Car(identifier: "6", year: 1920),
            Car(identifier: "7", year: 1967),
            Car(identifier: "8", year: 1943),
            Car(identifier: "9", year: 1980)
        ]

        let expectedCars = [
            Car(identifier: "3", year: 2000),
            Car(identifier: "4", year: maximumYear),
            Car(identifier: "5", year: 1999),
            Car(identifier: "9", year: 1980)
        ]

        let success = expectation(description: "Filter cars to have range of selected years.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            viewController.yearSlider.minimumValue = Float(minimumYear)
            viewController.yearSlider.maximumValue = Float(maximumYear)
            viewController.yearSlider.value = 1980

            viewController.priceSliderOutlet.minimumValue = 0
            viewController.priceSliderOutlet.maximumValue = 179993
            viewController.priceSliderOutlet.value = 179993

            viewController.searchButton(self.sender)

            for (index, car) in viewController.searchCar.enumerated() {
                XCTAssert(car.isEqual(to: expectedCars[index]), "Filtered result item at index: \(index) did not match expectation.")
            }

            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testYearAndPriceSliderFilter() {
        let minimumYear = 1950
        let maximumYear = 2010

        let allCars = [
            Car(identifier: "1", year: 2000),
            Car(identifier: "2", year: 1955),
            Car(identifier: "3", year: minimumYear),
            Car(identifier: "4", year: maximumYear),
            Car(identifier: "5", year: 1999),
            Car(identifier: "6", year: 1978),
            Car(identifier: "7", year: 1967),
            Car(identifier: "8", year: 1980),
            Car(identifier: "9", year: 1993)
        ]

        let expectedCars = [
            Car(identifier: "1", year: 2000),
            Car(identifier: "4", year: maximumYear),
            Car(identifier: "5", year: 1999),
            Car(identifier: "9", year: 1993)
        ]

        let success = expectation(description: "Filter cars to have range of selected prices.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            viewController.yearSlider.minimumValue = Float(minimumYear)
            viewController.yearSlider.maximumValue = Float(maximumYear)
            viewController.yearSlider.value = 1980

            // Values from `SFundamentals` library based on expected year values and configuration:
            // Body - sedan,
            // Transmission - automatic,
            // Fuel type - gasoline.
            viewController.priceSliderOutlet.minimumValue = 7200
            viewController.priceSliderOutlet.maximumValue = 29999
            viewController.priceSliderOutlet.value = 28400

            let expectedCarPriceRange = 7200...28400

            viewController.searchButton(self.sender)

            for (index, car) in viewController.searchCar.enumerated() {
                XCTAssert(car.isEqual(to: expectedCars[index]), "Filtered result item at index: \(index) did not match year expectation.")
                XCTAssert(expectedCarPriceRange ~= car.price, "Filtered result item at index: \(index) did not match price expectation, expected: [\(expectedCarPriceRange.lowerBound)-\(expectedCarPriceRange.upperBound)], got: \(car.price).")
            }

            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testAllFilterCriteria() {
        let minimumYear = 1950
        let maximumYear = 2010

        let allCars = [
            Car(identifier: "1", body: .sedan, transmission: .manual, year: 2000, fuelType: .hydrogen),
            Car(identifier: "2", body: .cabrio, transmission: .manual, year: 1999, fuelType: .solar),
            Car(identifier: "3", body: .hatchback, transmission: .manual, year: 1955, fuelType: .diesel),
            Car(identifier: "4", body: .coupe, transmission: .manual, year: 1978, fuelType: .vegetableOil),
            Car(identifier: "5", body: .coupe, transmission: .automatic, year: maximumYear, fuelType: .solar),
            Car(identifier: "6", body: .wagon, transmission: .manual, year: 1978, fuelType: .diesel),
            Car(identifier: "7", body: .sedan, transmission: .manual, year: 1955, fuelType: .hydrogen),
            Car(identifier: "8", body: .sedan, transmission: .manual, year: 2001, fuelType: .hydrogen),
            Car(identifier: "9", body: .sedan, transmission: .manual, year: 1955, fuelType: .solar),
            Car(identifier: "10", body: .coupe, transmission: .manual, year: 1955, fuelType: .hydrogen),
            Car(identifier: "11", body: .wagon, transmission: .automatic, year: minimumYear, fuelType: .gasoline),
            Car(identifier: "12", body: .sedan, transmission: .manual, year: maximumYear, fuelType: .hydrogen),
            Car(identifier: "13", body: .sedan, transmission: .manual, year: maximumYear, fuelType: .solar),
            Car(identifier: "14", body: .crossover, transmission: .automatic, year: 1999, fuelType: .solar),
            Car(identifier: "15", body: .sedan, transmission: .manual, year: minimumYear, fuelType: .hydrogen),
            Car(identifier: "16", body: .crossover, transmission: .automatic, year: 1999, fuelType: .solar),
            Car(identifier: "17", body: .minivan, transmission: .manual, year: 2000, fuelType: .hydrogen),
            Car(identifier: "18", body: .wagon, transmission: .manual, year: 1978, fuelType: .diesel),
            Car(identifier: "19", body: .hatchback, transmission: .automatic, year: 1967, fuelType: .gasoline),
            Car(identifier: "20", body: .hatchback, transmission: .manual, year: 1955, fuelType: .diesel),
            Car(identifier: "21", body: .hatchback, transmission: .automatic, year: 1980, fuelType: .gasoline),
            Car(identifier: "22", body: .coupe, transmission: .manual, year: maximumYear, fuelType: .solar),
            Car(identifier: "23", body: .coupe, transmission: .automatic, year: 1980, fuelType: .solar),
            Car(identifier: "24", body: .sedan, transmission: .automatic, year: 2000, fuelType: .diesel),
            Car(identifier: "25", body: .coupe, transmission: .manual, year: 2000, fuelType: .solar),
            Car(identifier: "26", body: .coupe, transmission: .manual, year: 1980, fuelType: .solar),
            Car(identifier: "27", body: .coupe, transmission: .manual, year: 2001, fuelType: .solar),
            Car(identifier: "28", body: .coupe, transmission: .manual, year: 2001, fuelType: .electric),
        ]

        let expectedCars = [
            Car(identifier: "1", body: .sedan, transmission: .manual, year: 2000, fuelType: .hydrogen),
            Car(identifier: "8", body: .sedan, transmission: .manual, year: 2001, fuelType: .hydrogen),
            Car(identifier: "12", body: .sedan, transmission: .manual, year: maximumYear, fuelType: .hydrogen),
            Car(identifier: "13", body: .sedan, transmission: .manual, year: maximumYear, fuelType: .solar),
            Car(identifier: "22", body: .coupe, transmission: .manual, year: maximumYear, fuelType: .solar),
            Car(identifier: "25", body: .coupe, transmission: .manual, year: 2000, fuelType: .solar),
            Car(identifier: "27", body: .coupe, transmission: .manual, year: 2001, fuelType: .solar),
        ]

        let success = expectation(description: "Filter cars to have selected bodies, fuel types, transmission, range of years and prices.")

        viewController.waitForResult { viewController in
            viewController.carsArray = allCars

            let sedanBodyCheckbox = viewController.bodyCheckboxes.first { $0.tag == 0 }
            sedanBodyCheckbox?.isChecked = true

            let coupeBodyCheckbox = viewController.bodyCheckboxes.first { $0.tag == 2 }
            coupeBodyCheckbox?.isChecked = true

            let hydrogenFuelCheckbox = viewController.fuelTypeCheckBoxes.first { $0.tag == 13 }
            hydrogenFuelCheckbox?.isChecked = true

            let solarFuelCheckbox = viewController.fuelTypeCheckBoxes.first { $0.tag == 14 }
            solarFuelCheckbox?.isChecked = true

            let transmissionSwitch = viewController.gearSwitch
            transmissionSwitch?.isOn = false

            viewController.yearSlider.minimumValue = Float(minimumYear)
            viewController.yearSlider.maximumValue = Float(maximumYear)
            viewController.yearSlider.value = 2000

            // Values from `SFundamentals` library based on expected year values
            viewController.priceSliderOutlet.minimumValue = 5040
            viewController.priceSliderOutlet.maximumValue = 179993
            viewController.priceSliderOutlet.value = 50000

            let expectedCarPriceRange = 5040...50000

            viewController.searchButton(self.sender)

            XCTAssert(viewController.searchCar.count == expectedCars.count, "Expected result count did not match, expected: \(expectedCars.count), got: \(viewController.searchCar.count).")

            for (index, car) in viewController.searchCar.enumerated() {
                XCTAssert(car.isEqual(to: expectedCars[index]), "Filtered result item at index: \(index) did not match year expectation, expected: \(expectedCars[index].make), got: \(car.make).")
                XCTAssert(expectedCarPriceRange ~= car.price, "Filtered result item at index: \(index) did not match price expectation, expected: [\(expectedCarPriceRange.lowerBound)-\(expectedCarPriceRange.upperBound)], got: \(car.price).")
            }

            success.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }
}

fileprivate extension ViewController {
    func waitForResult(_ execute: @escaping (ViewController) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
            execute(self)
        }
    }
}

fileprivate extension Car {
    init(identifier make: String, model: String = String(), body: Body = .sedan, transmission: Transmission = .automatic, year: Int = 0, fuelType: FuelType = FuelType.gasoline) {
        self.init(make: make, model: model, body: body, transmission: transmission, year: year, fuelType: fuelType)
    }

    /// Compare two `Car` objects excluding variable values that are randomised (`fuelConsumption`, `acceleration`, `horsepower`, `price`).
    func isEqual(to car: Car) -> Bool {
        return make == car.make && model == car.model && body == car.body && transmission == car.transmission && year == car.year && fuelType == car.fuelType
    }
}
