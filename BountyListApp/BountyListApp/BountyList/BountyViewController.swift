//
//  BountyViewController.swift
//  BountyList
//
//  Created by 임성현 on 2021/01/04.
//

/**
 Animation = 시작, 끝, 시간
 
 UIView.animate(
    // 진행되는 시간
    withDuration: 1.0,
    // 애니메이션 클로저
    animations: {
        layoutIfNeeded()
    }
 )
 */

import UIKit

// UICollectionViewDelegateFlowLayout: CollectionView 같은 경우는 아이템들을 자유롭게 배치할 수 있어서 FlowLayout 객체가 있다.
class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    }
    
    // UICollectionViewDataSource
    // 몇 개를 보여줄까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numOfBountyInfoList
    }
    
    // 셀은 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        cell.update(info: bountyInfo)
        return cell
    }
    
    // UICollectionViewDelegate
    // 셀이 클릭 되었을 때 어쩔까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> \(indexPath.item)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    // UICollectionViewDelegateFlowLayout - 디바이스마다 가로 폭이 달라서 셀 사이즈가 균형적으로 바뀌어져야하는데 그것을 따로 계산.
    // Cell Size를 계산 (목표: 다양한 디바이스에서 일관적인 디자인을 보여주기 위해)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        // bounds: collectionView의 사이즈를 알 수 있다.
        let width: CGFloat = (collectionView.bounds.width - itemSpacing) / 2
        let height: CGFloat = width * 10 / 7 + textAreaHeight
        
        return CGSize(width: width, height: height)
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

// Custom Cell
class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }
}
