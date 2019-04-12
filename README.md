# Swift programming language fundamentals assignment

## Tasks

- Use following method and pass in `emptySeatCount` parameter between 5 - 15;

```swift
setEmptySeats(emptySeatCount: Int)
```

- Use following method and pass in `amoutOfPeople` parameter which is lower than number passed as `emptySeatCount` parameter;

```swift
peopleComeToWork(amoutOfPeople: Int)
```

- Write method named `isSeatAvailable` that takes in parameter named `seatIndex` of type `Int` and outputs boolean value indicated wether seat is available. Method should check if seat at given index is free or not. Return values `true` is available, `false` is occupied;

- Write method named `occupyEmptySeat` that takes in parameter named `seatIndex` of type `Int` and parameter named `person` of type `String` with default value of 👩🏻‍💼. Method should use previously written method `isSeatAvailable` to find empty seat and set value `person` to it if it is available, otherwise log message **"`person` tried to take seat number `seatIndex`, unfortunatelly that seat was occupied by `currentPersonSeating`."**;

- Write a method named `workIsLeftBy` that takes in a parameter named `person` of type `String`. Method should iterate through currently present workers, and all people that match `person` should leave leaving seats empty. If there are no people that match `person` output a message **"Oh-oh! `person` seems to be working from home today."**.

## NB!
- Previously written code should not be edited;
- New memory for available seats should not be allocated. Thus, at all times `availableSeatsAtWork` count should equal the one passed as parameter to `setEmptySeats` method;
- The number of people at workplace should be less than number of available seats.
