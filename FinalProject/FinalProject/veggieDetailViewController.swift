//
//  veggieDetailViewController.swift
//  FinalProject
//
//  Created by Anya Westby on 10/03/21.
//

import Foundation
import UIKit

class veggieDetailViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    //creates outlet for text field
    @IBOutlet weak var veggieName: UITextField!
    //creates outlet for date picker
    @IBOutlet weak var datePicker: UIDatePicker!
    //creates outlet for date shown in add screen
    @IBOutlet weak var newDateLabel: UILabel!
    
    @IBAction func datePickerUpdated(_ sender: UIDatePicker) {
        let format = DateFormatter()
        format.dateStyle = DateFormatter.Style.short
        let strDate = format.string(from: datePicker.date)
        newDateLabel.text = strDate
    }
    
    
    //makes sure that the keyboard is dismissed after the user is finsihed typing
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    //property to hold the vegetable's name
    var name: String = ""
    //propety to hold the use-by date
    var useByDate: String = "MM/DD/YYYY"
    
    //method to prepare the Segue so that the veggie name and use-by-date move into the respective properties
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = veggieName.text!
            useByDate = newDateLabel.text!
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        veggieName.delegate = self
        // Do any additional setup after loading the view.
    }
   

}


