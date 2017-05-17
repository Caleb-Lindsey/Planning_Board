//
//  SegmentsView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/9/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class SegmentsView : PBViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Variables
    let myIndexPath = IndexPath(row: 0, section: 0)
    var segmentObject = SegmentObject()
    var dataHandle = Datasource()
    var newSegmentMode : Bool = false
    var tempArray = [String]()
    
    //Left Side
    let leftTopLabel : UILabel = {
        let label = UILabel()
        label.text = "Segments"
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
    
    let newSegmentButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus4"), for: .normal)
        button.addTarget(self, action: #selector(newSegment), for: .touchUpInside)
        return button
    }()
    
    //Right side
    let rightTopLabel : UILabel = {
        let label = UILabel()
        label.text = "Elements"
        label.font = UIFont(name: "Helvetica", size: 30)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.3
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var segmentImage : UIButton = {
        let image = UIButton()
        image.setImage(#imageLiteral(resourceName: "fire_icon"), for: .normal)
        image.backgroundColor = UIColor.lightGray
        return image
    }()
    
    let segmentLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    let newElementField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add new element"
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    let addElementButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Plus Icon"), for: .normal)
        button.frame.size = CGSize(width: 35, height: 35)
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(addElement), for: .touchUpInside)
        return button
    }()
    
    let rightTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let newSegmentField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Segment name"
        textField.backgroundColor = UIColor.white
        return textField
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dataHandle.uploadMember(firstName: "Matt", lastName: "Mckinnon", hostables: ["yo", "whats", "up"])
        segmentObject = GlobalVariables.segObjArr[0]
        
        if let window = UIApplication.shared.keyWindow {
            
            let statusBarHeight = statusBar.frame.height
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            
            //Place left top label
            leftTopLabel.frame = CGRect(x: 0, y: statusBarHeight, width: window.frame.width * (4/10), height: 75)
            view.addSubview(leftTopLabel)
            
            //Place left table view
            leftTableView.frame = CGRect(x: 0, y: leftTopLabel.frame.maxY, width: window.frame.width * (4/10), height: window.frame.height - statusBarHeight - (tabBarController?.tabBar.frame.height)!)
            leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "leftCell")
            leftTableView.dataSource = self
            leftTableView.delegate = self
            view.addSubview(leftTableView)
            leftTableView.selectRow(at: myIndexPath, animated: true, scrollPosition: .none)
            
            //Place new segment button
            newSegmentButton.frame = CGRect(x: leftTopLabel.frame.width - 35 - 20, y: 0, width: 35, height: 35)
            newSegmentButton.center.y = leftTopLabel.frame.height / 2
            leftTopLabel.addSubview(newSegmentButton)
            
            //Place right top label
            rightTopLabel.frame = CGRect(x: leftTopLabel.frame.maxX, y: statusBarHeight, width: window.frame.width * (6/10), height: 75)
            view.addSubview(rightTopLabel)
            
            //Place image
            segmentImage.frame = CGRect(x: leftTableView.frame.maxX + 50, y: rightTopLabel.frame.maxY + 50, width: 120, height: 120)
            segmentImage.layer.cornerRadius = segmentImage.frame.width / 2
            view.addSubview(segmentImage)
            
            //Place segment label
            segmentLabel.frame = CGRect(x: segmentImage.frame.maxX + 20, y: 0, width: 200, height: 100)
            segmentLabel.center.y = segmentImage.center.y
            segmentLabel.text = segmentObject.name
            view.addSubview(segmentLabel)
            
            //Place new element field
            newElementField.frame = CGRect(x: segmentImage.frame.origin.x, y: segmentImage.frame.maxY + 45, width: window.frame.width * (6/10) - 75, height: 35)
            newElementField.leftView = paddingView
            newElementField.rightView = addElementButton
            newElementField.leftViewMode = UITextFieldViewMode.always
            newElementField.rightViewMode = UITextFieldViewMode.always
            view.addSubview(newElementField)
            
            //Place right table view
            rightTableView.frame = CGRect(x: 0, y: newElementField.frame.maxY + 15, width: window.frame.width * (6/10) - 75, height: window.frame.height / 2)
            rightTableView.center.x = rightTopLabel.center.x
            rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "rightCell")
            rightTableView.dataSource = self
            rightTableView.delegate = self
            view.addSubview(rightTableView)
            
            //New segment field
            newSegmentField.frame = newElementField.frame
            newSegmentField.leftView = paddingView2
            newSegmentField.leftViewMode = UITextFieldViewMode.always
            
            //Additional
            newElementField.frame.origin.x = rightTableView.frame.origin.x
            
            
        }
    }
    
    
    func addElement() {
        if newElementField.text != "" {
            if newSegmentMode {
                tempArray.append(newElementField.text!)
            } else {
                segmentObject.elements.append(newElementField.text!)
                dataHandle.addElement(row: segmentObject.elements.count, segment: segmentObject, newElement: newElementField.text!)
            }
            newElementField.text = ""
            rightTableView.reloadData()
        }
    }
    
    func newSegment() {
        
        newSegmentButton.isUserInteractionEnabled = false
        newSegmentMode = true
        leftTableView.isUserInteractionEnabled = false
        
        //Segment image
        segmentImage.setImage(nil, for: .normal)
        segmentImage.setTitle("Add Image", for: .normal)
        
        //Segment label
        segmentLabel.text = "New Segment"
        
        //New segment title
        newSegmentField.frame.origin.x = rightTableView.frame.origin.x
        view.addSubview(newSegmentField)
        view.bringSubview(toFront: newElementField)
        
        //Element field
        
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
        
        //Animations
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.newElementField.frame.origin.y = self.newElementField.frame.origin.y + 50
            self.rightTableView.frame.origin.y = self.rightTableView.frame.origin.y + 50
            self.newSegmentButton.layer.opacity = 0.3
            self.leftTableView.layer.opacity = 0.3
            self.leftTopLabel.layer.opacity = 0.3
            
        }, completion: {(finished: Bool) in
            
            
        })
        
        
    }
    
    func cancelCreate() {
        
        newSegmentMode = false
        cancelButton.removeFromSuperview()
        doneButton.removeFromSuperview()
        self.segmentImage.setImage(#imageLiteral(resourceName: "fire_icon"), for: .normal)
        self.segmentLabel.text = self.segmentObject.name
        tempArray.removeAll()
        newSegmentField.text = ""
        newElementField.text = ""
        rightTableView.layer.borderWidth = 0
        rightTableView.layer.borderColor = UIColor.clear.cgColor
        newSegmentField.layer.borderWidth = 0
        newSegmentField.layer.borderColor = UIColor.clear.cgColor
        
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            
            self.newElementField.frame.origin.y = self.newElementField.frame.origin.y - 50
            self.rightTableView.frame.origin.y = self.rightTableView.frame.origin.y - 50
            self.newSegmentButton.layer.opacity = 1
            self.leftTableView.layer.opacity = 1
            self.leftTopLabel.layer.opacity = 1
            self.newSegmentButton.layer.opacity = 1
            
        }, completion: {(finished: Bool) in
            
            self.newSegmentField.removeFromSuperview()
            self.rightTableView.reloadData()
            self.newSegmentButton.isUserInteractionEnabled = true
            self.leftTableView.isUserInteractionEnabled = true
            
            
        })
        
        
    }
    
    func doneCreate() {

        if newSegmentField.text != "" && tempArray != [] {
            dataHandle.uploadSegment(segmentName: newSegmentField.text!, elementArray: tempArray)
            leftTableView.reloadData()
            cancelCreate()
        } else {
            
            let alertTitle : String = "Not Enough Data"
            var alertMessage : String = ""
            
            if newSegmentField.text == "" {
                newSegmentField.layer.borderWidth = 3
                newSegmentField.layer.borderColor = UIColor.red.cgColor
                alertMessage += "- Missing Segment Name."
            } else {
                newSegmentField.layer.borderWidth = 0
                newSegmentField.layer.borderColor = UIColor.clear.cgColor
            }
            if tempArray == [] {
                rightTableView.layer.borderWidth = 3
                rightTableView.layer.borderColor = UIColor.red.cgColor
                alertMessage += "\n- Need at least one element."
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
            return GlobalVariables.segObjArr.count
        } else {
            if newSegmentMode {
                return tempArray.count
            } else {
                return segmentObject.elements.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            let cell = leftTableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath)
            cell.textLabel?.text = GlobalVariables.segObjArr[indexPath.row].name
            return cell
        } else {
            let cell = rightTableView.dequeueReusableCell(withIdentifier: "rightCell", for: indexPath)
            if newSegmentMode {
                cell.textLabel?.text = tempArray[indexPath.row]
            } else {
                cell.textLabel?.text = segmentObject.elements[indexPath.row]
            }
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            segmentObject = GlobalVariables.segObjArr[indexPath.row]
            segmentLabel.text = segmentObject.name
            rightTableView.reloadData()
        } else {
            
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
                if newSegmentMode {
                    tempArray.remove(at: indexPath.row)
                } else {
                    segmentObject.elements.remove(at: indexPath.row)
                    dataHandle.removeElement(segmentObject: segmentObject)
                }
                rightTableView.reloadData()
            }
        } else {
            dataHandle.removeSegment(segmentObject: GlobalVariables.segObjArr[indexPath.row])
            GlobalVariables.segObjArr.remove(at: indexPath.row)
            segmentObject = GlobalVariables.segObjArr[0]
            leftTableView.reloadData()
            leftTableView.selectRow(at: myIndexPath, animated: true, scrollPosition: .none)
            
        }
        
    }
    
}


























