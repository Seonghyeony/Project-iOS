import UIKit


/**
 Object = Data + Method
 
  Object    = Structure, Class
  Data      = Property
  Method    = Method
 
    Structure      vs.     Class

    value Types         Reference Types
     Copy                   Share
    Stack                   Heap
     Fast                   Slow
 
 RAM
 --- Stack      vs.      Heap
    Fast                Slow
 
 Stack: 시스템에서 당장 실행해야하거나 타이트하게 컨트롤 및 매니징해야하는 것들은 Stack에서 주로 처리.ex) 함수
 --> 효율적이고 빠르다.
 
 Heap: 시스템에서 클래스같은 Reference Type을 저장하는데에 주로 사용. 큰 메모리 풀. 동적으로 할당 가능. Stack 처럼 자동으로 메모리를 제거하지 않으므로 직접 제거 해주어야 함.
 하지만 크게 신경 쓰지 않도록 xCode 같은 곳에서 지원 중.
 --> 조금 복잡하고 구조적으로 간단하지 않으므로 Stack 보다는 느리다.
 
 - 실제 생성된 class 인스턴스는 Heap에 있고 이 것을 할당 받은 변수 그 자체는 Stack 공간에 생성이 된다. 이 변수는 주소를 가지고 있다.
 
 --- mutating은 Struct에서만 사용한다!
 */

/**
 Struct vs. Class
 언제, 무엇을 쓸까?
 
 ---- Struct
 1. 두 object를 "같다, 다르다" 로 비교해야 하는 경우
 2. Copy된 각 객체들이 독립적인 상태를 가져야 하는 경우
 3. 코드에서 오브젝트의 데이터를 여러 스레드 걸쳐 사용할 경우
   --> value type의 경우 인스턴스가 유니크 하다. 그래서 여러 스레드에 걸쳐 사용할 때 안전하게 사용 가능.
   한 객체에 여러 스레드가 접근하면 충돌이 일어난다.
 
 ---- Class
 1. 두 object의 인스턴스 자체가 같음을 확인해야 할 때
 2. 하나의 객체가 필요하고, 여러 대상에 의해 접근되고 변경이 필요한 경우
   --> iOS에서는 UI App 객체는 유일한 객체인데 여러 Object가 접근을 해야하는 경우이다.
 
 
 ==>
 1. 일단 Struct로 쓰자. 후에 Class로 변경이 필요하면 그 때 바꾸자.
   - Swift는 Struct를 좋아한다.
 
 */


struct PersonStruct {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    // mutating은 Struct에서만 사용.
    mutating func uppercaseName() {
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
}

class PersonClass {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    func uppercaseName() -> Void {
        self.firstName = firstName.uppercased()
        self.lastName = lastName.uppercased()
    }
}

var personStruct1 = PersonStruct(firstName: "SeongHyeon", lastName: "Lim")
var personStruct2 = personStruct1

var personClass1 = PersonClass(firstName: "Hyeon", lastName: "Lim")
var personClass2 = personClass1


personStruct2.firstName = "Jay"
personStruct1.firstName
personStruct2.firstName


personClass2.firstName = "Jay"
personClass1.firstName
personClass2.firstName



personClass2 = PersonClass(firstName: "Bob", lastName: "Sponge")
personClass1.firstName
personClass2.firstName

personClass1 = personClass2
personClass1.firstName
personClass2.firstName

