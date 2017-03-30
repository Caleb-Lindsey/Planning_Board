//
//  ResourceAddition.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 2/13/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class ResourceAddition : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    //Variables
    var menuType = String()
    var tempArray = [String]()
    var segmentObject = SegmentObject()
    let checkAnimation = PBAnimations()
    let dataSource = Datasource()
    let width : CGFloat = 360
    
    init(type: String) {
        self.menuType = type
    }
    
    let addResourceView : UIView = {
        
        let rv = UIView()
        rv.backgroundColor = UIColor.lightGray
        return rv
        
    }()
    
    let addButton : UIButton = {
        
        let bttn = UIButton()
        bttn.setTitle("Add", for: .normal)
        return bttn
        
    }()
    
    let cancelButton : UIButton = {
        
        let cancelBttn = UIButton()
        cancelBttn.setTitle("Cancel", for: .normal)
        return cancelBttn
        
    }()
    
    let profilePic : UIButton = {
        
        let imgBttn = UIButton()
        imgBttn.setImage(#imageLiteral(resourceName: "blank_profile"), for: .normal)
        return imgBttn
        
    }()
    
    let firstTextBox : UITextField = {
        
        let firstField = UITextField()
        firstField.backgroundColor = UIColor.white
        return firstField
        
    }()
    
    let lastTextBox : UITextField = {
        
        let lastField = UITextField()
        lastField.backgroundColor = UIColor.white
        return lastField
        
    }()
    
    let boxLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textAlignment = .center
        return label
        
    }()
    
    let resourceTable : UITableView = {
        
        let segtable = UITableView()
        return segtable
        
    }()
    
    let elementButton : UIButton = {
       
        let elBttn = UIButton()
        elBttn.setImage(#imageLiteral(resourceName: "Plus Icon"), for: .normal)
        return elBttn
        
    }()
    
    
    
    func launchResourceView() {
        
        if let window = UIApplication.shared.keyWindow {
            
            //Setup ResourceView
            window.addSubview(addResourceView)
            let touch = UITapGestureRecognizer(target:self, action: #selector(resignResponder))
            addResourceView.addGestureRecognizer(touch)
            addResourceView.frame = CGRect(x: width, y: 65 , width: window.frame.width - width , height: window.frame.height - 65)
            
            //Setup for BoxLabel
            boxLabel.frame = CGRect(x: 0, y: 15, width: addResourceView.frame.width, height: 40)
            boxLabel.backgroundColor = UIColor.darkGray
            
            //Setup for Done Button
            let buttonWidth = 50
            let buttonHeight = 50
            addButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
            addButton.frame = CGRect(x: Int(addResourceView.frame.width) - buttonWidth - 20, y: 8, width: buttonWidth, height: buttonHeight)
            
            //Setup for Cancel
            let CanbuttonWidth = 60
            let CanbuttonHeight = 50
            cancelButton.frame = CGRect(x: 20, y: 8, width: CanbuttonWidth, height: CanbuttonHeight)
            
            //Setup for First Label
            firstTextBox.layer.cornerRadius = 10
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            firstTextBox.leftView = paddingView
            firstTextBox.leftViewMode = UITextFieldViewMode.always
            
            //Setup for Picture
            let picWidth = addResourceView.frame.width / 4
            let picHeight = addResourceView.frame.width / 4
            profilePic.frame = CGRect(x: 40, y: boxLabel.frame.maxY + 25, width: picWidth, height: picHeight)
            profilePic.layer.masksToBounds = true
            profilePic.layer.cornerRadius = CGFloat(picWidth) / 2
            
            //Setup for Last Name
            lastTextBox.frame = CGRect(x: addResourceView.frame.width / 2.5, y: 115 + 30 + 10, width: 200 , height: 30)
            lastTextBox.center.x = addResourceView.center.x
            lastTextBox.layer.cornerRadius = 10
            let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            lastTextBox.leftView = paddingView2
            lastTextBox.leftViewMode = UITextFieldViewMode.always
            
            //Setup for Resource Table
            resourceTable.frame = CGRect(x: profilePic.frame.origin.x - 12, y: boxLabel.frame.maxY + picWidth * 2, width: addResourceView.frame.width - 35, height: (addResourceView.frame.height / 4) * 2.7)
            resourceTable.center.x = boxLabel.center.x
            resourceTable.layer.cornerRadius = 5
            resourceTable.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
            resourceTable.delegate = self
            resourceTable.dataSource = self
            
            //Setup for Element Button
            elementButton.frame = CGRect(x: addResourceView.frame.width - 40 - 25, y: resourceTable.frame.origin.y - 40 - 5, width: 40, height: 40)
            elementButton.addTarget(self, action: #selector(elementButtonPressed), for: .touchUpInside)
            
            //Setup for Check Gif
            window.addSubview(checkAnimation.checkImageView)
            checkAnimation.checkImageView.frame = CGRect(x: window.frame.width / 2 - 175, y: window.frame.height / 2 - 175, width: 350, height: 350)
            
            
            if menuType == "Segment" {
                
                segmentObject = GlobalVariables.segObjArr[0]
                
                addResourceView.addSubview(boxLabel)
                boxLabel.text = GlobalVariables.segObjArr[0].name
                addResourceView.addSubview(profilePic)
                profilePic.setImage(GlobalVariables.segObjArr[0].iconImage, for: .normal)
                addResourceView.addSubview(resourceTable)
                addResourceView.addSubview(elementButton)
                addResourceView.addSubview(firstTextBox)
                firstTextBox.frame = CGRect(x: resourceTable.frame.origin.x, y: resourceTable.frame.origin.y - 40, width: resourceTable.frame.width - 40 - 10 , height: 30)
                firstTextBox.placeholder = "Add New Element"
                
                
            }
            
            
        }
        
        
    }
    
    func slideSegment(segment : SegmentObject) {
        
        if self.boxLabel.text != segment.name {
            
            segmentObject = segment
            self.elementButton.layer.opacity = 0
                
            animateMenu(type: "Segment")
            
        }
    }
    
    func slideNewSegment() {
        
        // Slide out the menu with proper placements for buttons and labels to add a new segment
        animateMenu(type: "New Segment")
    }
    
    func elementButtonPressed() {
        
        if firstTextBox.text != "" {
            
            segmentObject.elements.append(firstTextBox.text!)
            resourceTable.reloadData()
            dataSource.addElement(row: segmentObject.elements.count, segment: segmentObject, newElement: firstTextBox.text!)
            firstTextBox.text = ""
            
        } else {
            print("Show Alert")
        }
        
    }
    
    func animateMenu(type : String) {
        
        if let window = UIApplication.shared.keyWindow {

            if type == "New Segment" {
                
            } else {
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    
                    self.addResourceView.frame.size.width = 0
                    self.boxLabel.frame.size.width = 0
                    self.profilePic.layer.opacity = 0
                    self.profilePic.frame.origin.x = -40
                    self.resourceTable.layer.opacity = 0
                    self.resourceTable.frame.origin.x = -(self.resourceTable.frame.width)
                    self.firstTextBox.layer.opacity = 0
                    self.firstTextBox.frame.origin.x = -(self.resourceTable.frame.width - 40 - 10)
                    self.elementButton.frame.origin.x = -50
                    
                    
                }, completion: { (finished: Bool) in
                    
                    //Change anything when view is hidden
                    self.boxLabel.text = self.segmentObject.name
                    self.profilePic.setImage(self.segmentObject.iconImage, for: .normal)
                    self.resourceTable.reloadData()
                    
                    UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
                        
                        self.addResourceView.frame.size.width = window.frame.width - self.width
                        self.boxLabel.frame.size.width = self.addResourceView.frame.width
                        self.profilePic.layer.opacity = 1
                        self.profilePic.frame.origin.x = 40
                        self.resourceTable.layer.opacity = 1
                        self.resourceTable.center.x = self.boxLabel.center.x
                        self.firstTextBox.layer.opacity = 1
                        self.firstTextBox.frame.origin.x = self.resourceTable.frame.origin.x
                        self.elementButton.layer.opacity = 1
                        self.elementButton.frame.origin.x = self.addResourceView.frame.width - 40 - 25
                        
                        
                    }, completion: { (finished: Bool) in
                        
                        
                        
                    })
                    
                })
            }
        }
    }
    
    func donePressed() {
        
        if menuType == "Segment" {
            if firstTextBox.text != "" && tempArray != [] {
                
                Datasource().uploadSegment(segmentName: firstTextBox.text!, elementArray: tempArray)
                checkAnimation.playCheckGif()
                
            } else {
                print("Display Alert")
            }
        } else if menuType == "Member" {
            
            
            
        }
    }
    
    func resignResponder() {
        
        if let window = UIApplication.shared.keyWindow {
            window.endEditing(true)
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resourceTable.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        if menuType == "Member" {
            cell.textLabel?.text = GlobalVariables.segmentArray[indexPath.row]

        } else if menuType == "Segment" {
            cell.textLabel?.text = segmentObject.elements[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuType == "Member" {
            return GlobalVariables.segmentArray.count
        } else {
            return segmentObject.elements.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if menuType == "Member" {
            return "Which segments can they host?"
        } else {
            return "Elements"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            
            header.textLabel?.font = UIFont(name: "Helvetica", size: 14)
            header.textLabel?.textAlignment = .center
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tempArray.remove(at: indexPath.row)
            resourceTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    
}

