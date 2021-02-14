//
//  BlackRollViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 04.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit

class BlackRollViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var blackrollImage: [BlackRoll] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blackrollImage = createArray()
        tableView.delegate = self
        tableView.dataSource = self
        imageView.image = #imageLiteral(resourceName: "faszienrolle")
        imageView.alpha = 0.3
    }

    func createArray() -> [BlackRoll] {
        var tempArray: [BlackRoll] = []
        
        let image1 = BlackRoll(title: "Gesäss", description: "In Sitzposition Gesäß auf Rolle platzieren und ein Bein über das andere schlagen. Mit Gesäß vor- und zurückrollen", duration: "Dauer pro Widerholung: 2 sec")
        
        let image2 = BlackRoll(title: "Wade", description: "Im Sitzen Beine überschlagen und Unterschenkel auf Rolle platzieren. Gesäß vom Boden abheben. Mit Unterschenkel langsam vor- und zurückrollen.", duration: "Dauer pro Widerholung: 2 sec")
        
        let image3 = BlackRoll(title: "Oberschenkel Rückseite", description: "In Sitzposition Beine überschlagen und Oberschenkel auf Rolle platzieren. Mit Oberschenkel langsam vor- und zurückrollen. Durch Seitneigung alle Bereiche behandeln.", duration: "Dauer pro Widerholung: 1 sec")
        
        let image4 = BlackRoll(title: "Rücken", description: "Rückenlage auf Rolle. Hände hinter dem Kopf verschränken. Entlang des Rückens langsam vor- und zurückrollen.", duration: "Dauer pro Widerholung: 1 sec")
        
        let image5 = BlackRoll(title: "Unterschenkel Aussenseite", description: "In Seitstütz unteres Bein auf Rolle platzieren. Oberes Bein vor dem Körper abstützen. Mit Unterschenkel langsam vor- und zurückrollen.", duration: "Dauer pro Widerholung: 2 sec")
        
        let image6 = BlackRoll(title: "Oberschenkel Aussenseite", description: "In Seitstütz unteres Bein auf Rolle platzieren. Oberes Bein vor dem Körper abstützen. Mit Oberschenkel langsam vor- und zurückrollen. Durch Seitneigung alle Bereiche behandeln.", duration: "Dauer pro Widerholung: 2 sec")
        
        let image7 = BlackRoll(title: "Oberschenkel Innenseite", description: "In Bauchlage Oberschenkelinnenseite eines Beines auf Rolle platzieren. Mit Oberschenkel langsam vor- und zurückrollen", duration: "Dauer pro Widerholung: 2 sec")
        
        let image8 = BlackRoll(title: "Unterschenkel Vorderseite", description: "Bankstellung mit Unterschenkel auf Rolle. Mit Unterschenkel langsam vor- und zurückrollen", duration: "Dauer pro Widerholung: 2 sec")
        
        let image9 = BlackRoll(title: "Oberschenkel Vorderseite", description: "In Unterarmstütz Oberschenkel auf Rolle platzieren. Mot Oberschenkel langsam vor- und zurückrollen. Durch Seitneigung alle Bereiche behandeln.", duration: "Dauer pro Widerholung: 1 sec")
        let image10 = BlackRoll(title: "Hüftbeuger", description: "In Bauchlage Rolle unterhalb des Beckenknochens platzieren. Anderes Bein anwinkeln. Mit Hüfte wenige Zentimeter vor- und zurückrollen.", duration: "Dauer pro Widerholung: 2 sec")
        
        let image11 = BlackRoll(title: "Seitlicher Rumpf", description: "Seitlage mit oberem Rumpf auf der Faszienrolle. Entlang des Rumpfes langsam vor- und zurückrollen", duration: "Dauer pro Widerholung: 2 sec")
        
        let image12 = BlackRoll(title: "Unterer Rücken", description: "Rückenlage auf der Massagerolle. Arme am Boden abstützen. In leichter Seitenlage entlang des unteren Rückens langsam vor- und zurückrollen", duration: "Dauer pro Widerholung: 2 sec")
        
        let image13 = BlackRoll(title: "Oberer Rücken", description: "Rückenlage auf der Blackroll. Hände hinter dem Kopf verschränken. Entlang des oberen Rückens langsam vor- und zurückrollen.", duration: "Dauer pro Widerholung: 1 sec")
        
        let image14 = BlackRoll(title: "Nacken", description: "In Rückenlage Blackroll unter Nacken platzieren. Kopf langsam nach links und rechts drehen um Nacken zu massieren", duration: "Dauer pro Widerholung: 1 sec")
        
        tempArray.append(image1)
        tempArray.append(image2)
        tempArray.append(image3)
        tempArray.append(image4)
        tempArray.append(image5)
        tempArray.append(image6)
        tempArray.append(image7)
        tempArray.append(image8)
        tempArray.append(image9)
        tempArray.append(image10)
        tempArray.append(image11)
        tempArray.append(image12)
        tempArray.append(image13)
        tempArray.append(image14)

        return tempArray
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let imageViewController = segue.destination as? ImageViewController, let index = tableView.indexPathForSelectedRow?.row else {
            return
        }
        imageViewController.image = blackrollImage[index]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension BlackRollViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "blackrollImage", sender: nil)
    }
}

extension BlackRollViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blackrollImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image = blackrollImage[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "blackroll") as! BlackRollTableViewCell
        cell.setImages(image: image)
        return cell
    }
}
