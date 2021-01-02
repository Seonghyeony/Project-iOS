import UIKit

/**
 Set: 순서가 없고 중복이 없는 데이터 셋
 중복이 없는 유니크한 아이템들을 관리할 때 사용.
 */

//var someArray: Array<Int> = [1, 2, 3, 1]
var someSet: Set<Int> = [1, 2, 3, 1]

someSet.isEmpty
someSet.count

someSet.contains(4)
someSet.contains(1)


someSet.insert(5)
someSet

someSet.remove(1)
someSet

