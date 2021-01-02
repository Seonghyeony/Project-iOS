import UIKit

/**
 Collection
 Array, Dictionary,
 
 Array: 순서가 있는 아이템, 순서를 알면 유용할 때.
 */

var evenNumbers: [Int] = [2, 4, 6, 8]
//var evenNumbers: [Int] = []
//let evenNumbers2: Array<Int> = [2, 4, 6, 8]

evenNumbers.append(10)
evenNumbers += [12, 14, 16]
evenNumbers.append(contentsOf: [18, 20])

//evenNumbers = []
// ***** let isEmpty = evenNumbers.isEmpty *****

print(evenNumbers.count)    // *****

print(evenNumbers.first)    // 있을 수도 있고 없을 수도 있기 때문에 옵셔널이다.

//evenNumbers = []
//let firstItem = evenNumbers.first

if let firstElement = evenNumbers.first {
    print("---> first item is : \(firstElement)")
}

// 다 옵셔널이다.
evenNumbers.min()
evenNumbers.max()

var firstItem = evenNumbers[0]
var secondItem = evenNumbers[1]
var tenthItem = evenNumbers[9]

//var lastItem = evenNumbers[-1]


// ------>

//let firstThree = evenNumbers[0...2]
evenNumbers

evenNumbers.contains(3)
evenNumbers.contains(4)

evenNumbers.insert(0, at: 0)
evenNumbers

//evenNumbers.removeAll()
evenNumbers.remove(at: 0)
evenNumbers

evenNumbers[0] = -2
evenNumbers

evenNumbers[0...2] = [-2, 0, 2]
evenNumbers

//evenNumbers.swapAt(0, 9)


//for num in evenNumbers {
//    print(num)
//}

for (index, num) in evenNumbers.enumerated() {
    print("idx: \(index), value: \(num)")
}


let firstThreeRemoved = evenNumbers.dropFirst(3)
firstThreeRemoved

let lastRemoved = evenNumbers.dropLast()
lastRemoved


let firstThree = evenNumbers.prefix(3)
firstThree

let lastThree = evenNumbers.suffix(3)
lastThree
