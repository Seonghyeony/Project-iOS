import UIKit

/**
 Object = Data + Method.
 
 Properties: Data 부분.
  - Stored Property: 저장하는 Property
    > observation: 값이 변경이 되는 것을 알아차려야 할 때가 있기 때문에 이런 기능이 있다.
      willSet, didSet
 
  - Computed Property: 어떠한 정보를 직접 저장하지는 않고 Stored된 Property를 재가공하거나 계산할 때 사용. 매번 접근할 때마다 다시 계산이 된다.
   ex) Structure_Challenge 파일에서
    var description: String {
        return "Title: \(name), Teacher: \(teacher)"
    }
 
  - Type Property: 생성된 인스턴스에 상관없이 Type 자체에 속성을 정하고 싶을 때 사용.
 
  - Lazy Property: 해당 Property에 접근이 될 때, 그제서야 코드가 실행이 되는 Property.
            굳이 안써도 되는데 엔지니어링 측면에서 최적화 하기 위해 종종 쓰인다.
            Struct를 만들 때, Cost 가 드는 게 있을 때 나중에 접근하는 lazy 키워드를 가끔 쓴다.
            모든 사용자들이 쓰지 않는 프로퍼티에 대해 Cost를 줄이기 위해 종종 사용.
 */

/**
 Propery (Computed Property)
    - 호출 시 (저장된) 값을 하나 반환한다!
 
 Method
    - 호출 시 어떤 작업을 한다.
 
 > 만약에 Method가 그냥 값을 리턴하는 작업을 한다면? --> Computed Property 가 하는 일이랑 똑같게 된다. 그래서 기준을 세워보자.
 
 >> setter가 필요한가? 네 -> Computed Property
    아니오 -> 계산이 많이 필요한가? 혹은 DB access나 File io가 필요한가? 네 -> Method
                        아니오 -> Computed Property
 */


struct Person {
    // Stored Property
    var firstName: String {     // 변경된 시점을 알고싶다!
        willSet {   // 세팅 직전에 호출. willSet -> didSet
            print("willSet: \(firstName) --> \(newValue)")
        }
        didSet {    // 세팅 후 호출. didSet은 Stored Property에서만 사용 가능
            print("didSet: \(oldValue) --> \(firstName)")
        }
    }
    var lastName: String
    
    // lazy property
    lazy var isPopular: Bool = {
        if fullName == "Jay Park" {
            return true
        } else {
            return false
        }
    }()
    
    // Computed Property - defalut 는 Read Only
//    var fullName: String {
//        get {
//            return "\(firstName) \(lastName)"
//        }
//
//        // setter를 설정해주면 Stored Property를 변경 가능!
//        set {
//            // newValue  "Jay Park"
//
//            if let firstName = newValue.components(separatedBy: " ").first {
//                self.firstName = firstName
//            }
//
//            if let lastName = newValue.components(separatedBy: " ").last {
//                self.lastName = lastName
//            }
//        }
//    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
//    func fullName() -> String {
//        return "\(firstName) \(lastName)"
//    }
    
    // Type Property - static 키워드!
    static let isAlien: Bool = false
}

var person = Person(firstName: "Hyeony", lastName: "Lim")

//person.firstName
//person.lastName
//
//person.firstName = "Jim"
//person.lastName = "Kim"
//
//person.firstName
//person.lastName
//
////person.isPopular
//
//person.fullName
//person.fullName = "Jay Park"
//person.fullName
//
//person.firstName
//person.lastName
//
//// Type Property
//Person.isAlien
//
//// lazy Property
//person.isPopular

person.fullName
//person.fullName()


