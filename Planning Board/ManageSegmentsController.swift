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

class ManageSegmentsController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Variables
    let segmentMenu = ResourceAddition(type: "Segment")
    
    //Outlets
    @IBOutlet weak var segTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newSegmentPressed(_ sender: Any) {
        
        segmentMenu.launchMemberView()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = segTable.dequeueReusableCell(withIdentifier: "manageSegCell", for: indexPath)
        cell.textLabel?.text = GlobalVariables.segmentArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.segmentArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func viewWillDisappear(_ animated: Bool) {
        segmentMenu.checkAnimation.checkImageView.removeFromSuperview()
    }
    
}
