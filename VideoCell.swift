//
//  VideoCell.swift
//  health_app
//
//  Created by Dominik Polzer on 31.12.20.
//  Copyright © 2020 Dominik Polzer. All rights reserved.
//

import UIKit

// Custom Prototype Cell
class VideoCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func setVideo(video: Video){
        titleLabel.text = video.title
    }
}
