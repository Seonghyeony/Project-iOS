//
//  SearchViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/02.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
import FirebaseDatabase

class SearchViewController: UIViewController {
    
    let db = Database.database().reference().child("searchHistory")

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    // MVVM 패턴에서는 벗어나는 문법
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    // 몇 개 넘어오니?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    // 어떻게 표현할거니?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell else {
            return UICollectionViewCell()
        }
        
        let movie = movies[indexPath.item]
        let url = URL(string: movie.thumbnailPath)!
        // imagePath(String) -> image
        // 외부 코드(오픈소스) 가져다쓰기. 방법들. SPM(Swift Package Manager), Cocoa Pod, Carthage
        cell.movieThumbnail.kf.setImage(with: url)  // kf: 오픈소스
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    // 클릭 시 어떻게 할 거냐
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // movie
        // player vc
        // player vc + movie
        // presenting player vc
        
        
        let movie = movies[indexPath.item]
        // AVPlayer의 playerItem 셋팅
        let url = URL(string: movie.previewURL)!
        let item = AVPlayerItem(url: url)
        
        let sb = UIStoryboard(name: "Player", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "PlayerViewController") as! PlayerViewController
        vc.modalPresentationStyle = .fullScreen // modal style 변경.
        
        // 아이템 셋팅
        vc.player.replaceCurrentItem(with: item)
        present(vc, animated: false, completion: nil)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    // 사이즈 어떻게 할 거냐
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 8
        let itemSpacing: CGFloat = 10
        
        let width = (collectionView.bounds.width - margin * 2 - itemSpacing * 2) / 3
        let height = width * 10 / 7
        return CGSize(width: width, height: height)
    }
}

class ResultCell: UICollectionViewCell {
    @IBOutlet weak var movieThumbnail: UIImageView!
    
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
        // - [o] 검색API가 필요
        // - [o] 검색에 대한 결과를 받아올 모델 Movie, Response
        // - [o] 결과를 받아와서, CollectionView로 표현해주자
        
        // 이것은 네트워크 스레드라서 많이 느리다.
        SearchAPI.search(searchTerm) { movies in
            // [o] collectionView로 표현하기
            print("---> 몇 개 넘어왔어?? \(movies.count), 첫 번째 것 제목:  \(movies.first?.title)")
            
            // 네트워크는 느린 녀석이다. 그래서 UI 쪽 메서드는 메인 스레드에서 해야 한다.
            DispatchQueue.main.async {
                self.movies = movies
                self.resultCollectionView.reloadData()
                
                // Firebase에 검색 History 저장.
                let timestamp: Double = Date().timeIntervalSince1970.rounded()  // rounded(): 소수점 이하는 버림.
                self.db.childByAutoId().setValue(["term": searchTerm, "timestamp": timestamp])
            }
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
