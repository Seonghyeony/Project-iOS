//
//  BountyViewController.swift
//  BountyList
//
//  Created by 임성현 on 2021/01/04.
//

/**
 TableView
 - 여러 아이템을 리스트 형식으로 보여주고 싶을 때 사용.
 
 1. 테이블 뷰 셀 몇 개?
 2. 테이블 뷰 어떻게 보여줄까?
    1, 2 번의 대한 것은 무조건 해야 한다.
    UITableViewDataSource
 
 3. 테이블 뷰 클릭하면 어떡해?
    UITableViewDelegate
 ...
 
 테이블 뷰 서비스를 쓰기 위해 해야 할 일. => Protocol 개념
 
 Protocol? 어떤 서비스를 이용하기 위해 해야할 일.
 
 */

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /**
     코드리뷰: name과 bounty 가 연결되어 있지 않아서 변경하기, 접근하기 어렵다. 문제가 있다!!!
     
     재사용하기 어려운 코드인 것 같다. -> 기술 부채가 있다.
     기술 부채를 최소화 하는 것이 엔지니어의 중요한 역할 중 하나다.
     
     --> 기술 부채를 최소화하는 방향으로.
     ===> MVVM 디자인 패턴!!!!!
     */
    
    // MVVM
    
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들자.
    
    // View
    // - ListCell
    // > ListCell에 필요한 정보를 ViewModel한테서 받아야 겠다.
    // > ListCell은 ViewModel로부터 받은 정보로 뷰 업데이트 하기.
    
    // ViewModel
    // - BountyViewModel
    // > BountyViewModel을 만들고, 뷰 Layer에서 필요한 메서드 만들기
    // > 모델 가지고 있기 ,, BountyInfo 들.
    
    let viewModel = BountyViewModel()
    
    // 세그웨이를 수행하기 전에 준비하는 메서드. 이 때 데이터를 준비하자!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄 겁니다.
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            // 셀 번호 이니깐 Int로 다운 캐스팅
            if let index = sender as? Int {
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // UITableViewDataSource
    
    // 셀은 몇 개니? : numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    // 어떻게 표현할 거니?: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCell: 셀을 재활용하는 기능
        // withIdentifier: cell을 지정해놓은 이름
        // indexPath: 몇 번째 cell을 클릭하는지 정보: 위치 정보
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {  // 캐스팅
            return UITableViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)
        cell.update(info: bountyInfo)
        return cell
    }
    
    // UITableViewDelegate
    // 클릭되었을 때 어떻게 할거야?: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        // 세그웨이를 수행해라! sender - 몇 번째 셀인지 보낸다. indexPath.row
        performSegue(withIdentifier: "showDetail", sender: indexPath.row) // sender: 세그웨이를 수행하면서 특정 Object를 같이 보낼 수 있다.
        
    }
}

// Custom Cell
class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}

// ViewModel
class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]
    
    // Sorted
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        
        return sortedList
    }
    
    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}
