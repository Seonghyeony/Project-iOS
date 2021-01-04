//
//  DetailViewController.swift
//  BountyList
//
//  Created by 임성현 on 2021/01/04.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    var name: String?
    var bounty: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 메모리에 올라왔을 때.
        updateUI()
    }
    
    
    func updateUI() {
        if let name = self.name, let bounty = self.bounty {
            let img = UIImage(named: "\(name).jpg")
            imgView.image = img
            nameLabel.text = name
            bountyLabel.text = "\(bounty)"
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        // 사라진다.
        dismiss(animated: true, completion: nil)    // completion: 사라진 후에 동작되어야 할 것.
        
    }
    
}
