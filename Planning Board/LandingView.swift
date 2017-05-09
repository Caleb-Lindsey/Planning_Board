//
//  LandingView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import Firebase

class LandingView : PBViewController {
    
    //Variables
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var dimmerView : UIView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.clear
        
        dimmerView.backgroundColor = UIColor.black
        dimmerView.layer.opacity = 0.5
        dimmerView.frame = view.frame
        view.addSubview(dimmerView)
        
        GlobalVariables.userName = UserDefaults.standard.value(forKey: "username") as! String
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Pull from Firebase to fill Variables
        Datasource().fillData {
            
            self.dimmerView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
        }
        
    }
    
}





























