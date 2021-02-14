//
//  ImageViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 06.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageDuration: UILabel!
    @IBOutlet weak var imageDescription: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var image: BlackRoll?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTitle.text = image?.title
        imageDescription.text = image?.description
        imageDuration.text = image?.duration
        
        if let unwrapedGif = image {
            imageView.loadGif(name: "\(unwrapedGif.title)1")
        }else {
            print("There was an error loading the GIF")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

