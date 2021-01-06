//
//  DetailViewController.swift
//  BountyList
//
//  Created by 임성현 on 2021/01/04.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MVVM
    
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들자.
    
    // View
    // - imgView, nameLabel, boutylabel
    // > view들은 viewModel을 통해서 구성되기?
    
    // ViewModel
    // - DetailViewModel
    // > 뷰 Layer에서 필요한 메서드 만들기
    // > 모델 가지고 있기 ,, BountyInfo 들.
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    let viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 메모리에 올라왔을 때.
        updateUI()
    }
    
    
    func updateUI() {
        
        if let bountyInfo = viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        // 사라진다.
        dismiss(animated: true, completion: nil)    // completion: 사라진 후에 동작되어야 할 것.
    }
    
}

class DetailViewModel {
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?) {
        bountyInfo = model
    }
}
