//
//  PBViewController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/9/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class PBViewController : UIViewController {
    
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = GlobalVariables.grayColor
        self.navigationController?.isNavigationBarHidden = true
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.black
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
