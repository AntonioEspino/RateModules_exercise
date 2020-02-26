//
//  ResultsViewController.swift
//  RateModules
//
//  Created by user164220 on 25/02/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    static var results: [Result]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let results = ResultsViewController.results else {
            return 0
        }
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as! ResultViewCell
        
        guard let results = ResultsViewController.results else {
            return cell
        }
        
        cell.configure(result: results[indexPath.row])
        
        return cell
    }
    
    func showEditing(sender: UIBarButtonItem) {
        if(self.tableView.isEditing == true) {
            self.tableView.isEditing = false
            self.navigationItem.rightBarButtonItem?.title = "Done"
        } else {
            self.tableView.isEditing = true
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Choose option", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.updateStudents(indexPath.row)
                ResultsViewController.results?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func updateStudents(_ student: Int) {
        var listStudentsResult: [Result] = Result.loadFromFile()
        listStudentsResult.remove(at: student)
        Result.saveToFile(results: listStudentsResult)
    }
    
}
