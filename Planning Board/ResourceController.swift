//
//  ResourceController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 2/11/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation

struct memberCellData {
    var cell : Int!
    var memberNameText : String!
    var memberHostingsText : String!
    var memberProfilePic : UIImage!
}

class ResourceController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Outlets
    @IBOutlet weak var memberTable: UITableView!
    
    //Variables
    var arrayOfMemberData = [memberCellData]()
    let resourceMenu = ResourceAddition(type: "Member")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfMemberData = [memberCellData(cell: 1, memberNameText: "Ryan Young", memberHostingsText: "Transitions, + 2 more", memberProfilePic: #imageLiteral(resourceName: "Ryan_Young"))]
        
        //Set up Tables
        memberTable.layer.cornerRadius = 10
        
        
    }
 
    @IBAction func addButtonsPressed(_ sender: Any) {
        
        resourceMenu.launchMemberView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == memberTable {
            return arrayOfMemberData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrayOfMemberData[indexPath.row].cell == 1 {
            
            let cell = Bundle.main.loadNibNamed("memberCell1", owner: self, options: nil)?.first as! memberCell1
            cell.memberProfile.image = arrayOfMemberData[indexPath.row].memberProfilePic
            cell.memberProfile.layer.cornerRadius = cell.memberProfile.frame.size.width / 2
            cell.memberProfile.clipsToBounds = true
            cell.memberName.text = arrayOfMemberData[indexPath.row].memberNameText
            cell.memberHostings.text = arrayOfMemberData[indexPath.row].memberHostingsText
            
            return cell
            
        } else {
            
            let cell = Bundle.main.loadNibNamed("memberCell1", owner: self, options: nil)?.first as! memberCell1
            cell.memberProfile.image = arrayOfMemberData[indexPath.row].memberProfilePic
            cell.memberName.text = arrayOfMemberData[indexPath.row].memberNameText
            cell.memberHostings.text = arrayOfMemberData[indexPath.row].memberHostingsText
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resourceMenu.handleDismiss()
    }
    
}



















