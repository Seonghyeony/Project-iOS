import UIKit    // UI 공구함
import Foundation

// ---- while Loop

//while 조건 {
//    code...
//}

//var i = 0
//
//while i < 10 {
//    print(i)
//    i += 1
//}

print("--- While")
var i = 10
while i < 10 {
    print(i)
    
//    if i == 5 {
//        break
//    }
    
    i += 1
}

print("--- Repeat")
i = 10
repeat {
    print(i)
    i += 1
} while i < 10

/**
 while 과 repeat-while 은 팀에서 쓰는 것을 쓰자.
 */


// --- For Loop

let closedRange = 0...10
let halfClosedRange = 0..<10    // 표시는 위와 같지만 0-9 까지를 의미.

var sum = 0
for i in halfClosedRange {
    print("---> \(i)")
    sum += i
}

print("---> total sum: \(sum)")

var sinValue: CGFloat = 0   // CG: Core Grapics

for i in closedRange {
    sinValue = sin(CGFloat.pi/4 * CGFloat(i))
}

let name = "Seonghyeony"
for _ in closedRange {
    print("---> \(name)")
}

for i in closedRange {
    if i % 2 == 0 {
        print("---> 짝수: \(i)")
    }
}

// 위 구문을 where 키워드를 사용할 수도 있다.
// 더 편한 걸로 쓰자.
for i in closedRange where i % 2 == 0 {
    print("---> 짝수: \(i)")
}

for i in closedRange where i != 3 {
    print("---> \(i)")
}

// 중첩의 중첩의 중첩은 가독성이 떨어지므로 사용 주의!
//for i in closedRange {
//    for j in closedRange {
//        print("gugu -> \(i) * \(j) = \(i * j)")
//    }
//}


// ---- Switch: 다른 언어와 다르게 강력한 Switch 기능을 가지고 있다. 

//let num = 10

// default 케이스를 꼭 만들어야 한다. --> 모든 케이스에 대해 다루어줘야 한다.
//switch num {
//case 0:
//    print("--> 0 입니다. ")
//case 0...10:
//    print("--> 0 10 사이 입니다.")
//    // 다른 언어와 다르게 break 문 없이 그 case에 걸리면 바로 빠져나온다.
//case 10:
//    print("--> 10 입니다. ")
//default:
//    print("--> 나머지 입니다. ")
//}


let pet = "bird"

switch pet {
case "dog", "cat", "bird":  // 여러 가지 케이스를 넣을 수 있다.
    print("---> 집 동물이네요? ")
default:
    print("---> 잘 모르겠습니다.")
}


let num = 20

switch num {
case _ where num % 2 == 0:  // where 문을 이용할 수 있다.
    print("---> 짝수")
default:
    print("---> 홀수")
}


let coordinate = (x: 10, y: 10)

switch coordinate {
case (0, 0):        // 튜플을 이용할 수도 있다.
    print("---> 원점 이네요")
case (let x, 0):    // 변수를 이용하여 값을 사용할 수 있다.
    print("---> x축 이네요, \(x)")
case (0, let y):
    print("---> y축 이네요, \(y)")
case (let x, let y) where x == y:   // where 절을 사용하여 추가적인 조건을 걸 수도 있다.
    print("---> x랑 y가 같음. x, y = \(x), \(y)")
case (let x, let y):
    print("---> 좌표 어딘가 x, y = \(x), \(y)")
}

