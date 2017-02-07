//
//  SettingsMenuController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 1/8/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation

class SettingsMenuController : UITableViewController {
    
    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    
    var objectsArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectsArray = [Objects(sectionName: " ", sectionObjects: []),Objects(sectionName: "Settings", sectionObjects: ["Notifications", "Account"]),Objects(sectionName: " ", sectionObjects: []), Objects(sectionName: "Information", sectionObjects: ["About","Feedback"]),Objects(sectionName: " ", sectionObjects: []),Objects(sectionName: " ", sectionObjects: ["Logout"])]
        
        
        self.tableView.tableFooterView = UIImageView()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        let choiceLabel = currentCell.textLabel!.text!
        
        handleChoice(choice: choiceLabel)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        cell?.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        cell?.textLabel?.textAlignment = .left
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.systemFont(ofSize: 16.0)
            header.textLabel!.textColor = UIColor.white
            header.tintColor = UIColor.darkGray
        }
    }
    
    func handleChoice(choice : String) {
        
        switch choice {
        case "Notifications":
            print("Notifications Chosen")
        case "Account":
            print("")
        case "About":
            print("")
        case "Feedback":
            print("")
        case "Logout":
            print("")
        default:
            print("error")
        }
        
    }
    
}























