//
//  ViewController.swift
//  Blackboard 3LO
//
//  Created by Scott Hurrey on 8/18/17.
//  Copyright © 2017 Blackboard Developer Community. All rights reserved.
//

import UIKit
import Alamofire.Swift

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Blackboard3LOManager.sharedInstance.startOAuth2Login()
        
    }
    
    @IBAction func authenticate(_ sender: Any) {
        
        let rvc = self.storyboard?.instantiateViewController(withIdentifier: "ResultTableViewController") as! ResultTableViewController
        
        print("call present")
        self.present(rvc,
                     animated: true,
                     completion: nil)
        
    }
    
}
