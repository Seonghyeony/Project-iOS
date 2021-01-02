import UIKit

/**
 Closure: 이름이 없는 함수. 메소드. 함수처럼 기능을 수행하는 코드블록의 특별한 타입.
 
 미리 정의할 필요 없이 동적으로 함수의 파라미터로 끼워 넣을 수 있는 점이 강력하다.
 실무에서 함수에 파라미터로 Closure로 받는 경우가 꽤 많다.
 
 아주 정확히는 함수는 Closure의 한 가지 타입이다.
 * Closure 의 3가지 타입
  - Global 함수
  - Nested 함수
  - Closure Expressions >> 보통 이거를 Closure 라고 부름.
 
 함수와 클로저는 First Class Type이다.
 First Class Type?
  - 변수에 할당할 수 있다.
  - 인자로 받을 수 잇다.
  - 리턴 할 수 있다.
 
 
 Closure는 실무에서 2가지의 경우에 자주 쓰인다.
  1. Completion Block
  2. Higher Order Functions
 
  1) Completion Block
    - 어떤 Task가 완료가 되었을 때, Closure가 수행 자주 수행된다.
    ex) 네트워크를 통해서 데이터를 받아올 때는 네트워크 환경에 따라서 빨리 받을 수도 있고, 늦게 받을 수도 있다.
    비동기적으로 데이터를 받아지는 것이 완료되었을 때 데이터를 뿌려주는 코드 블럭 자체를 수행시킬 때 Closure를 많이 쓴다.
    
  2) Higher Order Functions
    - 함수인데 Input으로 함수를 받을 수 있는 유형의 함수를 Higher Order Function이라고 한다.(곡예 함수)
    곡예 함수로는: Collection에서 주로 Map, Filter, Reduce..? 아무튼 이거를 사용할 때 Closure가 많이 쓰인다.
    
 
 * Closure Expression Syntax
 { (parameters) -> return type in
    statements
 }
 */

//var multiplyClosure: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
//    return a * b
//}

// 위의 클로저 함수를 이렇게 까지 줄일 수 있다.
//var multiplyClosure: (Int, Int) -> Int = { $0 * $1 }

// but, 이렇게 까지만 하는 게 좋다.
var multiplyClosure: (Int, Int) -> Int = { a, b in
    return a * b
}

let result = multiplyClosure(4, 2)


func operateTwoNum(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    return result
}

operateTwoNum(a: 4, b: 2, operation: multiplyClosure)

var addClosure: (Int, Int) -> Int = { a, b in
    return a + b
}
operateTwoNum(a: 4, b: 2, operation: addClosure)

// 이렇게 동적으로 넣을 수 있는 점이 강력하다.
operateTwoNum(a: 4, b: 2) { a, b in
    return a / b
}

// 입력과 반환이 없는 클로저
let voidClosure: () -> Void = {
    print("iOS 개발자 짱, 클로저 사랑해")
}

voidClosure()

/**
 """Capturing Values"""
 
 ex)
 if true {
    let name = "Hyeony"
    printClosure = {
        print(name)
    }
 }
 이 상황에서 printClosure는 if 문을 벗어나도 사용이 가능. ==> Scope 범위를 벗어날 수 있음!!!
 printClosure 안에 있는 name const 변수는 바깥 Scope에서도 사용이 가능.
 이것을 Captured 되었다고 표현함.
 
 --- 깔끔하게 사용할 수는 있지만, 뭐 파라미터 넘겨서 사용해도 무방하다.
 */

var count = 0

let incrementer = {
    count += 1
}

incrementer()
incrementer()
incrementer()
incrementer()

count


