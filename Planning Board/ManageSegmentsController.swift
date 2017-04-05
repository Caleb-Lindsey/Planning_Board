//
//  ManageSegmentsController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import Firebase

class ManageSegmentsController : UIViewController {
    
    let tableViews = ResourceAddition(type: "Segment")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViews.createMenus()
        let indexPath = IndexPath(row: 0, section: 0)
        tableViews.leftTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        tableViews.rightResourceView.removeFromSuperview()
        tableViews.segmentView.removeFromSuperview()
        
    }
    
}
