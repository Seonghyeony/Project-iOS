//
//  Preview.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/03.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

// AVPlayer에서 나오는 visual output을 담당하는 녀석이 AVPlayerlayer이다.
// 이거를 쓰려면 밑의 방식으로 쓰라고 document에 나와있다.
// https://developer.apple.com/documentation/avfoundation/avplayerlayer

import UIKit
import AVFoundation

class PlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
