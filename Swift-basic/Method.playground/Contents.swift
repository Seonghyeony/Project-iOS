import UIKit

/**
 Method - Func과 기능은 같지만 Method는 class나 struct 안에서 동작.
 
 mutating
 
 extension을 이용해서 확장 가능!
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


/**
 extension 예제: 확장하고 싶을 때!
 
 기존의 struct에 계속적으로 추가해서 넣게 된다면 깔끔해지기는 하지만, 협업을 할 때 충돌이 날 수도 있기도 하고 꼭 깔끔해보이는게 정답이 아닐 수 있다.
 */

struct Math {
    static func abs(value: Int) -> Int {
        if value > 0 {
            return value
        } else {
            return -value
        }
    }
}

Math.abs(value: -20)

// 제곱, 반 값
extension Math {
    static func sqaure(value: Int) -> Int {
        return value * value
    }
    
    static func half(value: Int) -> Int {
        return value / 2
    }
}

// 기존 Apple의 Struct에 extension을 사용하여 내 입맛에 따라 추가할 수 있다.
extension Int {
    func square() -> Int {
        return self * self
    }
    
    func half() -> Int {
        return self / 2
    }
}

// 제곱, 반 값
var value: Int = 10
value.square()
value.half()


