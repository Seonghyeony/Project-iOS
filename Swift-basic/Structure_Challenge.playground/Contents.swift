import UIKit

// 도전 과제
// 1. 강의 이름, 강사 이름, 학생 수를 가지는 Struct 만들기 (Lecture)
// 2. 강의 Array와 강사 이름을 받아서 해당 강사의 강의 이름을 출력하는 함수 만들기
// 3. 강의 3개를 만들고 강사 이름으로 강의 찾기

/**
 Protocol? 지켜야 할 약속, 규약
 -- 꼭 구현해야 하는 목록들! 해야하는 일들!
 -- 어떠한 서비스를 이용할 때 해야할 일
 */

// CustomStringConvertible - Protocol

struct Lecture: CustomStringConvertible {
    var description: String {
        return "Title: \(name), Teacher: \(teacher)"
    }
    
    let name: String
    let teacher: String
    let numOfStudent: Int
}

func printLectureNameOfTeacher(lectures: [Lecture], from teacher: String) {
//    var lectureName = ""
//    for lecture in lectures {
//        if lecture.teacher == teacher {
//            lectureName = lecture.name
//        }
//    }
    
    // 클로저를 이용해본 것.
    let lectureName = lectures.first { lec in
        return lec.teacher == teacher
    }?.name ?? ""
    // 더 줄인 표현
//    let lectureName = lectures.first { $0.teacher == teacher }?.name ?? ""
    
    print("아 그 강사님 강의는요: \(lectureName)")
}

let lec1 = Lecture(name: "iOS Basic", teacher: "Hyeony", numOfStudent: 100)
let lec2 = Lecture(name: "Android", teacher: "Jason", numOfStudent: 100)
let lec3 = Lecture(name: "Algorithm", teacher: "Jake", numOfStudent: 100)

let lec_array = [lec1, lec2, lec3]

printLectureNameOfTeacher(lectures: lec_array, from: "Hyeony")


print(lec1)
