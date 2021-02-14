//
//  VideoListViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 10.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit
import CoreData

class VideoListViewController: UIViewController {
    
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var videoArray: [Video] = []
    var customWorkoutFolder: CustomWorkout?
    var videosToSave: [CustomVideo] = []
    
    
    
    var managedObjectContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        titelLabel.text = "Video List"
        videoArray = createVideoArray()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videosToSave.removeAll()
    }
    
    
    func createVideoArray() -> [Video] {
        
        var tempArray: [Video] = []
        
        let video1 = Video(title: "Adler liegend", description: "Der Adler im stehen stärkt die obere Rückenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Trapezmuskel, großer Rautenmuskel, kleiner Rautenmuskel, Kopfnicker und den vorderen Sägemuskel", category: "Zuhause")
        let video2 = Video(title: "Beinheben Bauchlage", description: "Für das Beinheben in Bauchlage benötigen Sie eine Gymnastikmatte oder eine weiche Unterlage. Diese Übung trainiert die untere Rückenmuskulatur und die Gesäßmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Gerader Bauchmuskel und der Rückenstrecker", category: "Zuhause")
        let video3 = Video(title: "Dehnung Nacken", description: "Mit dieser Übung dehnen Sie die Hals und Nackenmuskulatur. Gedehnt wird der obere Teil des Trapezmuskels sowie der so genannte Kopfdreher, Folgende Muskelgruppen werden mit dieser Übung gedehnt: Trapezmuskel und der Kopfwender", category: "Zuhause")
        let video4 = Video(title: "Katzenbuckel kniend", description: "Für den knieenden Katzenbuckel brauchen Sie eine weiche Unterlage oder eine Gymnastikmatte. Die Übungsabfolge dient der Mobilisierung der Wirbelsäule, sowie der Kräftigung und Dehnung des Rückenstreckers. Folgende Muskelgruppen werden mit dieser Übung trainiert: Rückenstrecker", category: "Zuhause")
        let video5 = Video(title: "Rücken einrollen", description: "Für das Rücken einrollen brauchen Sie eine weiche Unterlage oder eine Gymnastikmatte. Diese Übung dient der Mobilisation der Wirbelsäule durch eine Dehnung der Rückenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Rückenstrecker, Rückenmuskel und der Trapezmuskel", category: "Zuhause")
        let video6 = Video(title: "Rückendehnen am Stuhl", description: "Für die Übung Rückendehnen am Stuhl benötigen Sie einen stabilen Stuhl. Diese Übung dehnt die breiten Rückenmuskeln, die Rückenstrecker und die so genannten Kapuzenmuskeln. Folgende Muskelgruppen werden durch diese Übung trainiert: Trapzmuskel, Rückenmuskel und der Rückenstrecker", category: "Zuhause")
        let video7 = Video(title: "Vierfüßlerstand", description: "Für den Vierfüßlerstand brauchen Sie eine weiche Unterlage oder eine Gymnastikmatte. Die Übung dient der Stärkung der Rückenmuskulatur und des Gesäßes. Außerdem fördert diese Übung die Rumpfstabilität. Folgende Muskelgruppen werden durch diese Übung trainiert: Rückenstrecker, Trapezmuskel, Rückenmuskel, großer Gesäßmuskel, gerader Bauchmuskel, innerer schräger Bauchmuskel und der äußere schräge Bauchmuskel", category: "Zuhause")
        let video8 = Video(title: "Wirbelsäulenmobilisation", description: "Für diese Übung benötigen Sie eine weiche Unterlage oder eine Gymnastikmatte. Diese Übung dient vor allem der Mobilisation der Brust-Wirbelsäule", category: "Zuhause" )
        let video9 = Video(title: "Adler stehend", description: "Der Adler im stehen stärkt die obere Rückenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung tainiert: Trapezmuskel, großer Rautenmuskel, kleiner Rautenmuskel, Schulterblattheber, Kopfnicker und vorderer Sägemuskel", category: "Unterwegs")
        let video10 = Video(title: "Beckenkippen", description: "Mit dem Becken Kippen schulen Sie die Beckenkoordination, die für eine gute Körperhaltung unabdingbar ist. Diese Übung trainiert die Muskulatur des unteren Rückens sowie die untere Bauchmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Rückenstrecker und der gerade Bauchmuskel", category: "Unterwegs")
        let video11 = Video(title: "Knie anheben", description: "Mit dem Knie anheben dehnen Sie die hintere Hüftmuskulatur, also das Gesäß. Folgende Muskelgruppen werden durch diese Übung trainiert: großer Gesäßmuskel.", category: "Unterwegs")
        let video12 = Video(title: "Marschieren", description: "Das Marschieren eignet sich auch gut als Warm-up vor dem Training, denn es beansprucht und trainiert viele Muskelgruppen. Das Marschieren trainiert den breiten Rückenmuskel, die Gesäß und Wadenmuskulatur. Folgende Muskelgruppen werden mit dieser Pbung trainiert: großer Rückenmuskel, großer Gesäßmuskel, Zwillingswadenmuskel, zweiköpfiger Oberschenkelmuskel, vierköpfiger Oberschenkelmuskel, schräger Bauchmuskel, großer Bauchmuskel und den Deltamuskel", category: "Unterwegs")
        let video13 = Video(title: "Rückenstrecken", description: "Das Rückenstrecken dient dem Training der Rückenstreckermuskulatur entlang der Wirbelsäule. Folgende Muskelgruppen werden durch diese Übung trainiert: Rückenstrecker", category: "Unterwegs")
        let video14 = Video(title: "Rumpfdehnung", description: "Mit dieser Übung dehnen Sie den seitlichen Rumpf. Die Rumpfdehnung wirkt auf die so genannte laterale Kette bestehend aus Schenkelbindenspanner, Lendenmuskel und breiten Rückenmuskel. Folgende Muskelgruppen werden mit dieser Übung trainiert: quadratischer Lendenmuskel, Schenkelbindenspanner und den Rückenmuskel.", category: "Unterwegs")
        let video15 = Video(title: "Über Kreuz", description: "Das Kreuz dient zum einen der Mobiliserung der Wirbelsäule und zum anderen der Dehnung der Rumpfmuskulatur. Gedehnt werden vor allem das Gesäß, der breite Rückenmuskel, sowie die schräge Bauchmuskulatur und der Brustmuskulatur. Folgende Muskelgruppen werden durch diese Übung trainiert: großer Gesäßmuskel, schräge Bauchmuskeln, breite Rückenmuskeln und Brustmuskeln", category: "Unterwegs")
        let video16 = Video(title: "Drehsitz", description: "Der Drehsitz ist ein richtifer Allrounder. Sie benötigen nur einen Stuhl. Die Übung dient zum einen der Mobilisation der Wirbelsäule und dehnt außerdem den Großteil der Rumpfmuskulatur. Angefangen vom Gesäß, über den breiten Rückenmuskel und die schräge Bauchmuskulatur bis hin zum Brustmuskel. Folgende Muskelgruppen werden mit dieser Pbung trainiert: großer Gesäßmuskel, schräge Bauchmuskel, Rückenmuskel und großer Brustmuskel.", category: "Büro")
        let video17 = Video(title: "Beinheben", description: "Für das Beinheben benötigen Sie einen Stuhl den man am besten seitlich umfassen kann. Diese Übung dient der Stärkung der Bauchmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: gerader Bauchmuskel", category: "Büro")
        let video18 = Video(title: "Brustdehnung", description: "Für die Brustdehnung stellen Sie sich an eine Wand, in einem Türrahmenoder an einem ähnlichen Widerstand. Die Übung dehnt den großen Brustmuskel und öffnet somit den Brustkorb. Folgende Muskelgruppen werden mit dieser Übung trainiert: größerer Brustmuskel. ", category: "Büro")
        let video19 = Video(title: "Nackendrehen", description: "Das Nacken drehen können Sie stehend oder sitzend ausführen. Diese Übung dient in erster Linie der Mobilisation der Halswirbelsäule und löst Verspannungen in der Halsnackenmuskulatur. Folgende Muskelgruppen werden mit dieser Übung trainiert: Halbdornmuskel der Brust, Riemenmuskel, langer Halsmuskel.", category: "Büro")
        let video20 = Video(title: "Kopfnicken", description: "Das Kopfnicken können Sie stehend oder sitzend ausführen. Diese Übung dient in erster Linie der Mobilisierung der Halswirbelsäule und hilft Verspannungen in der Halsnackenmuskulatur zu lösen. Folgende Muskelgruppen werden mit dieser Übung trainiert: Halbdornmuskel der Brust, Riemenmuskel, langer Halsmuskel", category: "Büro")
        
        
        
        tempArray.append(video1)
        tempArray.append(video2)
        tempArray.append(video3)
        tempArray.append(video4)
        tempArray.append(video5)
        tempArray.append(video6)
        tempArray.append(video7)
        tempArray.append(video8)
        tempArray.append(video9)
        tempArray.append(video10)
        tempArray.append(video11)
        tempArray.append(video12)
        tempArray.append(video13)
        tempArray.append(video14)
        tempArray.append(video15)
        tempArray.append(video16)
        tempArray.append(video17)
        tempArray.append(video18)
        tempArray.append(video19)
        tempArray.append(video20)
        
        return tempArray
    }
    
    
    @IBAction func saveCustomWorkout(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add a new Workout", message: "Name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                print("There was an error by createing the custom folder with that name")
                return
            }
            
            let newFolder = CustomWorkout(context: self.managedObjectContext)
            newFolder.title = nameToSave
            
            for video in self.videosToSave {
                newFolder.addToVideo(video)
            }
            
            do{
                try self.managedObjectContext.save()
            }catch let error as NSError {
                print("Ups!! Something went wrong. \(error), \(error.userInfo)")
            }
            
            
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

// MARK: - Extensions

extension VideoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let saveButton = UITableViewRowAction(style: .normal, title: "Save") { (_, indexPath) in
            let newCustomVideo = CustomVideo(context: self.managedObjectContext)
            newCustomVideo.title = self.videoArray[indexPath.row].title
            newCustomVideo.beschreibung = self.videoArray[indexPath.row].description
            newCustomVideo.category = self.videoArray[indexPath.row].category
            
            if !self.videosToSave.contains(where: {($0.title == newCustomVideo.title)}){
                self.videosToSave.append(newCustomVideo)
            }else {
                let alert = UIAlertController(title: "Error", message: "Video is allready added in the playlist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                self.present(alert, animated: true)
            }
        }
        return [saveButton]
    }
}

extension VideoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = videoArray[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
