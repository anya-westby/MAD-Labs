//
//  ViewController.swift
//  Tip Calculator New
//
//  Created by Anya Westby on 9/26/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var tempInput: UILabel!
    @IBOutlet weak var tempOutput: UILabel!
    
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var tempStepper: UIStepper!
    
    @IBAction func updateTemp(_ sender: UIStepper) {
        if tempStepper.value == 1 {
            tempInput.text = "1"
        } else {
            tempInput.text = String(format: "%.0f", tempStepper.value)
        }
        conversion()
    }
    
    func conversion(){
        let fahrenheit = tempStepper.value
        var celsius: Float = 0
       
        if fahrenheit >= 0{
            celsius = Float((fahrenheit - 32) * 5)/9
        }
        else{
            let alert = UIAlertController(title: "Warning", message: "The temperature must be greater than 0", preferredStyle: UIAlertController.Style.alert)
        
            let cancelAction = UIAlertAction(title: "Cancel", style:UIAlertAction.Style.cancel, handler: nil)
        
            alert.addAction(cancelAction) //adds the alert action to the alert object
        
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {action in
                self.tempStepper.value = 1
                self.tempInput.text? = "1"
                self.conversion()
            })
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        tempOutput.text = String(format: "%.0f", celsius)
    }
    
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        conversion()
    }
    
    override func viewDidLoad() {
        city.delegate = self
        super.viewDidLoad()
        tempInput.text = "1"
        // Do any additional setup after loading the view.
    }
        
}
