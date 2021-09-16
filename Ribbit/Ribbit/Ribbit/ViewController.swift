//
//  ViewController.swift
//  Ribbit
//
//  Created by Anya Westby on 9/8/21.
//

import UIKit

class ViewController: UIViewController {

    
   
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var hideButton: UIButton!

    @IBOutlet weak var Button2Hide: UIButton!
    
    @IBOutlet weak var LeapFrog: UIImageView!
    
    @IBAction func PlayGame(_ sender: UIButton) {
        if sender.tag == 1{
            mainImage.isHidden = true
            hideButton.isHidden = true
            mainImage.image = UIImage(named: "lilypad")
            mainImage.isHidden = false
            Button2Hide.isHidden = false
        }
    }
    
   
    @IBAction func LeapButton(_ sender: UIButton) {
            if sender.tag == 2{
                LeapFrog.isHidden = false
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        

}

