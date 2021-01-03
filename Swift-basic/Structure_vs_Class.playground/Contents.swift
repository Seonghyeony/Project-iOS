import UIKit

/**
 -------- Struct vs. Class ------------
 
   Structure    vs.     Class
  Value Types      Reference Types
     Copy               Share
    복사된다.             참조된다.
   새로 만든다.         같은 것을 참조.
    Stack               heap
 */

class PersonClass {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct PersonStruct {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let pClass1 = PersonClass(name: "Hyeony", age: 26)
let pClass2 = pClass1
pClass2.name = "Seong"

pClass1.name
pClass2.name

var pStruct1 = PersonStruct(name: "Hyeony", age: 26)
var pStruct2 = pStruct1
pStruct2.name = "Seong"

pStruct1.name
pStruct2.name

