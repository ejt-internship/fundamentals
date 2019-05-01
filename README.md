# Swift programming language fundamentals assignment

## Recources
- [SFoundation](https://trello-attachments.s3.amazonaws.com/5cacdd2a6b0bdc3698b3b195/5cc8afe2e2cff90b3a73deb4/2f6907d42a5a963443c87d441da487bb/library.zip) library.

## Tasks
- Create new project;
- Add `SFoundation` library;
- Fetch `Car` objects and display those in `TableView` (be creative with design and use as much properties as possible);
- Add ability to search for results with specific `make` and `model`;
- Add ability to filter results displayed in `TableView`:
    - By `body` using checkboxes (should be multiple choice);
    - By `transmission` using [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch);
    - By `year` using [`UISlider`](https://developer.apple.com/documentation/uikit/uislider);
    - By `fuelType` using checkboxes (should be multiple choice);
    - By `price` using [`UISlider`](https://developer.apple.com/documentation/uikit/uislider).
- (Optional) think of other improvements (functional and/or user-experience wise).

# Documentation of `SFoundation`

To use library add it to project as **Embedded Binary**. And import it where applicable `import SFoundation`.

It consists of `Car` data object

```swift
struct Car {

    /// Manufacturer or brand
    let make: String

    /// Model
    let model: String

    /// Body
    /// Possible values: `sedan`, `hatchback`, `coupe`, `cabrio`, `wagon`, `crossover`, `minivan`
    let body: Body

    /// Transmission type
    /// Possible values: `manual`, `automatic`
    let transmission: Transmission

    /// Manufatured year
    let year: Int

    /// Fuel type
    /// Possible values: `gasoline`, `diesel`, `electric`, `hydrogen`, `solar`, `vegetableOil`
    let fuelType: FuelType

    /// Fuel consumption (l/100km)
    let fuelConsumption: Double

    /// Seconds it takes to accelerate from 0 - 100 km/h
    let acceleration: Double

    /// Engine horsepower
    let horsepower: Int

    /// Estimated value in euros (€)
    let price: Int
}
```

And `JSON` class

```swift
class JSON {

    /// Singleton of JSON object
    static var shared = JSON()

    /// Simulates `API` call and returns data via `completionHandler`
    /// Executes on background thread with 5 second duration.
    /// - Parameter completionHandler: Between 80 and 120 of randomly generated `Car` objects
    public func fetch(completionHandler: @escaping (Cars) -> Void)
}
```
