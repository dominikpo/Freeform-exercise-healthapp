//
//  UnterwegsViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 31.12.20.
//  Copyright © 2020 Dominik Polzer. All rights reserved.
//

import AVKit
import UIKit



class UnterwegsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videos = createArray()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Functions
    
    func createArray() -> [Video] {
        var tempArray: [Video] = []
        
        let video1 = Video(title: "Adler stehend", description: "Der Adler im stehen stärkt die obere Rückenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung tainiert: Trapezmuskel, großer Rautenmuskel, kleiner Rautenmuskel, Schulterblattheber, Kopfnicker und vorderer Sägemuskel", category: "Unterwegs")
        let video2 = Video(title: "Beckenkippen", description: "Mit dem Becken Kippen schulen Sie die Beckenkoordination, die für eine gute Körperhaltung unabdingbar ist. Diese Übung trainiert die Muskulatur des unteren Rückens sowie die untere Bauchmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Rückenstrecker und der gerade Bauchmuskel", category: "Unterwegs")
        let video3 = Video(title: "Knie anheben", description: "Mit dem Knie anheben dehnen Sie die hintere Hüftmuskulatur, also das Gesäß. Folgende Muskelgruppen werden durch diese Übung trainiert: großer Gesäßmuskel.", category: "Unterwegs")
        let video4 = Video(title: "Marschieren", description: "Das Marschieren eignet sich auch gut als Warm-up vor dem Training, denn es beansprucht und trainiert viele Muskelgruppen. Das Marschieren trainiert den breiten Rückenmuskel, die Gesäß und Wadenmuskulatur. Folgende Muskelgruppen werden mit dieser Pbung trainiert: großer Rückenmuskel, großer Gesäßmuskel, Zwillingswadenmuskel, zweiköpfiger Oberschenkelmuskel, vierköpfiger Oberschenkelmuskel, schräger Bauchmuskel, großer Bauchmuskel und den Deltamuskel", category: "Unterwegs")
        let video5 = Video(title: "Rückenstrecken", description: "Das Rückenstrecken dient dem Training der Rückenstreckermuskulatur entlang der Wirbelsäule. Folgende Muskelgruppen werden durch diese Übung trainiert: Rückenstrecker", category: "Unterwegs")
        let video6 = Video(title: "Rumpfdehnung", description: "Mit dieser Übung dehnen Sie den seitlichen Rumpf. Die Rumpfdehnung wirkt auf die so genannte laterale Kette bestehend aus Schenkelbindenspanner, Lendenmuskel und breiten Rückenmuskel. Folgende Muskelgruppen werden mit dieser Übung trainiert: quadratischer Lendenmuskel, Schenkelbindenspanner und den Rückenmuskel.", category: "Unterwegs")
        let video7 = Video(title: "Über Kreuz", description: "Das Kreuz dient zum einen der Mobiliserung der Wirbelsäule und zum anderen der Dehnung der Rumpfmuskulatur. Gedehnt werden vor allem das Gesäß, der breite Rückenmuskel, sowie die schräge Bauchmuskulatur und der Brustmuskulatur. Folgende Muskelgruppen werden durch diese Übung trainiert: großer Gesäßmuskel, schräge Bauchmuskeln, breite Rückenmuskeln und Brustmuskeln", category: "Unterwegs")
        
        tempArray.append(video1)
        tempArray.append(video2)
        tempArray.append(video3)
        tempArray.append(video4)
        tempArray.append(video5)
        tempArray.append(video6)
        tempArray.append(video7)
        
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


// MARK: - Extension

extension UnterwegsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "unterwegs", sender: nil)
    }
}

extension UnterwegsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Unterwgs") as! VideoCell
        
        cell.setVideo(video: video)
        return cell
    }
}
