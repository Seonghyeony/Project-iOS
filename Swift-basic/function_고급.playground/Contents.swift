import UIKit

/**
 함수는 1가지 일만 할 수 있도록 구현하는 것이 중요하다!
 함수는 최대한 순수하게. 한 가지 일만 할 수 있도록 짜는 것이 중요하다!
 10줄 이상 안짜는 것이 좋다.
 50줄 - 100줄 이상이 나오게 된다면 그것을 또 분리해보자.
 */

//func functionName(externalName param: ParamType) -> ReturnType {
//    // ......
//    return returnValue
//}

// 오버로딩 - 같은 이름의 함수이지만 파라미터의 타입이 다른.
func printTotalPrice(price: Int, count: Int) {
    print(" Total Price: \(price * count)")
}

func printTotalPrice(price: Double, count: Double) {
    print(" Total Price: \(price * count)")
}

func printTotalPrice(가격: Double, 갯수: Double) {
    print(" Total Price: \(가격 * 갯수)")
}

// In-out parameter

//func incrementAndPrint(_ value: Int) {
//    value += 1    // 파라미터로 들어오는 변수는 기본적으로 const 형식이다. 그래서 변경하려고 하면 오류가 난다. --> in-out 기법 사용.
//    print(value)
//}

var value = 3
func incrementAndPrint(_ value: inout Int) {    // inout 기법을 이용하면 변경 가능.
    value += 1
    print(value)
}
incrementAndPrint(&value)



// ---- Function as a param: 함수를 파라미터로 전달

func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func subtract(_ a: Int, _ b: Int) -> Int {
    return a - b
}

// 변수에 함수를 할당가능.
var function = add
function(4, 2)
function = subtract
function(4, 2)

func printResult(_ function: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    let result = function(a, b)
    print(result)
}

printResult(add, 10, 5)
printResult(subtract, 10, 5)
