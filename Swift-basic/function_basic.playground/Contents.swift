import UIKit

// ---- function
/**
 function vs. Method
 기능을 수행하는 것은 맞지만 Method는 오브젝트에 속해 있다는 것이 특징이다.
 */

func printName() {
    print("---> My name is Seonghyeony")
}

printName()

// param 1개
// 숫자를 받아서 10을 곱해서 출력한다.

func printMultipleOfTen(value: Int) {
    print("\(value) * 10 = \(value * 10)")
}

printMultipleOfTen(value: 5)

// param 2개
// 물건 값과 갯수를 받아서 전체 금액을 출력하는 함수

//func printTotalPrice(price: Int, count: Int) {
//    print("Total Price: \(price * count)")
//}
//
//printTotalPrice(price: 1500, count: 5)

// 파라미터에서 이름을 안 적고 싶을 때는 파라미터 name 앞에 _ 표기.
//func printTotalPrice(_ price: Int, _ count: Int) {
//    print("Total Price: \(price * count)")
//}
//printTotalPrice(1500, 5)

//func printTotalPrice(가격 price: Int, 갯수 count: Int) {
//    print("Total Price: \(price * count)")
//}
//
//printTotalPrice(가격: 1500, 갯수: 5)

// 함수에 default 파라미터 값 설정 가능

func printTotalPriceWithDefaultValue(price: Int = 1500, count: Int) {
    print("Total Price: \(price * count)")
}

printTotalPriceWithDefaultValue(count: 5)
printTotalPriceWithDefaultValue(count: 10)
printTotalPriceWithDefaultValue(count: 7)
printTotalPriceWithDefaultValue(count: 1)

printTotalPriceWithDefaultValue(price: 2000, count: 1)

// 반환 값이 있는 경우
func totalPrice(price: Int, count: Int) -> Int {
    let totalPrice = price * count
    return totalPrice
}
let calculatedPrice = totalPrice(price: 10000, count: 77)
calculatedPrice


