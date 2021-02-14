//
//  SavedRunsViewController.swift
//  health_app
//
//  Created by Dominik Polzer on 09.01.21.
//  Copyright © 2021 Dominik Polzer. All rights reserved.
//

import UIKit
import CoreData

class SavedRunsViewController: UIViewController {
    
    @IBOutlet weak var savedRunTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var savedRunsFromPast: [Run] = []
    
    var managedObjectContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        savedRunTitle.text = "Your Saved Runs"
        
        let fetchRequest:NSFetchRequest<Run> = Run.fetchRequest()
        
        do{
            savedRunsFromPast = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError{
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let savedRun = segue.destination as? DetailedRunViewController, let index = tableView.indexPathForSelectedRow?.row else {
            return
        }
        savedRun.run = savedRunsFromPast[index]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = savedRunsFromPast[indexPath.row]
            managedObjectContext.delete(item)
            do{
                try managedObjectContext.save()
                savedRunsFromPast.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }catch let error as NSError{
                print("Sorry somehting went worng. \(error), \(error.userInfo)")
            }
        }
    }
}

// MARK: - Extension

extension SavedRunsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "savedDetails", sender: nil)
    }
}

extension SavedRunsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRunsFromPast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "save", for: indexPath)

        let formatedDate = FormatDisplay.date(savedRunsFromPast[indexPath.row].timestamp)
        cell.textLabel?.text = formatedDate
        return cell
    }
}
