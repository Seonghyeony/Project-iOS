//
//  Extension+AVPlayerItem.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import AVFoundation
import UIKit

/**
 Stored Property를 추가할 수 없다!
 
 extension으로는 메소드나 Computed Property만 추가할 수 있다.
 */
extension AVPlayerItem {
    func convertToTrack() -> Track? {
        let metadatList = asset.metadata    // AVPlayerItem의 asset 프로퍼티. 음원의 메타데이터가 있다. 타이틀, 썸네일.. 등등.을 가져올 수 있다.
        
        var trackTitle: String?
        var trackArtist: String?
        var trackAlbumName: String?
        var trackArtwork: UIImage?
        
        for metadata in metadatList {
            if let title = metadata.title {
                trackTitle = title
            }
            
            if let artist = metadata.artist {
               trackArtist = artist
            }
            
            if let albumName = metadata.albumName {
                trackAlbumName = albumName
            }
            
            if let artwork = metadata.artwork {
                trackArtwork = artwork
            }
        }
        
        guard let title = trackTitle,
            let artist = trackArtist,
            let albumName = trackAlbumName,
            let artwork = trackArtwork else {
                return nil
        }
        return Track(title: title, artist: artist, albumName: albumName, artwork: artwork)
    }
}
 
extension AVMetadataItem {
    // asset 프로퍼티 안에있는 Metadata에서 title과 artist 등 정보를 어떻게 빼오는지 구현!
    // 실제로 서버에서 가지고 오는 데이터들은 밑의 정보들이 다 포함되어 있다.
    var title: String? {
        guard let key = commonKey?.rawValue, key == "title" else {
            return nil
        }
        return stringValue
    }
    
    var artist: String? {
        guard let key = commonKey?.rawValue, key == "artist" else {
            return nil
        }
        return stringValue
    }
    
    var albumName: String? {
        guard let key = commonKey?.rawValue, key == "albumName" else {
            return nil
        }
        return stringValue
    }
    
    var artwork: UIImage? {
        guard let key = commonKey?.rawValue, key == "artwork", let data = dataValue, let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}

extension AVPlayer {
    // 실제 AVPlayer가 재생되고 있나 아닌가 확인하는 프로퍼티를 만들어서 확장시켰다.
    var isPlaying: Bool {
        guard self.currentItem != nil else { return false }
        return self.rate != 0
    }
}
