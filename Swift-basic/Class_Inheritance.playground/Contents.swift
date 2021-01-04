import UIKit

/**
 상속은 A is B(A는 B에 포함) 라는 논리에 해당이 된다면 상속을 시킬 수 있다.
 ex)
    Student is Person
    Teacher is Person
    Person is Student   X
 
 - 상속의 규칙
    1. 자식은 한 개의 super class만 상속 받음
    2. 부모는 여러 자식들을 가질 수 있다.
    3. 상속의 깊이는 상관이 없다.
 
 
 --- 상속은 언제 하면 좋을까?? ---
 명확한 정답은 없다.
 
 장점: 중복되는 코드 제거 가능
 단점: 상속의 깊어지면 복잡해짐
 
 개발 철학(고려사항)을 세우는 것이 필요 -- 자신만의 개발 철학을 세우자! 그래야 내 코드의 근거가 된다.
 
 1. Single Responsibility (단일 책임)
    - 각 클래스는 한 개의 고려사항만 있으면 된다. 너무 많은 책임을 가지려고 하면 안된다.
    - 한 가지 일만.
 
 2. Type Safety (타입이 분명해야 할 때)
    - 운동부, 미술부, 과학부...
 
 3. Shared Base Classes (기본 동작에 대해서 다양하게 구현해야 하는가 ex) 학습한다.)
    - 운동부 학생은 운동 관련 학습을 한다.
    - 미술부 학생은 미술 관련 학습을 한다.
    ==> 이렇듯 내용 자체가 다르게 구현해야 할 때
 
 4. Extensibility (확장성)
    - 학생 개체
    - 의대생, 미대생 등 학생 개체를 확장할 수 있을 때
 
 5. Identity (정체를 파악하기 위해)
    - 학생이긴 한데 체대생이야 의대생이야? 이럴 때.
 
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
//class Student {
//    var grades: [Grade] = []
//
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
}

let jay = Person(firstName: "Jay", lastName: "Lim")
let hyeony = Student(firstName: "Hyeon", lastName: "Lim")


jay.firstName
hyeony.firstName

jay.printMyName()
hyeony.printMyName()

let math = Grade(letter: "B", points: 8.5, credits: 3)
let history = Grade(letter: "A", points: 10.0, credits: 3)
hyeony.grades.append(math)
hyeony.grades.append(history)
hyeony.grades.count


// 학생인데 운동선수
class StudentAthlelte: Student {
    var minimumTrainingTime: Int = 2
    var trainedTime: Int = 0
    
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

// Person > Student > Athelete > Football Player

var athelete1 = StudentAthlelte(firstName: "Yuna", lastName: "Kim")
var athelete2 = FootballPlayer(firstName: "Heung", lastName: "Son")

athelete1.firstName
athelete2.firstName

athelete1.grades.append(math)
athelete2.grades.append(math)

athelete1.minimumTrainingTime
athelete2.minimumTrainingTime

athelete2.footballTeam

athelete1.train()
athelete1.trainedTime

athelete2.train()
athelete2.trainedTime


// uppercast
athelete1 = athelete2 as StudentAthlelte  // 재할당 가능. 축구 선수 이지만 운동 선수기 때문에 할당 가능
athelete1.train()
athelete1.trainedTime

//athelete1.footballTeam    // uppercast 되어서 StudentAthelete 프로퍼티만 접근 가능.

// downcasting 해서 FootballPlayer의 프로퍼티에 접근 가능
if let son = athelete1 as? FootballPlayer {
    print("--> team: \(son.footballTeam)")
}

