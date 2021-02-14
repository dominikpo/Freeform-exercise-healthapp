//
//  CustomVideoDetailViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 13.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit
import AVKit

class CustomVideoDetailViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var videoTitelLabel: UILabel!
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var beschreibungLabel: UILabel!
    
    var customVideoTitel: String = ""
    var customVideoBeschreibung: String = ""
    var customVideoCategory: String = ""
    
    private var player: AVPlayer!
    private var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryLabel.text = customVideoCategory
        videoTitelLabel.text = customVideoTitel
        beschreibungLabel.text = customVideoBeschreibung
        
        playVideoInView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func playVideoInView(){
        guard let path = Bundle.main.path(forResource: customVideoTitel, ofType: "mp4") else {
            print("Video can not be load")
            return
        }
        
        let url = NSURL.fileURL(withPath: path)
        // to get time
//        let asset = AVAsset(url: url)
//        let duration = asset.duration
//        let durationTime = CMTimeGetSeconds(duration)
//        let minutes = Int(durationTime/60)
//        let seconds = Int(durationTime.truncatingRemainder(dividingBy: 60))
        
        player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.view.frame.size.height = videoContainer.frame.height
        playerViewController.view.frame.size.width = videoContainer.frame.width
        self.videoContainer.addSubview(playerViewController.view)
    }
}
