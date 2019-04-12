import Foundation

public class Workplace {
    public init() {}

    public var availableSeatsAtWork = [String?]() {
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
    public func setEmptySeats(emptySeatCount count: Int) {
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
    public func peopleComeToWork(amoutOfPeople: Int) {
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

    private func generateRandomPerson() -> String {
        let availablePeople = ["👨🏽‍💻", "👩🏼‍💻"]
        let randomPerson = availablePeople.randomElement() ?? "👨🏻‍💼"

        return randomPerson
    }
}
