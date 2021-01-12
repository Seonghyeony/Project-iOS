import UIKit

let a: Bool?
a = true

func p() {
    guard let c = a, c == false else { return }
    c
}

p()
