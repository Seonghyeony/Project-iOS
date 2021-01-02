import UIKit

/*
{ (param) -> return type in
    statement
    ...
}
*/

// Example 1: 초 심플 Closure

//let simpleClosure = {
//
//}
//
//simpleClosure()

// Example 2: 코드 블록을 구현한 Closure

//let simpleClosure = {
//    print("Hello, 클로져, 코로나 제발 바이!")
//}
//
//simpleClosure()



// Example 3: Input 파라미터를 받는 Closure

//let simpleClosure: (String) -> Void = { name in
//    print("Hello, 클로져, 코로나 제발 바이! 나의 이름은 \(name) 입니다!")
//}
//
//simpleClosure("Seonghyeony")

// Example 4: 값을 리턴하는 Closure

//let simpleClosure: (String) -> String = { name in
//    let message = "iOS 개발 재밌어! \(name)님 경제적 자유를 얻으실 거에요!"
//    return message
//}
//
//let result = simpleClosure("Seonghyeony")
//print(result)


// Example 5: Closure를 파라미터로 받는 함수 구현

//func someSimpleFunction(simpleClosure: () -> Void) {
//    print("함수에서 호출이 되었습니다.")
//}
//
//someSimpleFunction(simpleClosure: {
//    print("Hello Corona from Closure")
//})

//func someSimpleFunction(simpleClosure: () -> Void) {
//    print("함수에서 호출이 되었습니다.")
//    simpleClosure()
//}
//
//someSimpleFunction(simpleClosure: {
//    print("Hello Corona from Closure")
//})


// Example 6: Trailing Closure

func someSimpleFunction(message: String, simpleClosure: () -> Void) {
    print("함수에서 호출이 되었습니다, 메세지는 \(message)")
    simpleClosure()
}

someSimpleFunction(message: "메로나, 코로나는 극혐!!!", simpleClosure: {
    print("Hello Corona from Closure")
})

// Trailing Closure: 인자가 여러 개가 있고, 마지막 인자가 Closure인 경우에는 조금 생략할 수 있다.
someSimpleFunction(message: "메로나, 코로나는 극혐!!!") {
    print("Hello Corona from Closure")
}



