import Foundation

private let workplace = Workplace()

workplace.setEmptySeat(count: 7)
workplace.employeesInOffice(employeeCount: 5)
workplace.seats

public func isSeatAvailable(seatIndex: Int) -> Bool {
    // if index of seat [] != nil
    
    var seatAvailabilityCheck = false
    for seat in workplace.seats {
        if seatIndex >= 0 && seatIndex <= workplace.seats.count {
            if seat == nil {
            print("the seat number \(seatIndex) is free")
            seatAvailabilityCheck = true
            break
        } else if seat != nil {
            print("the seat number \(seatIndex) is occupied")
            seatAvailabilityCheck = false
            break
        }
        } else {
            print ("oh no! something went wrong! seat index must be between 0 and seat number count!")
            break
        }
    }
    return seatAvailabilityCheck
}

public func occupyEmptySeat(index: Int, employee: String = "👩🏻‍💼") {
    
    var checkIfSeatIsAvailable = isSeatAvailable(seatIndex: index)
    for seat in workplace.seats {
        if index >= 0 && index <= workplace.seats.count {
            if checkIfSeatIsAvailable == true {
                print ("\(employee) got new workplace number \(index)")
//                seat?.append(employee)
                break
            } else {
                print("\(employee) tried to take seat number \(index), unfortunately that seat was occupied by \(seat)")
                break
            }
        }
    }
 // find and set up value to employee
    // if seat == nil {employees new place = index}
    // var oldemployee
    //else {
    //print("\(employee) tried to take seat number \(index), unfortunatelly that seat was occupied by \(oldEmployee).")
}

public func workIsLeftBy(employee: String) {
    //iterate through currently present workers
    // if employee == nil {"employee seems to be out-of-office."}
    for seat in workplace.seats {
        if seat == employee {
            print ("\(seat) should leave workplace")
//            seat?.remove(at: String.Index)
            break
        } else {
            print ("\(employee) seems to be out-of-office.")
            break
        }
    }
}
workplace.seats
isSeatAvailable(seatIndex: 0)
occupyEmptySeat(index: 0, employee: "👩🏻‍💼")
workIsLeftBy(employee: "👩🏼‍💻")



