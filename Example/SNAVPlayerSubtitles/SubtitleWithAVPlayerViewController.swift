//
//  SubtitleWithAVPlayerViewController.swift
//  SNAVPlayerSubtitles_Example
//
//  Created by SWAGAT-CDI on 14/03/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import AVKit
import SNAVPlayerSubtitles


class SubtitleWithAVPlayerViewController: UIViewController, AVPlayerViewControllerDelegate {

    
    var playerViewController: AVPlayerViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let url = URL(string: "http://demo.unified-streaming.com/video/tears-of-steel/tears-of-steel.ism/.m3u8") else {
            return
        }
        
        let player = AVPlayer(url: url)
        self.playerViewController = AVPlayerViewController()
        self.playerViewController?.player = player
        self.playerViewController?.allowsPictureInPicturePlayback = true
        self.playerViewController?.delegate = self
        self.playerViewController?.player?.play()
        

        
        self.present(playerViewController!, animated: true, completion: nil)
    }
    

}
