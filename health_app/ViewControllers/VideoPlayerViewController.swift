//
//  VideoPlayerViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 29.12.20.
//  Copyright © 2020 Dominik Polzer. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var video: Video?
    private var player: AVPlayer!
    private var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let video = video else {
            print("Sorry! Failed to load the video")
            return
        }

        playVideoInView()
        categoryLabel.text = video.category
        exerciseTitle.text = video.title
        descriptionLabel.text = video.description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func playVideoInView(){
        guard let path = Bundle.main.path(forResource: video?.title, ofType: "mp4") else {
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
