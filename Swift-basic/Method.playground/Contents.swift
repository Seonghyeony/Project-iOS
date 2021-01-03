import UIKit

/**
 Method - Func과 기능은 같지만 Method는 class나 struct 안에서 동작.
 
 mutating
 */

struct Lecture {
    var title: String
    var maxStudents: Int = 10
    var numOfRegistered: Int = 0
    
    // 관련된 기능은 func말고 Method로.
    func remainSeats() -> Int {
        let remainSeats = lec.maxStudents - lec.numOfRegistered
        return remainSeats
    }
    
    // mutating: 이 메서드는 실행을 했을 때, 해당 Structure의 Stored Property를 변형시킨다. 그럴 때는 해당 키워드를 작성.
    mutating func register() {
        // 등록된 학생 수 증가시키기.
        numOfRegistered += 1
    }
    
    static let target: String = "Anybody want to learn something."
    
    // Type Method.
    static func 소속학원이름() -> String {
        return "패캠"
    }
}

var lec = Lecture(title: "iOS Basic")

//func remainSeats(of lec: Lecture) -> Int {
//    let remainSeats = lec.maxStudents - lec.numOfRegistered
//    return remainSeats
//}

//remainSeats(of: lec)
lec.remainSeats()
lec.register()
lec.register()
lec.register()
lec.register()
lec.register()
lec.register()
lec.register()

lec.remainSeats()

Lecture.target
Lecture.소속학원이름()
