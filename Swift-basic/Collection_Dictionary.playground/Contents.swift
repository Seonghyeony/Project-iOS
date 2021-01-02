import UIKit

/**
 딕셔너리는 Array와 다르게 순서가 없다.
 
 key - value 값 쌍.
 key는 유일 해야한다.
 
 key 값으로 데이터에 접근한다.
 */

var scoreDic: [String: Int] = ["Hyeony": 100, "Jason": 95, "Jake": 90]
//var scoreDic: Dictionary<String, Int> = ["Hyeony": 80, "Jason": 95, "Jake": 90]

if let score = scoreDic["Hyeony"] {
    score
} else {
    //... score 없음.
}

scoreDic["Jason"]
scoreDic["Jenny"]   // 값이 없을 때는 nil

//scoreDic = [:]
scoreDic.isEmpty
scoreDic.count

// 기존 사용자 업데이트
scoreDic["Jason"] = 99
scoreDic

// 사용자 추가
scoreDic["Jack"] = 80
scoreDic

// 사용자 제거
scoreDic["Jack"] = nil
scoreDic


for (name, score) in scoreDic {
    print("\(name), \(score)")
}

for key in scoreDic.keys {
    print(key)
}


// ----> 도전과제
// 1. 이름, 직업, 도시 에 대해서 본인의 딕셔너리 만들기
// 2. 여기서 도시를 부산으로 업데이트 하기
// 3. 딕셔너리를 받아서 이름과 도시 프린트하는 함수 만들기

// 1.
var myProfile: [String: String] = ["name": "Hyeony", "job": "Student", "city": "Changwon"]

// 2.
myProfile["City"] = "Busan"
myProfile

// 3.
func printNameAndCity(dic: [String: String]) {
    // 연결해서 옵셔널 바인딩 가능.
    if let name = dic["name"], let city = dic["city"] {
        print(name, city)
    } else {
        print("---> Cannot find")
    }
}
printNameAndCity(dic: myProfile)


