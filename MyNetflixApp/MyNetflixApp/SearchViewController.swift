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
        // - 목표: searchTerm을 가지고 네트워킹을 통해서 영화 검색
        // - 검색API가 필요
        // - 검색에 대한 결과를 받아올 모델 Movie, Response
        // - 결과를 받아와서, CollectionView로 표현해주자
        
        SearchAPI.search(searchTerm) { movies in
            // collectionView로 표현하기
            print("---> 몇 개 넘어왔어?? \(movies.count), 첫 번째 것 제목:  \(movies.first?.title)")
        }
        
        print("---> 검색어: \(searchTerm)")
        
    }
}

class SearchAPI {
    static func search(_ term: String, completion: @escaping ([Movie]) -> Void) { // @escaping: completion 코드블럭이 메소드 바깥에서 실행될 수도 있다. 를 나타낸다.
        let session = URLSession(configuration: .default)
        // url
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: term)
        
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        let requestURL = urlComponents.url!
        
        let dataTask = session.dataTask(with: requestURL) { data, response, error in
            let successRange = 200..<300
            
            // 에러가 있는지 없는지
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
                completion([])
                return
            }
            guard let resultData = data else {
                completion([])
                return
            }
            // data -> [Movie] parsing 해야함.
            let movies = SearchAPI.parseMovies(resultData)
            completion(movies)
        }
        dataTask.resume()
    }
    
    static func parseMovies(_ data: Data) -> [Movie] {
        let decoder = JSONDecoder()
        
        do {
            let response = try decoder.decode(Response.self, from: data)
            let movies = response.movies
            return movies
        } catch let error {
            print("---> parsing error: \(error.localizedDescription)")
            return []
        }
    }
}

struct Response: Codable {
    let resultCount: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case movies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let director: String
    let thumbnailPath: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case director = "artistName"
        case thumbnailPath = "artworkUrl100"
        case previewURL = "previewUrl"
    }
}
