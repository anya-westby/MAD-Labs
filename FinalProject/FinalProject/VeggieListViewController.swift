//
//  VeggieListViewController.swift
//  FinalProject
//
//  Created by Anya Westby on 10/03/21.
//

import Foundation
import UIKit

//creates a subclass for custom cell layout
class MyCell: UITableViewCell {
    //var to update vegetable from add screen
    @IBOutlet weak var veggieLabel: UILabel!
    //var to update use-by date from add screen
    @IBOutlet weak var dateLabel: UILabel!
    
}

class VeggieListViewController: UITableViewController {


    //variable that makes an array of all the user's vegetables
    var veggies = [String]()
    //variable to keep track of a new vegetable added
    var newVeggie: String = ""
    //variable that makes an array of all the user's use-by dates
    var dates = [String]()
    //variable to keep track of a new use-by date added
    var newDate: String = "MM/DD/YYYY"
    
    //Unwind segue for the cancel button
    @IBAction func cancel( segue:UIStoryboardSegue) {
    }
    
   
    //Unwind segue for the done button
    @IBAction func done( segue:UIStoryboardSegue){
        let veggieDetailVC = segue.source as! veggieDetailViewController
        newVeggie = veggieDetailVC.name
        newDate = veggieDetailVC.useByDate
        
        veggies.append(newVeggie)
        dates.append(newDate)
        
        tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Preserves selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        //loads green color for background
        self.tableView.backgroundColor = UIColor.systemGreen
    }
        //sets the color of all my cells to green
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = UIColor.systemGreen
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return veggies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "veggieCell", for: indexPath) as! MyCell

        // Configure the cell...
        cell.veggieLabel.text = veggies[indexPath.row]
        cell.dateLabel.text = dates[indexPath.row]

        return cell
    }

}

