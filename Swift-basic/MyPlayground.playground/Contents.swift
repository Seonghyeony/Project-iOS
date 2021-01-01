import UIKit

// -- Comment

//var str = "Hello, playground"
//
//
//let value = arc4random_uniform(100)
//print("--> \(value)")

/**
 여기에 하고 싶은 말을
 길게 쓸 수 있다.
 동료야 사랑해.
 */

// -- Tuple: 서로 관계가 있는 데이터들을 표현할 때 자주 사용.

let coordinates = (4, 6)

let x = coordinates.0
let y = coordinates.1

let coordinatesNamed = (x: 2, y: 3)

let x2 = coordinatesNamed.x
let y2 = coordinatesNamed.y

let (x3, y3) = coordinatesNamed
x3
y3

// --- Boolean: 코드의 흐름을 제어할 때 많이 쓰임

let yes = true
let no = false

let isFourGreaterThanFive = 4 > 5

if isFourGreaterThanFive {
    print("---> 참")
} else {
    print("---> 거짓")
}

//if 조건..... {
//    // 조건이 참인 경우에 수행하는 코드를 여기다가...
//} else {
//    // 그렇지 않은 경우에 코드는 여기다가...
//}

let a = 5
let b = 10

if a > b {
    print("---> a가 크다")
} else {
    print("---> b가 크다")
}

let name1 = "Jin"
let name2 = "Jason"

let isTwoNameSame = name1 == name2

if isTwoNameSame {
    print("---> 같다.")
} else {
    print("---> 다르다.")
}

// --- 논리연산자(&&, ||) 삼항연산자

let isJason = name2 == "Jason"
let isMale = false

let jasonAndMale = isJason && isMale
let jasonOrMale = isJason || isMale

//let greetingMessage: String
//if isJason {
//    greetingMessage = "Hello Jason"
//} else {
//    greetingMessage = "Hello Somebody"
//}
//print("Msg: \(greetingMessage)")

let greetingMessage: String = isJason ? "Hello Jason" : "Hello Somebody"
print("Msg: \(greetingMessage)")


// --- Scope: 변수의 범위


var hours = 50
let payPerHour = 10000
var salary = 0

if hours > 40 {
    let extraHours = hours - 40
    salary += extraHours * payPerHour * 2
    hours -= extraHours
}

salary += hours * payPerHour

//print(hours)

