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
    var additionType = String()
    var tempArray = [String]()
    let checkAnimation = PBAnimations()
    
    init(type: String) {
        self.additionType = type
    }
    
    let blurView : UIVisualEffectView = {
        
        let blurEff = UIBlurEffect(style: .dark)
        let blurV = UIVisualEffectView(effect: blurEff)
        return blurV
        
    }()
    
    let addResourceView : UIView = {
        
        let rv = UIView()
        rv.backgroundColor = UIColor.gray
        rv.layer.cornerRadius = 10
        rv.layer.borderWidth = 2
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
    
    
    
    func launchMemberView() {
        
        if let window = UIApplication.shared.keyWindow {
            
            //Setup BlurView
            blurView.frame = window.frame
            blurView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blurView.alpha = 0
            window.addSubview(blurView)
            
            window.addSubview(addResourceView)
            let touch = UITapGestureRecognizer(target:self, action: #selector(resignResponder))
            addResourceView.addGestureRecognizer(touch)
            
            
            let width : CGFloat = window.frame.width //- 200
            let height : CGFloat = window.frame.height / 2
            
            addResourceView.frame = CGRect(x: window.center.x - (width / 2), y: window.frame.height , width: width , height: height)
            addResourceView.layer.opacity = 0
            
            //Setup for BoxLabel
            addResourceView.addSubview(boxLabel)
            boxLabel.frame = CGRect(x: 0, y: 15, width: addResourceView.frame.width, height: 40)
            boxLabel.backgroundColor = UIColor.darkGray
            
            //Setup for Done Button
            addResourceView.addSubview(addButton)
            let buttonWidth = 50
            let buttonHeight = 50
            addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
            addButton.frame = CGRect(x: Int(addResourceView.frame.width) - buttonWidth - 20, y: 8, width: buttonWidth, height: buttonHeight)
            
            //Setup for Cancel
            addResourceView.addSubview(cancelButton)
            cancelButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            let CanbuttonWidth = 60
            let CanbuttonHeight = 50
            cancelButton.frame = CGRect(x: 20, y: 8, width: CanbuttonWidth, height: CanbuttonHeight)
            
            //Setup for First Label
            addResourceView.addSubview(firstTextBox)
            firstTextBox.frame = CGRect(x: addResourceView.frame.width / 2.5, y: 115, width: 200 , height: 30)
            firstTextBox.center.x = addResourceView.center.x
            firstTextBox.layer.cornerRadius = 10
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            firstTextBox.leftView = paddingView
            firstTextBox.leftViewMode = UITextFieldViewMode.always
            
            //Setup for Picture
            addResourceView.addSubview(profilePic)
            let picWidth = addResourceView.frame.width / 4
            let picHeight = addResourceView.frame.width / 4
            profilePic.frame = CGRect(x: 60, y: 75, width: picWidth, height: picHeight)
            profilePic.layer.masksToBounds = true
            profilePic.layer.cornerRadius = CGFloat(picWidth) / 2
            
            
            //Setup for Last Name
            lastTextBox.frame = CGRect(x: addResourceView.frame.width / 2.5, y: 115 + 30 + 10, width: 200 , height: 30)
            lastTextBox.center.x = addResourceView.center.x
            lastTextBox.layer.cornerRadius = 10
            let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            lastTextBox.leftView = paddingView2
            lastTextBox.leftViewMode = UITextFieldViewMode.always
            addResourceView.addSubview(lastTextBox)
            
            //Setup for Segments Table
            addResourceView.addSubview(resourceTable)
            resourceTable.frame = CGRect(x: firstTextBox.frame.origin.x, y: 195, width: 250, height: 285)
            resourceTable.layer.cornerRadius = 5
            resourceTable.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
            resourceTable.delegate = self
            resourceTable.dataSource = self
            
            //Setup for Element Button
            elementButton.frame = CGRect(x: lastTextBox.frame.origin.x + 200 + 10, y: lastTextBox.frame.origin.y - 5, width: 40, height: 40)
            elementButton.addTarget(self, action: #selector(elementButtonPressed), for: .touchUpInside)
            
            //Setup for Check Gif
            window.addSubview(checkAnimation.checkImageView)
            checkAnimation.checkImageView.frame = CGRect(x: window.frame.width / 2 - 175, y: window.frame.height / 2 - 175, width: 350, height: 350)
            
            if additionType == "Member" {
                boxLabel.text = "New Member"
                firstTextBox.placeholder = "First Name"
                lastTextBox.placeholder = "Last Name"
                profilePic.setImage(#imageLiteral(resourceName: "blank_profile"), for: .normal)
            } else if additionType == "Segment" {
                boxLabel.text = "New Segment"
                firstTextBox.placeholder = "Segment Name"
                lastTextBox.placeholder = "Add Element"
                profilePic.setImage(#imageLiteral(resourceName: "firebackground"), for: .normal)
                addResourceView.addSubview(elementButton)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blurView.alpha = 1
                
                self.addResourceView.frame = CGRect(x: window.center.x - (width / 2), y: window.center.y - (height / 2 + 30), width: width , height: height)
                self.addResourceView.layer.opacity = 1
                
            }, completion: nil)
            
        }
        
    }
    
    func elementButtonPressed() {
        
        if lastTextBox.text != "" {
            
            tempArray.append(lastTextBox.text!)
            lastTextBox.text = ""
            resourceTable.reloadData()
            
        }
        
    }
    
    func addPressed() {
        
        if additionType == "Segment" {
            if firstTextBox.text != "" && tempArray != [] {
                
                GlobalVariables.resourceDict[firstTextBox.text!] = tempArray
                
                Datasource().uploadSegment(segmentName: firstTextBox.text!, elementArray: tempArray)
                
                handleDismiss()
                
            }
        } else if additionType == "Member" {
            
            
            
        }
    }
    
    func handleDismiss() {
        if let window = UIApplication.shared.keyWindow {
            
            window.endEditing(true)
            
            let width : CGFloat = window.frame.width
            let height : CGFloat = window.frame.height / 2
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                self.blurView.alpha = 0
                self.addResourceView.frame = CGRect(x: window.center.x - (width / 2), y: window.frame.height , width: width , height: height)
            }, completion: { (finished: Bool) in
                
                self.checkAnimation.playCheckGif()
            })
            
            firstTextBox.text = ""
            lastTextBox.text = ""
            tempArray.removeAll()
            resourceTable.reloadData()
            
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
        if additionType == "Member" {
            cell.textLabel?.text = GlobalVariables.segmentArray[indexPath.row]

        } else {
            cell.textLabel?.text = tempArray[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if additionType == "Member" {
            return GlobalVariables.segmentArray.count
        } else {
            return tempArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if additionType == "Member" {
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

