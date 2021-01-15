//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

/**
 searchBar에 대한 일을 SearchViewController에게 위임 시켜서 동작하게 한다. (Delegate)
 */
extension SearchViewController: UISearchBarDelegate {
    
    private func dismissKeyboard() {
        // search 버튼을 누르면 이제 더이상 FirstReponder가 아니라고 알려주는 메서드.
        // FirstResponder에서 사임해라.
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색 시작
        // 키보드가 올라와 있을 때, 내려가게 처리(검색을 눌렀을 때.)
        dismissKeyboard()
        
        // 검색어가 있는지
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
        
        
        // 네트워킹을 통한 검색
        
        print("---> 검색어: \(searchTerm)")
        
    }
}
