//
//  ZuhauseViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 24.12.20.
//  Copyright © 2020 Dominik Polzer. All rights reserved.
//


import AVKit
import UIKit


//class VideoCell: UITableViewCell {
//
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
//
//    func setVideo(video: Video){
//        titleLabel.text = video.title
//        descriptionLabel.text = video.description
//    }
//}


class ZuhauseViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewContainer: UIView!
    
    var videos: [Video] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videos = createArray()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK: - Button Actions to play all Videos (TODO)
    @IBAction func playButton(_ sender: UIButton) {
        playVideo()
    }
    
    // MARK: - Functions
    
    
    // Play all videos in an array
    private func playVideo(){
        guard let path = Bundle.main.path(forResource: "Adler liegend - Anleitung", ofType: "mp4") else {
            print("Video was not found")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true){
            player.play()
        }
    }
    
    func createArray() -> [Video] {
        
        var tempArray: [Video] = []
        
        let video1 = Video(title: "Adler liegend", description: "Der Adler im stehen stärkt die obere Rückenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Trapezmuskel, großer Rautenmuskel, kleiner Rautenmuskel, Kopfnicker und den vorderen Sägemuskel", category: "Zuhause")
        let video2 = Video(title: "Beinheben Bauchlage", description: "Für das Beinheben in Bauchlage benötigen Sie eine Gymnastikmatte oder eine weiche Unterlage. Diese Übung trainiert die untere Rückenmuskulatur und die Gesäßmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Gerader Bauchmuskel und der Rückenstrecker", category: "Zuhause")
        let video3 = Video(title: "Dehnung Nacken", description: "Mit dieser Übung dehnen Sie die Hals und Nackenmuskulatur. Gedehnt wird der obere Teil des Trapezmuskels sowie der so genannte Kopfdreher, Folgende Muskelgruppen werden mit dieser Übung gedehnt: Trapezmuskel und der Kopfwender", category: "Zuhause")
        let video4 = Video(title: "Katzenbuckel kniend", description: "Für den knieenden Katzenbuckel brauchen Sie eine weiche Unterlage oder eine Gymnastikmatte. Die Übungsabfolge dient der Mobilisierung der Wirbelsäule, sowie der Kräftigung und Dehnung des Rückenstreckers. Folgende Muskelgruppen werden mit dieser Übung trainiert: Rückenstrecker", category: "Zuhause")
        let video5 = Video(title: "Rücken einrollen", description: "Für das Rücken einrollen brauchen Sie eine weiche Unterlage oder eine Gymnastikmatte. Diese Übung dient der Mobilisation der Wirbelsäule durch eine Dehnung der Rückenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Rückenstrecker, Rückenmuskel und der Trapezmuskel", category: "Zuhause")
        let video6 = Video(title: "Rückendehnen am Stuhl", description: "Für die Übung Rückendehnen am Stuhl benötigen Sie einen stabilen Stuhl. Diese Übung dehnt die breiten Rückenmuskeln, die Rückenstrecker und die so genannten Kapuzenmuskeln. Folgende Muskelgruppen werden durch diese Übung trainiert: Trapzmuskel, Rückenmuskel und der Rückenstrecker", category: "Zuhause")
        let video7 = Video(title: "Vierfüßlerstand", description: "Für den Vierfüßlerstand brauchen Sie eine weiche Unterlage oder eine Gymnastikmatte. Die Übung dient der Stärkung der Rückenmuskulatur und des Gesäßes. Außerdem fördert diese Übung die Rumpfstabilität. Folgende Muskelgruppen werden durch diese Übung trainiert: Rückenstrecker, Trapezmuskel, Rückenmuskel, großer Gesäßmuskel, gerader Bauchmuskel, innerer schräger Bauchmuskel und der äußere schräge Bauchmuskel", category: "Zuhause")
        let video8 = Video(title: "Wirbelsäulenmobilisation", description: "Für diese Übung benötigen Sie eine weiche Unterlage oder eine Gymnastikmatte. Diese Übung dient vor allem der Mobilisation der Brust-Wirbelsäule", category: "Zuhause" )
        
        
        tempArray.append(video1)
        tempArray.append(video2)
        tempArray.append(video3)
        tempArray.append(video4)
        tempArray.append(video5)
        tempArray.append(video6)
        tempArray.append(video7)
        tempArray.append(video8)
        
        return tempArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let videoPlayerController = segue.destination as? VideoPlayerViewController, let index = tableView.indexPathForSelectedRow?.row else {
            return
        }

        videoPlayerController.video = videos[index]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}



// MARK: - EXTENSION

extension ZuhauseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "zuhause", sender: nil)
    }
}

extension ZuhauseViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        
        cell.setVideo(video: video)
        return cell
    }
}
