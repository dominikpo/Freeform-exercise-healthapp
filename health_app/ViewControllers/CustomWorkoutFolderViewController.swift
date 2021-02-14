//
//  CustomWorkoutViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 11.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit
import CoreData

class CustomWorkoutFolderViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var savedWorkoutFolder: [CustomWorkout] = []
    
    var managedObjectContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        titleLabel.text = "Custom Workouts"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest: NSFetchRequest = CustomWorkout.fetchRequest()
        
        do{
            savedWorkoutFolder = try managedObjectContext.fetch(fetchRequest)
        }catch let error as NSError {
            print("Ups something went wrong. \(error.userInfo), \(error)")
        }
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SavedWorkoutViewController, let index = tableView.indexPathForSelectedRow?.row else {
            return
        }
        vc.workout = savedWorkoutFolder[index]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = savedWorkoutFolder[indexPath.row]
            managedObjectContext.delete(item)
            
            do{
                try managedObjectContext.save()
                savedWorkoutFolder.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }catch let error as NSError{
                print("Sorry somehting went worng. \(error), \(error.userInfo)")
            }
        }
    }
    
}


// MARK: - Extension

extension CustomWorkoutFolderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "savedWorkout", sender: nil)
    }
}

extension CustomWorkoutFolderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWorkoutFolder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customFolder", for: indexPath)
        cell.textLabel?.text = savedWorkoutFolder[indexPath.row].title
        return cell
    }
    
}
