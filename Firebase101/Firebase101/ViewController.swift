//
//  ViewController.swift
//  Firebase101
//
//  Created by 임성현 on 2021/01/17.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    let db = Database.database().reference()

    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateLabel()
    }
    
    func updateLabel() {
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print("---> \(snapshot)")
            
            let value = snapshot.value as? String ?? ""
            
            DispatchQueue.main.async {
                self.dataLabel.text = value
            }
        }
    }
}

