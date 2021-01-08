//
//  BountyInfo.swift
//  BountyList
//
//  Created by 임성현 on 2021/01/06.
//

import UIKit

// Model
struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
