//
//  ViewController.swift
//  Fresh Stank
//
//  Created by Anya Westby on 9/21/21.
//

import UIKit

class ViewController: UIViewController {

    //Text that says 'Welcome' when app loads
    @IBOutlet weak var WelcomeText: UILabel!
    //Text that says 'to' when app loads
    @IBOutlet weak var toText: UILabel!
    //Big image of Tom that pops up when app loads
    @IBOutlet weak var welcomeTom: UIImageView!
    //Text that says 'Stank Fresh' when app loads
    @IBOutlet weak var stankFreshText: UILabel!
    //Text that says 'begin' on the button when app loads
    @IBOutlet weak var beginText: UIButton!
    //Small Tom image in left hand corner
    @IBOutlet weak var cornerTom: UIImageView!
    //Text that says 'Your Fridge' at top of screen
    @IBOutlet weak var yourFridgeText: UILabel!
    //Text telling user their fridge is empty
    @IBOutlet weak var emptyText: UILabel!
    //Text that says 'add new veggie' on button
    @IBOutlet weak var newVeggieText: UIButton!
    
    @IBOutlet weak var veggiePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cornerTom.isHidden = true
        yourFridgeText.isHidden = true
        emptyText.isHidden = true
        newVeggieText.isHidden = true
        
    }
    
    //This function will hide all of the welcoming text once the user presses 'begin'
    @IBAction func beginButton(_ sender: UIButton) {
        if sender.tag == 1{
            WelcomeText.isHidden = true
            toText.isHidden = true
            welcomeTom.isHidden = true
            stankFreshText.isHidden = true
            beginText.isHidden = true
            
            //display next "screen"
            cornerTom.isHidden = false
            yourFridgeText.isHidden = false
            emptyText.isHidden = false
            newVeggieText.isHidden = false
            
        }
    }
    
    
    @IBAction func addNewVeggie(_ sender: UIButton) {
        if sender.tag == 1{
            emptyText.isHidden = true
            newVeggieText.isHidden = true
            
            
        }
    }
    


}

