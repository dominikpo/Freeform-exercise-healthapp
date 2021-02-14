//
//  SavedWorkoutViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 12.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit

class SavedWorkoutViewController: UIViewController {
    
    @IBOutlet weak var workoutTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var workout: CustomWorkout!
    var videoTitel: [String] = []
    var videoBeschreibung: [String] = []
    var videoCategory: [String] = []
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        workoutTitle.text = workout.title
        getVideo()
        
      
    }
    
    
    private func getVideo() {
        
        if let video = workout.video {
            
            let customVideoTitle = video.map { (video) -> String in
                let video = video as! CustomVideo
                return video.title!
            }
            
            let customVideoBeschreibung = video.map { (video) -> String in
                let beschreibung = video as! CustomVideo
                return beschreibung.beschreibung!
            }
            
            let customVideoCategory = video.map { (video) -> String in
                let category = video as! CustomVideo
                return category.category!
            }
            
            
            videoTitel.append(contentsOf: customVideoTitle)
            videoBeschreibung.append(contentsOf: customVideoBeschreibung)
            videoCategory.append(contentsOf: customVideoCategory)
            print(videoCategory)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? CustomVideoDetailViewController, let index = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        vc.customVideoTitel = videoTitel[index]
        vc.customVideoBeschreibung = videoBeschreibung[index]
        vc.customVideoCategory = videoCategory[index]
    }
    
    
    
}


// MARK: - Extension

extension SavedWorkoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "customVideoDetail", sender: nil)
    }
}

extension SavedWorkoutViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = workout.video?.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedVideoCell", for: indexPath)
        cell.textLabel?.text = videoTitel[indexPath.row]
     
        return cell
    }
}
