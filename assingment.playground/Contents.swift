import Foundation

var availableSeatsAtWork = [String?]() {
    didSet {
        let availableSeatsAtWorkVerbal = availableSeatsAtWork.map { availableSeat -> String in
            if let occupiedSeatWithPerson = availableSeat {
                return occupiedSeatWithPerson
            }

            return ""
        }

        print("Current seat explotation: \(availableSeatsAtWorkVerbal).\n")
    }
}

/// Set the amount of empty seats at workplace.
///
/// - Parameter count: Number of empty seats to generate. Should be between 5-15.
func setEmptySeats(emptySeatCount count: Int) {
    guard count >= 5 else {
        print("This is not a start-up, there should be at least 5 available seats not \(count)!")
        return
    }

    guard count <= 15 else {
        print("Ambitious, but this is not a \"Apple\" Inc., we don't have to budget for more than 15 seats!")
        return
    }

    var tempAvailableSeats: [String?] = []

    for _ in 0 ..< count {
        tempAvailableSeats.append(nil)
    }

    availableSeatsAtWork = tempAvailableSeats
}

/// Generate number of people that will come to work and occupy available seat of their choosing.
///
/// - Parameter amoutOfPeople: Amout of people that will come to work. Should not exceed number of available seats.
func peopleComeToWork(amoutOfPeople: Int) {
    let availableSeatCount = availableSeatsAtWork.count

    guard amoutOfPeople <= availableSeatCount else {
        let amoutWithoutSeat = amoutOfPeople - availableSeatCount
        print("Oh-oh! There were \(availableSeatCount) available seats, and \(amoutOfPeople) people came to work. \(amoutWithoutSeat) people will have to work from home.")
        return
    }

    var availableSeatIndexes = (0 ..< availableSeatCount).map { $0 }

    for _ in 0 ..< amoutOfPeople {
        let person = generateRandomPerson()

        if let index = availableSeatIndexes.randomElement() {
            print("\(person) came to work, took seat number \(index + 1).")
            availableSeatsAtWork[index] = person

            let availableSeatIndexesLeft = availableSeatIndexes.filter { $0 != index }
            availableSeatIndexes = availableSeatIndexesLeft
        }
    }
}

func generateRandomPerson() -> String {
    let availablePeople = ["👨🏽‍💻", "👩🏼‍💻"]
    let randomPerson = availablePeople.randomElement() ?? "👨🏻‍💼"

    return randomPerson
}

// TODO:
// - Use method `setEmptySeats` and pass in `emptySeatCount` parameter between 5-15.
//
// - Use method `peopleComeToWork` and pass in `amoutOfPeople` parameter which is lower than number passed as `emptySeatCount` parameter previously.
//
// - Write method named `isSeatAvailable` that takes in parameter named `seatIndex` of type `Int`
// and outputs boolean value indicated wether seat is available.
// Method should check if seat at given index is free or not.
// Return values `true` is available, `false` is occupied.
//
// - Write method named `occupyEmptySeat` that takes in parameter named `seatIndex` of type `Int`
// and parameter named `person` of type `String` with default value of "👩🏻‍💼".
// Method should use previously written method `isSeatAvailable` to find empty seat and set value `person` to it if it is available,
// otherwise log message "\(<#person#>) tried to take seat number \(<#seatIndex#>), unfortunatelly that seat was occupied by \(<#currentPersonSeating#>).".
//
// - Write a method named `workIsLeftBy` that takes in a parameter named `person` of type `String`
// Method should iterate through currently present workers, and all people that match `person` should leave leaving seats empty.
// If there are no people that match `person` output a message "Oh-oh! \(<#person#>) seems to be working from home today.".
//
// NB!
// - Previously written code should not be edited.
// - New memory for available seats should not be allocated.
// Thus, at all times `availableSeatsAtWork` count should equal the one passed as parameter to `setEmptySeats` method.
// - The number of people at workplace should be less than number of available seats.

setEmptySeats(emptySeatCount: <#count#>)
peopleComeToWork(amoutOfPeople: <#people#>)

