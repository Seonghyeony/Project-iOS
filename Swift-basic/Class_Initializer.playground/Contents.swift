import UIKit

/**
 ** 2-phase Initialization (클래스 생성 시 2단계)
 *
 * 인스턴스 생성 시점에 기본적으로 모든 Stored Properties 들을 셋팅해줘야 함.
 
 상속을 받은 클래스(자식 클래스)가 initialize를 할 때에는 규칙이 있다.
 상속을 받는 클래스의 Stored Property를 먼저 셋팅하고 부모 클래스의 Property를 셋팅.
 
 Phase1: 클래스의 모든 Stored Property는 initialize 되어야 한다.
        자식 클래스의 프로퍼티 부터 initialize
    Phase1이 끝나기 전에는 어떤 프로퍼티나 메소드를 사용이 불가.
 
    StudentAthlete -> Student -> Person
 
 Phase2: Phase1이 끝나고 나서 메소드를 쓸 수 있다.
 
    Person -> Student -> StudentAthlete
 *
 *
 ** designated vs. convenience  Initialization.
 *     지정           간편
 *
 1. DI는 자신의 부모의 DI를 호출해야 함.
 2. CI는 같은 클래스의 이니셜라이저를 꼭 하나 호출해야 함.
 3. CI는 궁극적으로는 DI를 호출해야 함.
 
 */

//struct Grade {
//    var letter: Character
//    var points: Double
//    var credits: Double
//}
//
//class Person {
//    var firstName: String
//    var lastName: String
//
//    init(firstName: String, lastName: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//    }
//
//    func printMyName() -> Void {
//        print("My name is \(firstName) \(lastName)")
//    }
//}
//
//class Student: Person {
//    var grades: [Grade] = []
//}
//
//// 학생인데 운동선수
//class StudentAthlelte: Student {
//    var minimumTrainingTime: Int = 2
//    var trainedTime: Int = 0
//
//    func train() {
//        trainedTime += 1
//    }
//}
//
//// 운동선수인데 축구 선수
//class FootballPlayer: StudentAthlelte {
//    var footballTeam = "FC Swift"
//
//    // 부모의 함수를 자식에서 쓸 때는 override를 해야함.
//    override func train() {
//        trainedTime += 2
//    }
//}

struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func printMyName() -> Void {
        print("My name is \(firstName) \(lastName)")
    }
}

class Student: Person {
    var grades: [Grade] = []
    
    // designated initializer - 주 initializer
    override init(firstName: String, lastName: String) {
        super.init(firstName: firstName, lastName: lastName)
    }
    
    // convenience initializer - 부 initializer
    convenience init(student: Student) {
        self.init(firstName: student.firstName, lastName: student.lastName)
    }
}

// 학생인데 운동선수
class StudentAthlelte: Student {
    var minimumTrainingTime: Int = 2
    var trainedTime: Int = 0
    var sports: [String]
    
    // 상속을 받은 클래스가 initialize를 할 때에는 규칙이 있다.
    init(firstName: String, lastName: String, sports: [String]) {
        // Phase1: 자식(상속을 받는) 클래스의 Stored Property를 먼저 셋팅하고 부모 클래스의 Property를 셋팅.
        self.sports = sports
        super.init(firstName: firstName, lastName: lastName)
        
        // Phase2: Phase1 이후 접근 가능함.
        self.train()
    }
    
    // convenience initializer: 파라미터가 길어질 때 간편하고 간략하게 쓸 수 있도록 해주는 기능. - 부 initializer 개념.
    convenience init(name: String) {
        self.init(firstName: name, lastName: "", sports: [])
    }
    
    
    func train() {
        trainedTime += 1
    }
}

// 운동선수인데 축구 선수
class FootballPlayer: StudentAthlelte {
    var footballTeam = "FC Swift"
    
    // 부모의 함수를 자식에서 쓸 때는 override를 해야함.
    override func train() {
        trainedTime += 2
    }
}

let student1 = Student(firstName: "Hyeon", lastName: "Lim")
let student1_1 = Student(student: student1) // 전학..?
let student2 = StudentAthlelte(firstName: "Jay", lastName: "Lim", sports: ["Football"])
let student3 = StudentAthlelte(name: "Mike")

