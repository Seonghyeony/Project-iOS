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
    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
    let bountyList = [33000000, 50, 44000000, 300000000, 16000000, 80000000, 77000000, 120000000]
    
    // 세그웨이를 수행하기 전에 준비하는 메서드. 이 때 데이터를 준비하자!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 줄 겁니다.
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            // 셀 번호 이니깐 Int로 다운 캐스팅
            if let index = sender as? Int {
                vc?.name = nameList[index]
                vc?.bounty = bountyList[index]
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
        return bountyList.count
    }
    
    // 어떻게 표현할 거니?: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCell: 셀을 재활용하는 기능
        // withIdentifier: cell을 지정해놓은 이름
        // indexPath: 몇 번째 cell을 클릭하는지 정보: 위치 정보
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {  // 캐스팅
            return UITableViewCell()
        }
        
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        cell.imgView.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.bountyLabel.text = "\(bountyList[indexPath.row])"
        return cell
        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell {
//            let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
//            cell.imgView.image = img
//            cell.nameLabel.text = nameList[indexPath.row]
//            cell.bountyLabel.text = "\(bountyList[indexPath.row])"
//            return cell
//        } else {
//            return UITableViewCell()
//        }
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
}
