import UIKit

/**
 Structure: 관계있는 데이터들을 묶어서 표현할 수 있는 구조.
 
 ex) 편의점
  브랜드
  위치
  로고..
 
 의미있는 것을 묶어서 표현하면 리팩토링이나 협업에 코드 읽기가 쉬워진다.
 그냥 정보를 나열하는 것보다 묶어서 표현해주는 것이 훨씬 좋다.
 */

/** 문제: 나와 가장 가까운 편의점 찾기! */

// 거리 구하는 함수
func distance(current: Location, target: Location) -> Double {
    // 피타고라스
    let distanceX = Double(target.x - current.x)
    let distanceY = Double(target.y - current.y)
    let distance = sqrt(distanceX * distanceX + distanceY * distanceY)
    return distance
}

struct Location {
    let x: Int
    let y: Int
}

struct Store {
    let loc: Location
    let name: String
    let deliveryRange = 2.0
    
    // Struct에는 Method도 만들 수 있음.
    func isDeliverable(userLoc: Location) -> Bool {
        let distanceToStore = distance(current: userLoc, target: loc)
        return distanceToStore < deliveryRange
    }
}

// 현재 스토어 위치들
let store1 = Store(loc: Location(x: 3, y: 5), name: "gs")
//let store1 = (x: 3, y: 5, name: "gs")
let store2 = Store(loc: Location(x: 4, y: 6), name: "seven")
let store3 = Store(loc: Location(x: 1, y: 7), name: "cu")

// 가장 가까운 스토어 구해서 프린트 하는 함수
func printClosestStore(currentLocation: Location, stores: [Store]) {
    var closestStoreName = ""
    var closestStoreDistance = Double.infinity
    var isDeliverable = false
    
    for store in stores {
        let distanceToStore = distance(current: currentLocation, target: store.loc)
        closestStoreDistance = min(distanceToStore, closestStoreDistance)
        if closestStoreDistance == distanceToStore {
            closestStoreName = store.name
            isDeliverable = store.isDeliverable(userLoc: currentLocation)
        }
    }
    print("Closest store: \(closestStoreName), isDeliverable: \(isDeliverable)")
}


// Stores Array 세팅, 현재 내 위치 세팅
let myLocation = Location(x: 2, y: 5)
let stores = [store1, store2, store3]

// printClosestStore 함수 이용해서 현재 가장 가까운 스토어 출력하기
printClosestStore(currentLocation: myLocation, stores: stores)




