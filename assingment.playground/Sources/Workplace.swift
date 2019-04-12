import Foundation

public class Workplace {
    public init() {}

    public var seats = [String?]() {
        didSet {
            let seatsVerbose = seats.map { seat -> String in
                if let occupiedSeat = seat {
                    return occupiedSeat
                }

                return ""
            }

            print("Current seat explotation: \(seatsVerbose).")
        }
    }

    /// Set the amount of empty seats at workplace.
    ///
    /// - Parameter count: Number of empty seats to generate. Should be between 5-15.
    public func setEmptySeat(count: Int) {
        guard 5 ... 15 ~= count else {
            if count < 5 {
                print("Lowest valid seat count is 5, received \(count).")
            } else if count > 15 {
                print("Highest valid seat count is 15, received \(count).")
            }

            return
        }

        var tempSeats: [String?] = []

        for _ in 0 ..< count {
            tempSeats.append(nil)
        }

        seats = tempSeats
    }

    /// Generate number of people that will come to work and occupy available seat of their choosing.
    ///
    /// - Parameter amoutOfPeople: Amout of people that will come to work. Should not exceed number of available seats.
    public func employeesInOffice(employeeCount: Int) {
        let seatCount = seats.count

        guard employeeCount <= seatCount else {
            print("There were \(seatCount) available seats, and \(employeeCount) employees came to workplace. \(employeeCount - seatCount) employees are missing seats.")

            return
        }

        var seatIndexes = (0 ..< seatCount).map { $0 }

        for _ in 0 ..< employeeCount {
            let employee = person()

            if let index = seatIndexes.randomElement() {
                print("\(employee) came to work, took seat number \(index + 1).")
                seats[index] = employee

                let newSeatIndexes = seatIndexes.filter { $0 != index }
                seatIndexes = newSeatIndexes
            }
        }
    }

    private func person() -> String {
        return ["👨🏽‍💻", "👩🏼‍💻"].randomElement() ?? "👨🏻‍💼"
    }
}
