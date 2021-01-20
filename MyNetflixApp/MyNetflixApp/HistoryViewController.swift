//
//  HistoryViewController.swift
//  MyNetflixApp
//
//  Created by 임성현 on 2021/01/20.
//  Copyright © 2021 com.joonwon. All rights reserved.
//

import UIKit
import FirebaseDatabase
class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let db = Database.database().reference().child("searchHistory")
    var searchTerms: [SearchTerm] = []
    
    // 메모리에 올라올 때.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // 실제로 뷰에 나타났을 때.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 데이터 불러오기.
        db.observeSingleEvent(of: .value) { (snapshot) in
            guard let searchHistory = snapshot.value as? [String: Any] else { return }
            let datas = Array(searchHistory.values)
            
            let data = try! JSONSerialization.data(withJSONObject: Array(searchHistory.values), options: [])
            
            let decoder = JSONDecoder()
            let searchTerms = try! decoder.decode([SearchTerm].self, from: data)
            
            // timestamp를 이용해서 정렬.
            self.searchTerms = searchTerms.sorted(by: { (term1, term2) in
                return term1.timestamp > term2.timestamp
            })
            // self.searchTerms = searchTerms.sorted { $0.timestamp > $1.timestamp }
            self.tableView.reloadData()
            
            print("---> snapshot: \(searchHistory.values), \(searchTerms)")
        }
    }
}

extension HistoryViewController: UITableViewDataSource {
    // 몇 개 가져올 거냐
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }
    
    // 어떻게 보여줄 거냐
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            return UITableViewCell()
        }
        cell.searchTerm.text = searchTerms[indexPath.row].term
        return cell
    }
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var searchTerm: UILabel!
    
}

struct SearchTerm: Codable {
    let term: String
    let timestamp: TimeInterval
    
    
}
