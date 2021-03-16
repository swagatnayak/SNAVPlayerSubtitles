//
//  Player.swift
//  SNAVPlayerSubtitles_Example
//
//  Created by SWAGAT-CDI on 15/03/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import AVKit

class Player: UIViewController {

    // MARK: - IB Outlets
    // ---------------------------------------
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var subtitleBTN: UIButton!{
        didSet{
            self.subtitleBTN.layer.cornerRadius = 8
        }
    }
    
    
    // MARK: - Local Variables
    // ---------------------------------------
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var isSubtitleShow: Bool = true{
        
        didSet{
            
            if self.isSubtitleShow {
                self.subtitleBTN.setTitle("Hide Subtitle", for: .normal)
                
            }else{
                self.subtitleBTN.setTitle("Show Subtitle", for: .normal)

            }
            
        }
    }
    
    
    // MARK: - Helper methods
    // ---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        guard let url = URL(string: "http://demo.unified-streaming.com/video/tears-of-steel/tears-of-steel.ism/.m3u8") else {
            return
        }
        
        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        self.playerLayer = AVPlayerLayer(player: player)

        if let playerLayer = self.playerLayer {
            
            self.playerView.layer.insertSublayer(playerLayer, at: 0)
            playerLayer.frame = self.playerView.bounds
            playerLayer.videoGravity = .resizeAspect
            
        
        }
        
        // textStyle :  defie the backgrund of subtitle
        // type : (Important) which type of subtile you passed
        self.player?.addSubtitles(view: self.playerView,textStyle: .CLEAR_BACKGROUND).open(fileFromRemote: URL(string: "https://raw.githubusercontent.com/swagatnayak/SNAVPlayerSubtitles/master/SNAVPlayerSubtitlesSample")!,type: .VTT)
        
        player?.play()
      
    }

    
    
    //MARK: - IB Actions
    @IBAction func onBackPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onCaptionBtnClicked(_ sender: UIButton) {
        
        
        if !self.isSubtitleShow {
            
            // MARK: - To show subtitle again you need to call open() again
            self.player?.addSubtitles(view: self.playerView,textStyle: .CLEAR_BACKGROUND).open(fileFromRemote: URL(string: "https://raw.githubusercontent.com/swagatnayak/SNAVPlayerSubtitles/master/SNAVPlayerSubtitlesSample")!,type: .VTT)
        }else{
        
            //MARK - Hide subtitle
            self.player?.hideSubtitle()
            
        }
        
        
        
        self.isSubtitleShow = !self.isSubtitleShow
    }
    
}
