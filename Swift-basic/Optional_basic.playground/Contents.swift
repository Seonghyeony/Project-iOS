import UIKit

/**
 없는 것을 어떻게 표현할 것이냐!
 값을 가지고 있지 않은 경우, 가지고 있는 경우를 표현 가능.
 
 --- nil: 없음을 의미하는 키워드
 */

var carName: String?
carName = nil
carName = "Rolls Royce"


// 아주 간단한 과제
// 최애하는 영화배우의 이름을 담는 변수를 작성. (타입 String?)
// let num = Int("10") -> 이 것의 타입은?

var favoriteMovieStar: String? = nil    // 없음을 의미
let num = Int("10")     // type 변환을 성공할 수도 있고 실패할 수도 있다. 그래서 옵셔널 타입으로 된다.


// ---- 고급기능 4가지

// 1. Forced unwrapping > 강제로 박스를 까보기
// 2. Optional binding (if let) > 부드럽게 박스를 까보자 1
// 3. Optional binding (guard) > 부드럽게 박스를 까보자 2
// 4. Nil coalescing > 박스를 까봤더니, 값이 없으면 디폴트 값을 줘보자

//carName = nil
//print(carName!)     // Forced unwrapping을 할 때, 값이 Nil인 경우에는 시스템 에러가 난다.

carName = nil
if let unwrappedCarName = carName {
    print(unwrappedCarName)
} else {
    print("Car Name 없다.")
}



//func printParsedInt(from: String) {
//    if let parsedInt = Int(from) {
//        print(parsedInt)
//        // Cyclomatic Complexity - 레벨 덱스가 높다는 의미
//
//    } else {
//        print("Int로 컨버팅 안된다 임마!")
//    }
//}

//printParsedInt(from: "100")
//printParsedInt(from: "hello world")

/**
 if let 방식은 Cyclomatic Complexity를 높일 수 있다!
 --> guard를 쓰면 좀 더 깔끔하게 옵셔널 바인딩을 할 수 있다.
 */
func printParsedInt(from: String) {
    guard let parsedInt = Int(from) else {  // guard 문이 내부적인 복잡성을 좀 더 줄일 수 있는 방법이다.
        print("Int로 컨버팅 안된다 임마!")
        return
    }
    print(parsedInt)
}

printParsedInt(from: "100")
//printParsedInt(from: "hello world")

/**
 4. Nil coalescing > 박스를 까봤더니, 값이 없으면 디폴트 값을 줘보자
 
 ?? --> carName이 nil 이라면  - ?? "모델 S" - 모델 S로 바꿔라.
 ?? 키워드 사용.
 */

carName = "Rolls Royce"
let myCarName: String = carName ?? "모델 S"



// ---- 도전 과제
// 1. 최애 음식 이름을 담는 변수를 작성 (String?)
// 2. 옵셔널 바인딩을 이용해서 값을 확인해보기
// 3. 닉네임을 받아서 출력하는 함수 만들기, 조건: 입력 파라미터는 String?

var favoriteFoodName: String?
favoriteFoodName = "탕수육"

// 1. 강제 언래핑
print(favoriteFoodName!)

// 2. Optional binding 1
if let foodName = favoriteFoodName {
    print("---> Optional binding 1: \(foodName)")
} else {
    print("---> 좋아하는 음식 없다 임마!")
}

// 3. Optional binding 2
func printNickname(name: String?) {
    guard let nickName = name else {
        print("---> 닉네임 만들어 봐!")
        return
    }
    print("---> 닉네임: \(nickName)")
}
printNickname(name: "Seonghyeony")
printNickname(name: nil)

