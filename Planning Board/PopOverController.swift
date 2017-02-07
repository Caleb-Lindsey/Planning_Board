//
//  PopOverController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 1/10/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation

class PopOverController : UIViewController {
    
    var senderyeah = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func optionPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            print("Service")
            GlobalVariables.popoverChoice = "Service"
            self.dismiss(animated: true, completion: nil)
        case 1:
            print("Segment")
            GlobalVariables.popoverChoice = "Segment"
            self.dismiss(animated: true, completion: nil)
        case 2:
            print("Element")
            GlobalVariables.popoverChoice = "Element"
            self.dismiss(animated: true, completion: nil)
        default:
            print("oops")
        }
        
    }
    
    
    
}
