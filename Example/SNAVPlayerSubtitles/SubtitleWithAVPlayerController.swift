//
//  SubtitleWithAVPlayerController.swift
//  SNAVPlayerSubtitles_Example
//
//  Created by SWAGAT-CDI on 15/03/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class SubtitleWithAVPlayerController: UIViewController {

    @IBOutlet weak var playWithDefaultUrlBTNAVPlayer: UIButton!{
        didSet{
            self.playWithDefaultUrlBTNAVPlayer.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var playWithUrlBTNAVPlayer: UIButton!{
        didSet{
            self.playWithUrlBTNAVPlayer.layer.cornerRadius = 12
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func backBTNPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onPlayUsingDefaultUrlPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "goToPlayer", sender: nil)
    }
}
