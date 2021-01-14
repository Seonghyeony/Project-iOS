import UIKit


// URLSession

// 1. URLSessionConfiguration
// 2. URLSession
// 3. URLSessionTask 를 이용해서 서버와 네트워킹

// URLSessionTask

// - dataTask
// - uploadTask
// - downloadTask

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

// URL Components
var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
let mediaQuery = URLQueryItem(name: "media", value: "music")
let entityQuery = URLQueryItem(name: "entity", value: "song")
let termQuery = URLQueryItem(name: "term", value: "지드래곤")

urlComponents.queryItems?.append(mediaQuery)
urlComponents.queryItems?.append(entityQuery)
urlComponents.queryItems?.append(termQuery)
let requestURL = urlComponents.url!


/**
 Codable을 이용해서 쉽게 JSON 파일을 Struct로 만들어 낼 수 있다.
 하지만 회사에서는 처음부터 request, response 규칙을 만들어서 더 쉽게 만들 수 있다.
 */
struct Response: Codable {
    let resultCount: Int
    let tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case tracks = "results"
    }
}

struct Track: Codable {
    // 이런 것들은 실제 회사에서는 딱 필요한 데이터만 JSON으로 내려준다.
    let title: String
    let artistName: String
    let thumbnailPath: String
    
    enum CodingKeys: String, CodingKey {    // CodingKey를 통해서 연결 가능.
        case title = "trackName"
        case artistName
        case thumbnailPath = "artworkUrl100"
    }
    
}




let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
    guard error == nil else { return }
    
    guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
    let successRange = 200..<300
    
    guard successRange.contains(statusCode) else {
        // handle response error
        return
    }
    
    guard let resultData = data else { return } // JSON 형태 파일
    let resultString = String(data: resultData, encoding: .utf8)
    
    /** 목표: 트랙 리스트 오브젝트로 가져오기 */
    
    // Response 받는 데이터 결과를 Parsing해서 오브젝트로 만드는 것.
    
    // 목록
    // - Data -> Track 목록으로 가져오고 싶다. [Track]
    // - Track 오브젝트를 만들어야겠다.
    // - Data에서 Struct로 파싱하고 싶다. > Codable 이용해서 만들자
    //      - JSON 파일, 데이터 > 오브젝트 (Codable 이용하겠다.)
    //      - Response, Track 이렇게 두 개 만들어야겠다.
    
    // 해야할 일
    // - Response, Track  struct
    // - Struct의 프로퍼티 이름과 실제 데이터의 키와 맞추기 (Codable 디코딩하게 하기 위해)
    // - 파싱하기 (Decoding)
    // - 트랙 리스트 가져오기
    
    
    // 파싱 및 트랙 가져오기
    do {
        let decoder = JSONDecoder()
        let response = try decoder.decode(Response.self, from: resultData)
        let tracks = response.tracks
        
        print("---> tracks: \(tracks.count)  - tracks: \(tracks.first?.title), \(tracks.first?.thumbnailPath)")
    } catch let error {
        print("---> error: \(error.localizedDescription)")
    }
    
    
    
//    print("---> resultData: \(resultString)")
}

// dataTask 실행하면 실제 네트워킹이 된다.
dataTask.resume()
