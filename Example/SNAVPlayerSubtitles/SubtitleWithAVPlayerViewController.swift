//
//  SubtitleWithAVPlayerViewController.swift
//  SNAVPlayerSubtitles_Example
//
//  Created by SWAGAT NAYAK on 14/03/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import AVKit
import SNAVPlayerSubtitles


class SubtitleWithAVPlayerViewController: UIViewController, AVPlayerViewControllerDelegate {

    
    // MARK: - IB Outlets
    // ---------------------------------------
    @IBOutlet weak var playUsingDefaultUrlBTN: UIButton!{
        didSet{
            self.playUsingDefaultUrlBTN.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var playUsingInputUrlBTN: UIButton!{
        didSet{
            self.playUsingInputUrlBTN.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var subtitleInputField: UITextField!
    
    
    // MARK: - Local variables
    // ---------------------------------------
    var playerViewController: AVPlayerViewController?

    
    
    // MARK: - Helper Methods
    // ---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Do any additional setup after loading the view.
        

    }
    
    
    // MARK: - IB Actions
    // ---------------------------------------
    @IBAction func onBackBtnPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playUsingDefaultUrlBTNPressed(_ sender: UIButton) {
        
        // MARK: - Enter media url here here
        guard let url = URL(string: "http://demo.unified-streaming.com/video/tears-of-steel/tears-of-steel.ism/.m3u8") else {
            return
        }

        let player = AVPlayer(url: url)
        self.playerViewController = AVPlayerViewController()
        self.playerViewController?.player = player
        self.playerViewController?.delegate = self
        self.playerViewController?.player?.play()
        
        // MARK: - Enter subtitle url here here (srt or vtt)
        self.playerViewController?.addSubtitles().open(fileFromRemote: URL(string: "https://raw.githubusercontent.com/swagatnayak/SNAVPlayerSubtitles/master/SNAVPlayerSubtitlesSample")!)
        
        self.present(playerViewController!, animated: true, completion: nil)
        
    }
    
    
    @IBAction func playUsingInputUrlBTNPressed(_ sender: UIButton) {
        
        if self.subtitleInputField.text == "" {
            showToast(message: "URL Required")
        }
    }
    
    
    func showToast(message : String) {

        
        let toastLabel = UILabel(frame: CGRect(x: 10, y: self.view.frame.size.height-100, width: UIScreen.main.bounds.width-20, height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2, delay: 2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}
