//
//  SegmentsView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/9/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class SegmentsView: PBViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    //Variables
    let myIndexPath = IndexPath(row: 0, section: 0)
    var segmentObject: Segment!
    var dataHandle = Datasource()
    var newSegmentMode: Bool = false
    var tempArray = [Element]()
    
    //Left Side
    let leftTopLabel: UILabel = {
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
    
    let leftTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let newSegmentButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus4"), for: .normal)
        button.addTarget(self, action: #selector(newSegment), for: .touchUpInside)
        return button
    }()
    
    //Right side
    let rightTopLabel: UILabel = {
        let label = UILabel()
        label.text = "Elements"
        label.font = UIFont(name: "Helvetica", size: 22)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.3
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var segmentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fire_icon")
        imageView.backgroundColor = UIColor.lightGray
        imageView.layer.borderColor = Colors.greenColor.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let segmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textAlignment = .center
        return label
    }()
    
    let newElementField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Add new element"
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    let addElementButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Plus Icon"), for: .normal)
        button.frame.size = CGSize(width: 35, height: 35)
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(addElement), for: .touchUpInside)
        return button
    }()
    
    let rightTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let newSegmentField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Segment name"
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "RedX"), for: .normal)
        button.frame.size = CGSize(width: 35, height: 35)
        button.addTarget(self, action: #selector(cancelCreate), for: .touchUpInside)
        return button
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Check_00040"), for: .normal)
        button.frame.size = CGSize(width: 35, height: 35)
        button.addTarget(self, action: #selector(doneCreate), for: .touchUpInside)
        return button
    }()
    
    let iconImagePickerView = IconImagePicker()
    var fieldCover = FieldCover()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = statusBar.frame.height
        
        //Place left top label
        leftTopLabel.frame = CGRect(x: 0, y: statusBarHeight, width: view.frame.width * (4/10), height: 75)
        view.addSubview(leftTopLabel)
        
        //Place left table view
        leftTableView.frame = CGRect(x: 0, y: leftTopLabel.frame.maxY, width: view.frame.width * (4/10), height: view.frame.height - statusBarHeight - (tabBarController?.tabBar.frame.height)! - leftTopLabel.frame.height)
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
        rightTopLabel.frame = CGRect(x: leftTopLabel.frame.maxX, y: statusBarHeight, width: view.frame.width * (6/10), height: 75)
        view.addSubview(rightTopLabel)
        
        //Place image
        segmentImage.frame = CGRect(x: leftTableView.frame.maxX + 50, y: rightTopLabel.frame.maxY + 50, width: 120, height: 120)
        segmentImage.layer.cornerRadius = segmentImage.frame.width / 2
        view.addSubview(segmentImage)
        
        //Place segment label
        segmentLabel.frame = CGRect(x: segmentImage.frame.maxX + 20, y: 0, width: 200, height: 100)
        segmentLabel.center.y = segmentImage.center.y
        segmentLabel.text = segmentObject.title
        view.addSubview(segmentLabel)
        
        //Place new element field
        newElementField.frame = CGRect(x: segmentImage.frame.origin.x, y: segmentImage.frame.maxY + 45, width: view.frame.width * (6/10) - 75, height: 35)
        newElementField.rightView = addElementButton
        newElementField.rightViewMode = UITextFieldViewMode.always
        newElementField.delegate = self
        view.addSubview(newElementField)
        
        //Place right table view
        rightTableView.frame = CGRect(x: 0, y: newElementField.frame.maxY + 15, width: view.frame.width * (6/10) - 75, height: view.frame.height / 2)
        rightTableView.center.x = rightTopLabel.center.x
        rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "rightCell")
        rightTableView.dataSource = self
        rightTableView.delegate = self
        view.addSubview(rightTableView)
        
        //New segment field
        newSegmentField.frame = newElementField.frame
        newSegmentField.delegate = self
        
        //Additional
        newElementField.frame.origin.x = rightTableView.frame.origin.x
        
        iconImagePickerView.frame = CGRect(x: segmentImage.frame.origin.x, y: 25, width: segmentImage.frame.width, height: segmentImage.frame.height)
        iconImagePickerView.frame.size.height = segmentImage.frame.height * 3
        iconImagePickerView.layer.opacity = 0
        iconImagePickerView.isUserInteractionEnabled = false
        iconImagePickerView.layer.cornerRadius = segmentImage.frame.width / 2
        iconImagePickerView.transform = CGAffineTransform.init(rotationAngle: -(CGFloat.pi / 2))
        
        shouldFieldCoverDisplay()
        
        setupView()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    
    @objc func addElement() {
        // NEEDS RE-DESIGN
        
//        if newElementField.text != "" {
//            if newSegmentMode {
//                tempArray.append(newElementField.text!)
//            } else {
//                segmentObject.elements.append(newElementField.text!)
//                Global.segmentArray[(leftTableView.indexPathForSelectedRow?.row)!] = segmentObject
//                dataHandle.uploadSegment()
//            }
//            newElementField.text = ""
//            rightTableView.reloadData()
//        }
    }
    
    @objc func newSegment() {
        
        newSegmentButton.isUserInteractionEnabled = false
        newSegmentMode = true
        leftTableView.isUserInteractionEnabled = false
        
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
        
        // Icon Picker
        iconImagePickerView.isUserInteractionEnabled = true
        view.addSubview(iconImagePickerView)
        
        shouldFieldCoverDisplay()
        
        //Animations
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            
            self.newElementField.frame.origin.y = self.newElementField.frame.origin.y + 50
            self.rightTableView.frame.origin.y = self.rightTableView.frame.origin.y + 50
            self.newSegmentButton.layer.opacity = 0.3
            self.leftTableView.layer.opacity = 0.3
            self.leftTopLabel.layer.opacity = 0.3
            self.iconImagePickerView.layer.opacity = 1
            self.segmentImage.image = nil
            self.segmentImage.center.x = self.rightTableView.center.x
            self.segmentLabel.layer.opacity = 0
            self.iconImagePickerView.frame.origin.x += self.iconImagePickerView.frame.width / 3
            
        }, completion: {(finished: Bool) in
            
            
        })
        
        
    }
    
    @objc func cancelCreate() {
        
        newSegmentMode = false
        cancelButton.removeFromSuperview()
        doneButton.removeFromSuperview()
        self.segmentLabel.text = self.segmentObject.title
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
            self.iconImagePickerView.layer.opacity = 0
            self.segmentImage.frame.origin.x = self.leftTableView.frame.maxX + 50
            self.segmentLabel.layer.opacity = 1
            self.iconImagePickerView.frame.origin.x -= self.iconImagePickerView.frame.width / 3
            
            if !Global.segmentArray.isEmpty {
                //self.segmentImage.image = Global.segmentArray[Global.segmentArray.count - 1].iconImage
            }
            
            self.shouldFieldCoverDisplay()
            
        }, completion: {(finished: Bool) in
            
            self.newSegmentField.removeFromSuperview()
            self.rightTableView.reloadData()
            self.newSegmentButton.isUserInteractionEnabled = true
            self.leftTableView.isUserInteractionEnabled = true
            self.iconImagePickerView.removeFromSuperview()
            
            
        })
        
        
    }
    
    @objc func doneCreate() {

        if newSegmentField.text != "" && !tempArray.isEmpty {
            //let newSegment = Segment(title: newSegmentField.text!)
            //Global.segmentArray.append(newSegment)
            dataHandle.uploadSegment()
            leftTableView.reloadData()
            cancelCreate()
        } else {
            
            let alertTitle: String = "Missing Requiered Fields"
            var alertMessage: String = ""
            
            if newSegmentField.text == "" {
                newSegmentField.layer.borderWidth = 3
                newSegmentField.layer.borderColor = UIColor.red.cgColor
                alertMessage += "- Segment Name."
            } else {
                newSegmentField.layer.borderWidth = 0
                newSegmentField.layer.borderColor = UIColor.clear.cgColor
            }
            if tempArray.isEmpty {
                rightTableView.layer.borderWidth = 3
                rightTableView.layer.borderColor = UIColor.red.cgColor
                alertMessage += "\n- Elements."
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
//        if tableView == leftTableView {
//            return Global.segmentArray.count
//        } else {
//            if newSegmentMode {
//                return tempArray.count
//            } else {
//                return (segmentObject.elements?.count)!
//            }
//        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            let cell: SegmentCell = SegmentCell(segment: Global.segmentArray[indexPath.row], reuseIdentifier: "leftCell")
            return cell
        } else {
            let cell = rightTableView.dequeueReusableCell(withIdentifier: "rightCell", for: indexPath)
            if newSegmentMode {
                cell.textLabel?.text = tempArray[indexPath.row].title
            } else {
                //cell.textLabel?.text = segmentObject.elements[indexPath.row].title
            }
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            segmentObject = Global.segmentArray[indexPath.row]
            segmentLabel.text = segmentObject.title
            //segmentImage.image = Global.segmentArray[indexPath.row].iconImage
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
                    //segmentObject.elements.remove(at: indexPath.row)
                    dataHandle.uploadSegment()
                    tempArray.removeAll()
                    rightTableView.reloadData()
                
                }
                rightTableView.reloadData()
            }
        } else {
        
            Global.segmentArray.remove(at: indexPath.row)
            dataHandle.uploadSegment()
            leftTableView.reloadData()
            leftTableView.selectRow(at: myIndexPath, animated: true, scrollPosition: .none)
            shouldFieldCoverDisplay()
            
        }
        
    }
    
    @objc func segmentImagePressed() {
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func setupView() {
        
        if !Global.segmentArray.isEmpty {
            
            leftTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected = true
            leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
            segmentLabel.text = Global.segmentArray[0].title
            segmentObject = Global.segmentArray[0]
            rightTableView.reloadData()
            
        }
        
    }
    
    func shouldFieldCoverDisplay() {
        
        if Global.segmentArray.isEmpty {
            
            if newSegmentMode {
                UIView.animate(withDuration: 0.5, animations: {
                    self.fieldCover.frame.origin.x = self.view.frame.width
                })
                
                fieldCover.removeFromSuperview()
            } else {
                fieldCover = FieldCover(displayMessage: "Create a new Segment to begin.", frame: CGRect(x: leftTopLabel.frame.maxX, y: leftTopLabel.frame.origin.y, width: view.frame.width - leftTopLabel.frame.width, height: leftTopLabel.frame.height + leftTableView.frame.height))
                
                view.addSubview(fieldCover)
            }
        } else {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.fieldCover.frame.origin.x = self.view.frame.width
                })
    
            fieldCover.removeFromSuperview()
            
        }
        
    }
    
    
}
