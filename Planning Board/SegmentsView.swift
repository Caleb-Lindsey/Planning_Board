//
//  SegmentsView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/9/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class SegmentsView : PBViewController, UITableViewDelegate, UITableViewDataSource{
    
    //Variables
    let indexPath = IndexPath(row: 0, section: 0)
    var segmentObject = SegmentObject()
    var dataHandle = Datasource()
    
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
        return label
    }()
    
    let segmentImage : UIButton = {
        let image = UIButton()
        image.setImage(#imageLiteral(resourceName: "fire_icon"), for: .normal)
        image.backgroundColor = UIColor.lightGray
        return image
    }()
    
    let elementLabel : UILabel = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentObject = GlobalVariables.segObjArr[0]
        
        if let window = UIApplication.shared.keyWindow {
            
            let statusBarHeight = statusBar.frame.height
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            
            //Place left top label
            leftTopLabel.frame = CGRect(x: 0, y: statusBarHeight, width: window.frame.width * (4/10), height: 75)
            view.addSubview(leftTopLabel)
            
            //Place left table view
            leftTableView.frame = CGRect(x: 0, y: leftTopLabel.frame.maxY, width: window.frame.width * (4/10), height: window.frame.height - statusBarHeight - (tabBarController?.tabBar.frame.height)!)
            leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "leftCell")
            leftTableView.dataSource = self
            leftTableView.delegate = self
            view.addSubview(leftTableView)
            leftTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            
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
            
            //Place element label
            elementLabel.frame = CGRect(x: segmentImage.frame.maxX + 20, y: 0, width: 100, height: 100)
            elementLabel.center.y = segmentImage.center.y
            elementLabel.text = segmentObject.name
            view.addSubview(elementLabel)
            
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
            
            //Additional
            newElementField.frame.origin.x = rightTableView.frame.origin.x
            
            
        }
    }
    
    
    func addElement() {
        if newElementField.text != "" {
            segmentObject.elements.append(newElementField.text!)
            rightTableView.reloadData()
            dataHandle.addElement(row: segmentObject.elements.count, segment: segmentObject, newElement: newElementField.text!)
            newElementField.text = ""
            
        }
    }
    
    func newSegment() {
        print("It works")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return GlobalVariables.segObjArr.count
        } else {
            return segmentObject.elements.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            let cell = leftTableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath)
            cell.textLabel?.text = GlobalVariables.segObjArr[indexPath.row].name
            return cell
        } else {
            let cell = rightTableView.dequeueReusableCell(withIdentifier: "rightCell", for: indexPath)
            cell.textLabel?.text = segmentObject.elements[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            segmentObject = GlobalVariables.segObjArr[indexPath.row]
            elementLabel.text = segmentObject.name
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
        
        if tableView == rightTableView {
            return .delete
        } else {
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView == rightTableView {
            if editingStyle == .delete {
                segmentObject.elements.remove(at: indexPath.row)
                dataHandle.removeElement(segmentObject: segmentObject)
                rightTableView.reloadData()
            }
        }
        
    }
    
}


























