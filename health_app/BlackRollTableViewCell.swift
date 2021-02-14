//
//  BlackRollTableViewCell.swift
//  health_app
//
//  Created by Dominik Polzer on 04.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit


// Custom Prototype Cell
class BlackRollTableViewCell: UITableViewCell {

    @IBOutlet weak var blackrollTitle: UILabel!
    
    func setImages(image: BlackRoll) {
        blackrollTitle.text = image.title
    }
}
