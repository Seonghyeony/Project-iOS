import UIKit

// 1. 성, 이름을 받아서 fullname을 출력하는 함수 만들기

// 2. 1번에서 만든 함수인데, 파라미터 이름을 제거하고 fullname을 출력하는 함수 만들기

// 3. 성, 이름을 받아서 fullname return 하는 함수 만들기

/**
 1.
 */
func printFullName(firstName: String, lastName: String) {
    print("FullName is \(firstName) \(lastName).")
}

printFullName(firstName: "Seonghyeon", lastName: "Lim")

/**
 2.
 */

func printFullName_2(_ firstName: String, _ lastName: String) {
    print("FullName is \(firstName) \(lastName).")
}

printFullName_2("Seonghyeon", "Lim")

/**
 3.
 */
func returnFullName(_ firstName: String, _ lastName: String) -> String {
    //return firstName + lastName
    return "\(firstName) \(lastName)"
}

let fullName = returnFullName("Seonghyeon", "Lim")
fullName
