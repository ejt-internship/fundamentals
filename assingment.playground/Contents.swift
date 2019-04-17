import Foundation

private let workplace = Workplace()

workplace.setEmptySeat(count: 9)
workplace.employeesInOffice(employeeCount: 2)

public func isSeatAvailable(_ seatIndex: Int) -> Bool {
    let seat = workplace.seats[seatIndex]
    if seat == nil {
        return true
    } else {
        return false
    }
}

public func occupyEmptySeat(index: Int, employee: String = "👩🏻‍💼") {
    if index >= 0 && index < workplace.seats.count {
        if isSeatAvailable(index) {
            workplace.seats[index] = employee
        } else {
            if let oldEmployee = workplace.seats[index] {
                print("\(employee) tried to take seat number \(index + 1), unfortunatelly that seat was occupied by \(oldEmployee).")
            }
        }
    } else {
        print ("Something went wrong! index must be between 0 and \(workplace.seats.count - 1)!")
    }
}

public func workIsLeftBy(employee: String) {
    if workplace.seats.contains(employee) {
        for index in 0 ... workplace.seats.count - 1 {
            let seat = workplace.seats[index]
            if seat == employee {
                workplace.seats[index] = nil
            }
        }
    } else {
        print("\(employee) seems to be out-of-office.")
    }
}

occupyEmptySeat(index: 8, employee: "👩🏻‍💼")
workIsLeftBy(employee: "👩🏼‍💻")
