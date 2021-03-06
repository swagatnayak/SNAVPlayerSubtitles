//
//  ViewController.swift
//  SNAVPlayerSubtitles
//
//  Created by swagatnayak on 03/14/2021.
//  Copyright (c) 2021 swagatnayak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    // MARK: - IB Outlets
    // ---------------------------------------
    @IBOutlet weak var playWithAVPlayerViewControllerBTN: UIButton!{
        didSet{
            self.playWithAVPlayerViewControllerBTN.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var playWithAVPlayerBTN: UIButton!{
        didSet{
            self.playWithAVPlayerBTN.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var hyperLinktext: UILabel!
    
    
    // MARK: - Helper Methods
    // ---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - IB Actions
    // ---------------------------------------
    @IBAction func onPlayWithAvplayerViewControllerPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "SubtitleWithAVPlayerViewController", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SubtitleWithAVPlayerViewControllerScreen") as! SubtitleWithAVPlayerViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func onPlayWithAvplayerPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SubtitleWithAVPlayer", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SubtitleWithAVPlayerScreen") as! SubtitleWithAVPlayerController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}

