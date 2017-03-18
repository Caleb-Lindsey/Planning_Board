//
//  ManageSegmentsController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ManageSegmentsController : UIViewController {
    
    let segmentMenu = ResourceAddition(type: "Segment")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newSegmentPressed(_ sender: Any) {
        
        segmentMenu.launchMemberView()
        
    }
    
}
