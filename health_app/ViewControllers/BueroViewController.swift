//
//  BueroViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 02.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit

class BueroViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videos = createArray()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
    func createArray() -> [Video] {
        
        var tempArray: [Video] = []
        
        let video1 = Video(title: "Drehsitz", description: "Der Drehsitz ist ein richtifer Allrounder. Sie benötigen nur einen Stuhl. Die Übung dient zum einen der Mobilisation der Wirbelsäule und dehnt außerdem den Großteil der Rumpfmuskulatur. Angefangen vom Gesäß, über den breiten Rückenmuskel und die schräge Bauchmuskulatur bis hin zum Brustmuskel. Folgende Muskelgruppen werden mit dieser Pbung trainiert: großer Gesäßmuskel, schräge Bauchmuskel, Rückenmuskel und großer Brustmuskel.", category: "Büro")
        let video2 = Video(title: "Beinheben", description: "Für das Beinheben benötigen Sie einen Stuhl den man am besten seitlich umfassen kann. Diese Übung dient der Stärkung der Bauchmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: gerader Bauchmuskel", category: "Büro")
        let video3 = Video(title: "Brustdehnung", description: "Für die Brustdehnung stellen Sie sich an eine Wand, in einem Türrahmenoder an einem ähnlichen Widerstand. Die Übung dehnt den großen Brustmuskel und öffnet somit den Brustkorb. Folgende Muskelgruppen werden mit dieser Übung trainiert: größerer Brustmuskel. ", category: "Büro")
        let video4 = Video(title: "Nackendrehen", description: "Das Nacken drehen können Sie stehend oder sitzend ausführen. Diese Übung dient in erster Linie der Mobilisation der Halswirbelsäule und löst Verspannungen in der Halsnackenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Halbdornmuskel der Brust, Riemenmuskel, langer Halsmuskel.", category: "Büro")
        let video5 = Video(title: "Kopfnicken", description: "Das Kopfnicken können Sie stehend oder sitzend ausführen. Diese Übung dient in erster Linie der Mobilisierung der Halswirbelsäule und hilft Verspannungen in der Halsnackenmuskulatur zu lösen. Folgende Muskelgruppen werden mit dieser Übung trainiert: Halbdornmuskel der Brust, Riemenmuskel, langer Halsmuskel", category: "Büro")
        let video6 = Video(title: "Adler stehend", description: "Der Adler im stehen stärkt die obere Rückenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung tainiert: Trapezmuskel, großer Rautenmuskel, kleiner Rautenmuskel, Schulterblattheber, Kopfnicker und vorderer Sägemuskel", category: "Büro")
        let video7 = Video(title: "Rückendehnen am Stuhl", description: "Für die Übung Rückendehnen am Stuhl benötigen Sie einen stabilen Stuhl. Diese Übung dehnt die breiten Rückenmuskeln, die Rückenstrecker und die so genannten Kapuzenmuskeln. Folgende Muskelgruppen werden durch diese Übung trainiert: Trapzmuskel, Rückenmuskel und der Rückenstrecker", category: "Büro")
        
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


// MARK: - EXTENSION

extension BueroViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "buero", sender: nil)
    }
}

extension BueroViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Buero") as! VideoCell
        
        cell.setVideo(video: video)
        return cell
    }
}
