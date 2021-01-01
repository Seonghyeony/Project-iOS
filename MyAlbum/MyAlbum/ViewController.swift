//
//  ViewController.swift
//  MyAlbum
//
//  Created by 임성현 on 2020/12/30.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0    // 인스턴스 변수(오브젝트 변수)
    
    @IBOutlet weak var priceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    // @IBAction func hello() 에서 hello 함수를 멋대로 바꾸면 빌드는 성공하지만 앱이 크래쉬가 난다.(앱이 죽는다고 표현한다)
    @IBAction func showAlert(_ sender: Any) {
        // string 인터폴레이션
        let message = "가격은 \(currentValue)원 입니다."   // 로컬 변수
        
        // alert 만드는 과정
        let alert = UIAlertController(title: "Hello", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.refresh()
        })
        alert.addAction(action)
        
        // present를 통해서 띄우게 된다.
        present(alert, animated: true, completion: nil)
    }
    
    // 메소드는 최대한 1가지 일만 하는 메소드를 작성하는 것이 좋다.
    func refresh() {
        // arc4random_uniform() 이 메서드는 0 ~ 9999 사이에서의 랜덤 숫자를 들고 온다.
        let randomPrice = arc4random_uniform(10000) + 1 // 로컬 변수
        currentValue = Int(randomPrice)
        priceLabel.text = "￦ \(currentValue)"
    }
}

