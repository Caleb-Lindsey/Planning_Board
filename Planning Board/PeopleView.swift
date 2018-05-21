//
//  PeopleView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/9/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class PeopleView : PBViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Variables
    let myIndexPath = IndexPath(row: 0, section: 0)
    var memberObject = Member()
    var dataHandle = Datasource()
    var newMemberMode : Bool = false
    var editMemberMode : Bool = false
    var tempArray = [String]()
    
    //Left Side
    let leftTopLabel : UILabel = {
        let label = UILabel()
        label.text = "Members"
        label.textAlignment = .center
        label.layer.borderWidth = 0.25
        label.layer.borderColor = UIColor.black.cgColor
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textColor = UIColor.white
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.3
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let leftTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let newMemberButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus4"), for: .normal)
        button.addTarget(self, action: #selector(newMember), for: .touchUpInside)
        return button
    }()
    
    //Right side
    let rightTopLabel : UILabel = {
        let label = UILabel()
        label.text = "Information"
        label.font = UIFont(name: "Helvetica", size: 22)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.3
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var profileImage : UIButton = {
        let image = UIButton()
        image.setImage(#imageLiteral(resourceName: "fire_icon"), for: .normal)
        image.backgroundColor = UIColor.lightGray
        image.clipsToBounds = true
        image.layer.borderColor = Global.greenColor.cgColor
        image.layer.borderWidth = 2
        image.isUserInteractionEnabled = false
        image.imageView?.contentMode = .scaleAspectFill
        image.addTarget(self, action: #selector(profileImagePressed), for: .touchUpInside)
        return image
    }()
    
    let memberLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    let rightTableView : UITableView = {
        let tableView = UITableView()
        tableView.layer.zPosition = 10
        tableView.allowsMultipleSelection = true
        return tableView
    }()
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "RedX"), for: .normal)
        button.frame.size = CGSize(width: 35, height: 35)
        button.addTarget(self, action: #selector(cancelCreate), for: .touchUpInside)
        return button
    }()
    
    let doneButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Check_00040"), for: .normal)
        button.frame.size = CGSize(width: 35, height: 35)
        button.addTarget(self, action: #selector(doneCreate), for: .touchUpInside)
        return button
    }()
    
    let newFirstName : CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "first name"
        return textField
    }()
    
    let newLastName : CustomTextField = {
        let textField = CustomTextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "last name"
        return textField
    }()
    
    let editButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(editMember), for: .touchUpInside)
        return button
    }()
    
    var fieldCover = FieldCover()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Global.memberArray.count != 0 {
            setupView()
            
        }
        
        if let window = UIApplication.shared.keyWindow {
            
            let statusBarHeight = statusBar.frame.height
            
            //Place left top label
            leftTopLabel.frame = CGRect(x: 0, y: statusBarHeight, width: window.frame.width * (4/10), height: 75)
            view.addSubview(leftTopLabel)
            
            //Place left table view
            leftTableView.frame = CGRect(x: 0, y: leftTopLabel.frame.maxY, width: window.frame.width * (4/10), height: window.frame.height - statusBarHeight - (tabBarController?.tabBar.frame.height)! - leftTopLabel.frame.height)
            leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "leftCell")
            leftTableView.dataSource = self
            leftTableView.delegate = self
            view.addSubview(leftTableView)
            leftTableView.selectRow(at: myIndexPath, animated: true, scrollPosition: .none)
            
            //Place new segment button
            newMemberButton.frame = CGRect(x: leftTopLabel.frame.width - 35 - 20, y: 0, width: 35, height: 35)
            newMemberButton.center.y = leftTopLabel.frame.height / 2
            leftTopLabel.addSubview(newMemberButton)
            
            //Place right top label
            rightTopLabel.frame = CGRect(x: leftTopLabel.frame.maxX, y: statusBarHeight, width: window.frame.width * (6/10), height: 75)
            view.addSubview(rightTopLabel)
            
            //Place image
            profileImage.frame = CGRect(x: leftTableView.frame.maxX + 50, y: rightTopLabel.frame.maxY + 50, width: 120, height: 120)
            profileImage.layer.cornerRadius = profileImage.frame.width / 2
            view.addSubview(profileImage)
            
            //Place member label
            memberLabel.frame = CGRect(x: profileImage.frame.maxX + 20, y: 0, width: 200, height: 100)
            memberLabel.center.y = profileImage.center.y
            memberLabel.text = "\(memberObject.firstName) \(memberObject.lastName)"
            view.addSubview(memberLabel)
            
            //Place right table view
            rightTableView.frame = CGRect(x: 0, y: profileImage.frame.maxY + 25, width: window.frame.width * (6/10) - 75, height: window.frame.height / 2)
            rightTableView.center.x = rightTopLabel.center.x
            rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "rightCell")
            rightTableView.dataSource = self
            rightTableView.delegate = self
            view.addSubview(rightTableView)
            
            //Place edit button
            editButton.frame = CGRect(x: view.frame.width - 50 - 15, y: statusBarHeight, width: 50, height: 35)
            editButton.center.y = rightTopLabel.center.y
            view.addSubview(editButton)
            
            shouldFieldCoverDisplay()
            
        }
    }
    
    
    @objc func newMember() {
        
        newMemberButton.isUserInteractionEnabled = false
        leftTableView.isUserInteractionEnabled = false
        editButton.isEnabled = false
        profileImage.isUserInteractionEnabled = true
        
        //Element table view
        rightTableView.reloadData()
        
        //Cancel button
        cancelButton.frame = CGRect(x: 20, y: 0, width: 35, height: 35)
        cancelButton.center.y = rightTopLabel.frame.height / 2
        rightTopLabel.addSubview(cancelButton)
        
        //Done button
        doneButton.frame = CGRect(x: rightTopLabel.frame.width - 35 - 20, y: 0, width: 35, height: 35)
        doneButton.center.y = rightTopLabel.frame.height / 2
        rightTopLabel.addSubview(doneButton)
        
        //First name field
        newFirstName.frame = CGRect(x: rightTableView.frame.origin.x, y: profileImage.frame.maxY + 25, width: rightTableView.frame.width, height: 35)
        newFirstName.delegate = self
        view.addSubview(newFirstName)
        
        //Last name field
        newLastName.frame = CGRect(x: rightTableView.frame.origin.x, y: newFirstName.frame.maxY + 15, width: rightTableView.frame.width, height: 35)
        newLastName.delegate = self
        view.addSubview(newLastName)
        
        if editMemberMode == false {
            newMemberMode = true
            
            //Profile image
            profileImage.setImage(nil, for: .normal)
            profileImage.setTitle("Add Image", for: .normal)
            
            //Member label
            memberLabel.text = "New Member"
            
            //Element Table View
            rightTableView.reloadData()
        
            
            
        } else {
            
            //Profile image
            profileImage.setImage(nil, for: .normal)
            profileImage.setTitle("Change Image", for: .normal)
            
            //Member label
            memberLabel.text = "Edit \(memberObject.fullName())"
            
            // First name field
            newFirstName.text = memberObject.firstName
            
            // Last name field
            newLastName.text = memberObject.lastName
            
            // Right table view
            rightTableView.reloadData()
            
        }
        
        shouldFieldCoverDisplay()
        
        //Animations
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.rightTableView.frame.origin.y = self.rightTableView.frame.origin.y + 125
            self.newMemberButton.layer.opacity = 0.3
            self.leftTableView.layer.opacity = 0.3
            self.leftTopLabel.layer.opacity = 0.3
            self.editButton.layer.opacity = 0
            
        }, completion: {(finished: Bool) in
            
            
        })
        
        
    }
    
    @objc func cancelCreate() {
        
        newMemberMode = false
        editMemberMode = false
        profileImage.isUserInteractionEnabled = false
        
        cancelButton.removeFromSuperview()
        doneButton.removeFromSuperview()
        self.memberLabel.text = "\(memberObject.fullName())"
        tempArray.removeAll()
        newFirstName.text = ""
        newLastName.text = ""
        rightTableView.layer.borderWidth = 0
        rightTableView.layer.borderColor = UIColor.clear.cgColor
        newFirstName.layer.borderWidth = 0
        newFirstName.layer.borderColor = UIColor.clear.cgColor
        newLastName.layer.borderWidth = 0
        newLastName.layer.borderColor = UIColor.clear.cgColor
        rightTableView.layer.borderWidth = 0
        rightTableView.layer.borderColor = UIColor.clear.cgColor
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            
            self.rightTableView.frame.origin.y = self.rightTableView.frame.origin.y - 125
            self.newMemberButton.layer.opacity = 1
            self.leftTableView.layer.opacity = 1
            self.leftTopLabel.layer.opacity = 1
            self.newMemberButton.layer.opacity = 1
            self.editButton.layer.opacity = 1
            
            self.shouldFieldCoverDisplay()
            
        }, completion: {(finished: Bool) in
            
            self.rightTableView.reloadData()
            self.newMemberButton.isUserInteractionEnabled = true
            self.leftTableView.isUserInteractionEnabled = true
            self.newLastName.removeFromSuperview()
            self.newFirstName.removeFromSuperview()
            self.editButton.isEnabled = true
            
            
        })
        
        
    }
    
    @objc func doneCreate() {
        
        //Add selected cells to tempArray
        for cell in rightTableView.visibleCells {
            if cell.accessoryType == .checkmark {
                tempArray.append((cell.textLabel?.text)!)
            }
            
        }
        
        if tempArray != [] && newFirstName.text != "" && newLastName.text != "" {
            
            let newMember = Member(FirstName: newFirstName.text!, LastName: newLastName.text!, CanHost: tempArray, ProfilePic: (profileImage.imageView?.image)!)
            
            if newMemberMode {
                Global.memberArray.append(newMember)

            } else if editMemberMode {
                Global.memberArray[(leftTableView.indexPathForSelectedRow?.row)!] = newMember
            }
            
            dataHandle.uploadMember()
            leftTableView.reloadData()
            cancelCreate()
            
        } else {
            
            let alertTitle : String = "Missing Required Fields"
            var alertMessage : String = ""
            
            if newFirstName.text == "" {
                newFirstName.layer.borderWidth = 3
                newFirstName.layer.borderColor = UIColor.red.cgColor
                alertMessage += "- First Name."
            } else {
                newFirstName.layer.borderWidth = 0
                newFirstName.layer.borderColor = UIColor.clear.cgColor
            }
            if newLastName.text == "" {
                newLastName.layer.borderWidth = 3
                newLastName.layer.borderColor = UIColor.red.cgColor
                alertMessage += "\n- Last Name."
            } else {
                newLastName.layer.borderWidth = 0
                newLastName.layer.borderColor = UIColor.clear.cgColor
            }
            if tempArray == [] {
                rightTableView.layer.borderWidth = 3
                rightTableView.layer.borderColor = UIColor.red.cgColor
                alertMessage += "\n- Segments."
            } else {
                rightTableView.layer.borderWidth = 0
                rightTableView.layer.borderColor = UIColor.clear.cgColor
            }
            
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTableView {
            return Global.memberArray.count
        } else {
            if newMemberMode || editMemberMode {
                return Global.segmentArray.count
            } else {
                return memberObject.canHost.count
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            let cell : MemberCell = MemberCell(member: Global.memberArray[indexPath.row], reuseIdentifier: "leftCell")
            return cell
        } else {
            let cell = rightTableView.dequeueReusableCell(withIdentifier: "rightCell", for: indexPath)
            
            if newMemberMode {
                cell.textLabel?.text = Global.segmentArray[indexPath.row].title
                cell.accessoryType = (cell.isSelected) ? .checkmark : .none
            } else if editMemberMode {
                cell.textLabel?.text = Global.segmentArray[indexPath.row].title
        
                for segment in memberObject.canHost {
                    if segment == Global.segmentArray[indexPath.row].title {

                        cell.accessoryType = .checkmark
                        cell.isSelected = true
                    
                    }
                }
                
            } else {
                cell.textLabel?.text = memberObject.canHost[indexPath.row]
                cell.accessoryType = .none
            }
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            memberObject = Global.memberArray[indexPath.row]
            memberLabel.text = "\(memberObject.firstName) \(memberObject.lastName)"
            profileImage.setImage(Global.memberArray[indexPath.row].profilePic, for: .normal)
            rightTableView.reloadData()
            
        } else {
            if newMemberMode || editMemberMode {
                rightTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            } else {
                rightTableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == rightTableView {
            
            rightTableView.cellForRow(at: indexPath)?.accessoryType = .none
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leftTableView {
            return 80
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView == rightTableView {
            if editingStyle == .delete {
                if newMemberMode {
                    tempArray.remove(at: indexPath.row)
                } else {
                    memberObject.canHost.remove(at: indexPath.row)
                   dataHandle.uploadMember()
                }
                rightTableView.reloadData()
            }
        } else {
            
            Global.memberArray.remove(at: indexPath.row)
            dataHandle.uploadMember()
            leftTableView.reloadData()
            leftTableView.selectRow(at: myIndexPath, animated: true, scrollPosition: .none)
            rightTableView.reloadData()
            shouldFieldCoverDisplay()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == rightTableView {
            if newMemberMode {
                return "Select segments to host"
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if tableView == rightTableView {
            if let header = view as? UITableViewHeaderFooterView {
                header.textLabel!.font = UIFont.systemFont(ofSize: 13.0)
                header.textLabel!.textColor = UIColor.white
                header.tintColor = UIColor.darkGray
                header.textLabel?.textAlignment = NSTextAlignment.center
            }
        }
    }
    
    @objc func editMember() {
        
        editMemberMode = true
        newMember()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    func setupView() {
        
        if Global.memberArray != [] {
            
            leftTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected = true
            leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            profileImage.setImage(Global.memberArray[0].profilePic, for: .normal)
            memberLabel.text = Global.memberArray[0].fullName()
            memberObject = Global.memberArray[0]
            rightTableView.reloadData()
            
        }
        
    }
    
    @objc func profileImagePressed() {
        

            
        print("Adding a picture")
        
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            // After it is complete
        }
            
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.setImage(image, for: .normal)
        } else {
            // Display Error
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func shouldFieldCoverDisplay() {
        
        if Global.memberArray == [] {
            
            if newMemberMode {
                UIView.animate(withDuration: 0.5, animations: {
                    self.fieldCover.frame.origin.x = self.view.frame.width
                })
                rightTableView.layer.opacity = 1
                fieldCover.removeFromSuperview()
            } else {
                fieldCover = FieldCover(displayMessage: "Add a new Member to begin.", frame: CGRect(x: leftTopLabel.frame.maxX, y: leftTopLabel.frame.origin.y, width: view.frame.width - leftTopLabel.frame.width, height: leftTopLabel.frame.height + leftTableView.frame.height))
                
                rightTableView.layer.opacity = 0
                view.addSubview(fieldCover)

            }
        } else {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.fieldCover.frame.origin.x = self.view.frame.width
            })
            
            rightTableView.layer.opacity = 1
            fieldCover.removeFromSuperview()
            
        }
        
    }
    
}






















