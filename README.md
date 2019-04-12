# Swift programming language fundamentals assignment

## Tasks

- Use following method of `Workplace` instance and pass in `count` parameter between 5 - 15;

```swift
setEmptySeat(count: Int)
```

- Use following method of `Workplace` instance and pass in `employeeCount` parameter which is lower than number passed as `count` parameter in previous step;

```swift
employeesInOffice(employeeCount: Int)
```

- Write method named `isSeatAvailable` that takes in parameter named `seatIndex` of type `Int` and outputs boolean value indicated wether seat is available. Method should check if seat at given index is free or not. Return values `true` is available, `false` is occupied;

- Write method named `occupyEmptySeat` that takes in parameter named `index` of type `Int` and parameter named `employee` of type `String` with default value of 👩🏻‍💼. Method should use previously written method `isSeatAvailable` to find empty seat and set value to `employee` if seat's available, otherwise log message **"`employee` tried to take seat number `index`, unfortunatelly that seat was occupied by `oldEmployee`."**;

- Write a method named `workIsLeftBy` that takes in a parameter named `employee` of type `String`. Method should iterate through currently present workers, and all employees that match `employee` should leave workplace making seats available. If there are no employees that match `employee` output a message **"`employee` seems to be out-of-office."**.

## NB!
- New memory for available seats should not be allocated. Thus, at all times `seats` count should equal the one passed as parameter to `setEmptySeat` method;
- The number of employees at workplace should be less than number of available seats.

# Documentation of `Workplace`

```swift
// Array representing seats at workplace. Seat can be empty - nil, set can be taken - emoji.
// Whenever an array values change verbose representation printed.
public var seats: [String?]
```

```swift
// Function will set seats to given amount, all seats are empty initially.
// count: should be between 5 and 15, otherwise error will be printed.
public func setEmptySeat(count: Int)
```

```swift
// Function will occupy seats in no particular order.
// employeeCount: should be less or equal to seat count at workplace, otherwise error will be printed.
public func employeesInOffice(employeeCount: Int)
```
