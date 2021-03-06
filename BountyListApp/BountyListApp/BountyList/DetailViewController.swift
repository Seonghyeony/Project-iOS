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
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 메모리에 올라왔을 때의 시점.
        updateUI()
        // animation을 준비.
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 뷰가 보여지는 시점이다.
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    private func prepareAnimation() {
        /**
         오토레이아웃의 Constraints를 가지고 animation을 하는 방법.
         */
        // constant 값들이 변경되면 Layouting을 다시 해야 한다.
//        nameLabelCenterX.constant = view.bounds.width
//        bountyLabelCenterX.constant = view.bounds.width
        
        /**
         View Properties를 사용하여 Animating 하는 방법.
            1. Position & Size - Bounds, frame, center => 주의사항: 오토레이아웃의 범위를 넘지 말자.
            2. Transformation - Rotation, scale, translation => AffineTransform을 사용.
            3. Appearance - backgroundColor, alpha
         */
        
        // 우측에 있고 스케일은 3배, 180도 회전해서
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        
        nameLabel.alpha = 0     // 투명도.
        bountyLabel.alpha = 0
    }
    
    private func showAnimation() {
//        // NSLayoutConstraint 라는 Constraint로 애니메이팅.
//        nameLabelCenterX.constant = 0
//        bountyLabelCenterX.constant = 0
//
//        // curveEaseIn: 빨라졌다가 천천히 갈건지 등 정하는 것.
//        // completion: 애니메이션이 끝났을 때 무엇을 할 것인가?
//        UIView.animate(withDuration: 0.3,
//                       delay: 0.1,
//                       options: .curveEaseIn,
//                       animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//
//        // usingSpringWithDamping: 스프링처럼 튀게.
//        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
//            // 레이아웃을 다시 해야할 필요가 있으면 다시 해라!
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//
//        // 이미지 뷰 뒤집히면서 표시.
//        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            // identity: 변하기 전의 모습으로 접근 가능.
            self.nameLabel.transform = CGAffineTransform.identity
            self.nameLabel.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            // identity: 변하기 전의 모습으로 접근 가능.
            self.bountyLabel.transform = CGAffineTransform.identity
            self.bountyLabel.alpha = 1
        }, completion: nil)
        
        // 이미지 뷰 뒤집히면서 표시.
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
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
