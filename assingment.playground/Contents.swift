import Foundation

private let workplace = Workplace()

workplace.setEmptySeat(count: 11)
workplace.employeesInOffice(employeeCount: 5)
workplace.seats

public func isSeatAvailable(seatIndex: Int) -> Bool {
    // if index of seat [] != nil
    for seat in workplace.seats {
        if seatIndex >= 0 && seatIndex <= workplace.seats.count {
        if seat == nil {
            print("the seat number \(seatIndex) is free")
            return true
        } else if seat != nil {
            print("the seat number \(seatIndex) is occupied")
            return false
        }
        } else {
            print ("oh no! something went wrong! seat index must be between 0 and seat number count!")
            break
        }
    }
    return false
}

public func occupyEmptySeat(index: Int, employee: String = "👩🏻‍💼") {
 // find and set up value to employee
    // if seat == nil {employees new place = index}
    // var oldemployee
    //else {
    //print("\(employee) tried to take seat number \(index), unfortunatelly that seat was occupied by \(oldEmployee).")
}

public func workIsLeftBy(employee: String) {
    //iterate through currently present workers
    // if employee == nil {"employee seems to be out-of-office."}
}
workplace.seats
isSeatAvailable(seatIndex: 11)
