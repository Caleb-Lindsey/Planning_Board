//
//  PlanServiceController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 1/11/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

struct cellData {
    
    var cell : Int!
    var text : String!
    var image : UIImage!
    
}

class PlanServiceController : UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Variables
    var arrayOfCellData = [cellData]()
    var elementArray = [String]()
    var productArray = [ProductItem]()
    var count : Int = 0
    var currentLoaded = String()
    var currentSeg = SegmentObject()
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    var segmentPath : Int = Int()
    let hours = Array(0...24)
    let minutes = Array(0...59)
    var detailsViewIsVisible : Bool = false
    var selectedItem : ProductItem!
    let keys : [String] = [
        "none",
        "A Major",
        "A#/Bb Major",
        "B Major",
        "C Major",
        "C#/Db Major",
        "D Major",
        "D#/Eb Major",
        "E Major",
        "F Major",
        "F#/Gb Major",
        "G Major",
        "G#/Ab Major"]
    
    let segmentTable : UITableView = {
        let table = UITableView()
        return table
    }()
    
    let elementTable : UITableView = {
        let table = UITableView()
        return table
    }()
    
    let productTable : UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        return table
    }()
    
    let topProductButton : UIButton = {
        let button = UIButton()
        button.setTitle("Edit Service Order", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(editServiceOrder), for: .touchUpInside)
        return button
    }()
    
    let continueButton : UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = GlobalVariables.greenColor
        return button
    }()
    
    let detailsView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.borderColor = GlobalVariables.greenColor.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    let backButton : UIButton = {
        let button = UIButton()
        button.setTitle("<Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(dismissDetails), for: .touchUpInside)
        return button
    }()
    
    let durationLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Duration:"
        return label
    }()
    
    let timePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.layer.borderColor = UIColor.black.cgColor
        picker.layer.borderWidth = 1
        return picker
    }()
    
    let keyLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "In the key of:"
        return label
    }()
    
    let keyPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.layer.borderColor = UIColor.black.cgColor
        picker.layer.borderWidth = 1
        
        return picker
    }()
    
    let hostTable : UITableView = {
        let table = UITableView()
        return table
    }()
    
    let detailDescription : UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    let syncButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sync", for: .normal)
        button.backgroundColor = UIColor.gray
        button.titleLabel?.textColor = UIColor.white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(syncDetails), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Setup View
        view.backgroundColor = GlobalVariables.grayColor
        self.navigationItem.title = "Create Service"
        self.navigationController?.navigationBar.barTintColor = GlobalVariables.grayColor
        self.navigationController?.navigationBar.tintColor = GlobalVariables.lighterGreenColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        elementArray = ["No Elements Available"]
        productArray = []
        
        if GlobalVariables.segmentArray != [] {
            
            currentLoaded = GlobalVariables.segObjArr[0].name
            currentSeg = GlobalVariables.segObjArr[0]
            fillTable(segment: GlobalVariables.segObjArr[0])
            
            while count < GlobalVariables.segmentArray.count {
            
                arrayOfCellData.append(cellData(cell: 1, text: GlobalVariables.segObjArr[count].name, image: GlobalVariables.segObjArr[count].iconImage))
                
                count += 1
            
            }
        }
        
        if let window = UIApplication.shared.keyWindow {
            
            let topBorder = (self.navigationController?.navigationBar.frame.height)! + (statusBar.frame.height)
            
            //Place segment table
            segmentTable.frame = CGRect(x: 0, y: topBorder + 65, width: 100, height: window.frame.height - topBorder - 65)
            segmentTable.tableFooterView = UIImageView()
            segmentTable.register(UITableViewCell.self, forCellReuseIdentifier: "segmentCell")
            segmentTable.delegate = self
            segmentTable.dataSource = self
            view.addSubview(segmentTable)
            
            //Place element table
            elementTable.frame = CGRect(x: segmentTable.frame.maxX + 15, y: segmentTable.frame.origin.y, width: 250, height: segmentTable.frame.height)
            elementTable.tableFooterView = UIImageView()
            elementTable.allowsMultipleSelection = true
            elementTable.isScrollEnabled = false
            elementTable.register(UITableViewCell.self, forCellReuseIdentifier: "elementCell")
            elementTable.delegate = self
            elementTable.dataSource = self
            view.addSubview(elementTable)
            
            //Place product table
            productTable.frame = CGRect(x: elementTable.frame.maxX + 25, y: segmentTable.frame.origin.y, width: window.frame.width * (4.5/10), height: window.frame.height * (7.5/10))
            productTable.isScrollEnabled = false
            productTable.layer.cornerRadius = 10
            productTable.register(UITableViewCell.self, forCellReuseIdentifier: "productCell")
            productTable.delegate = self
            productTable.dataSource = self
            view.addSubview(productTable)
            
            //Place edit button
            topProductButton.frame = CGRect(x: elementTable.frame.maxX + 25, y: topBorder + 32.5, width: 300, height: 30)
            topProductButton.center.x = productTable.center.x
            view.addSubview(topProductButton)
            
            //Place complete button
            continueButton.frame = CGRect(x: productTable.frame.origin.x, y: productTable.frame.maxY + 15, width: productTable.frame.width, height: 30)
            view.addSubview(continueButton)
            
            //Place details view
            detailsView.frame = CGRect(x: productTable.frame.width, y: 0, width: productTable.frame.width, height: productTable.frame.height)
            productTable.addSubview(detailsView)
            
            //Place back button
            backButton.frame = CGRect(x: 5, y: 25, width: 60, height: 35)
            detailsView.addSubview(backButton)
            
            //Place detail time picker
            timePicker.frame = CGRect(x: detailsView.frame.width - 80 - 25, y: backButton.frame.maxY + 15, width: 85, height: 50)
            timePicker.delegate = self
            timePicker.dataSource = self
            detailsView.addSubview(timePicker)
            
            //Place duration and key label
            detailsView.addSubview(durationLabel)
            detailsView.addSubview(keyLabel)
            
            //Place detail key picker
            keyPicker.frame = CGRect(x: detailsView.frame.width - 125 - 25, y: timePicker.frame.maxY + 15, width: 125, height: 50)
            keyPicker.delegate = self
            keyPicker.dataSource = self
            detailsView.addSubview(keyPicker)
            
            //Place detail host table
            hostTable.frame = CGRect(x: 0, y: keyPicker.frame.maxY + 15, width: detailsView.frame.width - 30, height: 200)
            hostTable.center.x = detailsView.frame.width / 2
            hostTable.delegate = self
            hostTable.dataSource = self
            detailsView.addSubview(hostTable)
            
            //Place detail description
            detailDescription.frame = CGRect(x: 0, y: hostTable.frame.maxY + 15, width: hostTable.frame.width, height: hostTable.frame.height)
            detailDescription.center.x = hostTable.center.x
            detailsView.addSubview(detailDescription)
            
            //Place sync button
            syncButton.frame = CGRect(x: detailsView.frame.width - 10 - 75, y: detailsView.frame.height - 45 - 10, width: 75, height: 45)
            detailsView.addSubview(syncButton)
            
            //Additional
            elementTable.frame.origin.y = productTable.frame.origin.y
            timePicker.frame.origin.x = keyPicker.frame.origin.x
            durationLabel.frame = CGRect(x: timePicker.frame.origin.x - 5 - 80 , y: timePicker.frame.midY - 15, width: 80, height: 30)
            keyLabel.frame = CGRect(x: timePicker.frame.origin.x - 5 - 125 , y: keyPicker.frame.midY - 15, width: 125, height: 30)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.hidesBackButton = false
        statusBar.backgroundColor = GlobalVariables.grayColor
        
        let indexPath = IndexPath(row: 0, section: 0)
        segmentTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
    }
    
    func editServiceOrder() {
        
        if productTable.isEditing {
            productTable.setEditing(false, animated: true)
            topProductButton.setTitle("Edit Service Order", for: .normal)
        } else {
            productTable.setEditing(true, animated: true)
            topProductButton.setTitle("Done", for: .normal)
        }
        
    }
    
    func fillTable(segment : SegmentObject) {
        
        elementArray = segment.elements
        currentLoaded = segment.name
        currentSeg = segment
        elementTable.reloadData()
        
        
        //Apply Checkmarks to previously selected rows
        for elementNum in 0..<self.elementArray.count {
            for productNum in 0..<self.productArray.count {
                
                if self.elementArray[elementNum] == self.productArray[productNum].title {
                    self.elementTable.cellForRow(at: NSIndexPath(row: elementNum, section: 0) as IndexPath)?.accessoryType = .checkmark
                }
                
            }
            
        }
        
    }
    
    func removeFromProduct(indexPath : IndexPath) {
        
        for num in 0..<productArray.count {
            if productArray[num].title == elementArray[indexPath.row] {
                productArray.remove(at: num)
                if productArray.count <= 17 {
                    productTable.isScrollEnabled = false
                }
                productTable.reloadData()
                break
            }
        }
        
    }
    
    func dismissDetails() {
        
        detailsViewIsVisible = false
        productTable.reloadData()
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            
            self.detailsView.frame.origin.x = self.productTable.frame.width
            
        }, completion: {(finished: Bool) in
            
            self.timePicker.selectRow(0, inComponent: 0, animated: false)
            self.timePicker.selectRow(0, inComponent: 1, animated: false)
            self.keyPicker.selectRow(0, inComponent: 0, animated: false)
            
        })
        
    }
    
    func syncDetails() {
        
        //Sync Time
        selectedItem.hours = hours[timePicker.selectedRow(inComponent: 0)]
        selectedItem.minutes = minutes[timePicker.selectedRow(inComponent: 1)]
        print("\(selectedItem.hours!)")
        print("\(selectedItem.minutes!)")
        
        //Sync Key
        selectedItem.songKey = keys[keyPicker.selectedRow(inComponent: 0)]
        print("\(selectedItem.songKey)")
        
        //Sync Host
        
        //Sync Description
        selectedItem.PBdescription = detailDescription.text
        print("\(selectedItem.PBdescription)")
        
        //Dismiss
        dismissDetails()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == segmentTable {
            return arrayOfCellData.count
        } else if tableView == elementTable {
            return elementArray.count
        } else if tableView == productTable {
            return productArray.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == segmentTable {
            if arrayOfCellData[indexPath.row].cell == 1 {
                
                let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
                
                cell.mainImageView.image = arrayOfCellData[indexPath.row].image
                cell.mainLabel.text = arrayOfCellData[indexPath.row].text
                return cell
                
            } else {
                
                let cell = Bundle.main.loadNibNamed("TableViewCell1", owner: self, options: nil)?.first as! TableViewCell1
                
                cell.mainImageView.image = arrayOfCellData[indexPath.row].image
                cell.mainLabel.text = arrayOfCellData[indexPath.row].text
                return cell
                
            }
        } else if tableView == elementTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell") as UITableViewCell!
            
            cell?.accessoryType = (cell?.isSelected)! ? .checkmark : .none
            cell?.selectionStyle = .none
            
            cell?.textLabel?.text = elementArray[indexPath.row]
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as UITableViewCell!
            cell?.textLabel?.text = productArray[indexPath.row].title
            return cell!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == elementTable {
            return 50
        } else if tableView == segmentTable {
            return 90
        }else {
            return 40
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == segmentTable {
            if GlobalVariables.segmentArray != [] {
                
                segmentPath = indexPath.row
                
                if currentLoaded != GlobalVariables.segmentArray[indexPath.row] {
                    
                    //Load the tableview using the element array
                    fillTable(segment: GlobalVariables.segObjArr[indexPath.row])
                    
                }
                
            }
        } else if tableView == elementTable {
            if elementArray != [] && elementTable.cellForRow(at: indexPath)?.accessoryType != .checkmark{
                elementTable.cellForRow(at: indexPath)?.accessoryType = .checkmark
                
                let newProduct = ProductItem()
                newProduct.title = (elementTable.cellForRow(at: indexPath)?.textLabel?.text!)!
                productArray.append(newProduct)
                
                if productArray.count > 17 {
                    productTable.isScrollEnabled = true
                }
                productTable.reloadData()
            } else {
                elementTable.cellForRow(at: indexPath)?.accessoryType = .none
                removeFromProduct(indexPath: indexPath)
            }
        } else if tableView == productTable {
            
            selectedItem = productArray[indexPath.row]
            detailsViewIsVisible = true
            tableView.reloadData()
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                
                self.detailsView.frame.origin.x = 0
                
            }, completion: {(finished: Bool) in
                
                
                
            })
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == elementTable {
            elementTable.cellForRow(at: indexPath)?.accessoryType = .none
            removeFromProduct(indexPath: indexPath)
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == segmentTable {
            return "Segments"
        } else if tableView == elementTable {
            if GlobalVariables.segmentArray != [] {
                if currentLoaded.characters.count > 25 {
                    return currentLoaded
                } else {
                    return "\(currentLoaded) Elements"
                }
            } else {
                return nil
            }
        } else if tableView == productTable {
            if detailsViewIsVisible {
                return selectedItem.title
            } else {
                return "My Service"
            }
        } else {
            return "Select a host"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if tableView == segmentTable {
            if let header = view as? UITableViewHeaderFooterView {
                header.textLabel!.font = UIFont.systemFont(ofSize: 13.0)
                header.textLabel!.textColor = UIColor.white
                header.tintColor = UIColor.darkGray
                header.textLabel?.textAlignment = NSTextAlignment.center
            }
        } else if tableView == elementTable {
            if let header = view as? UITableViewHeaderFooterView {
                header.textLabel!.font = UIFont.systemFont(ofSize: 16.0)
                header.textLabel!.textColor = UIColor.white
                header.tintColor = UIColor.darkGray
                header.textLabel?.textAlignment = NSTextAlignment.center
            }
        } else if tableView == productTable {
            if let header = view as? UITableViewHeaderFooterView {
                header.textLabel!.font = UIFont.systemFont(ofSize: 16.0)
                header.textLabel!.textColor = UIColor.white
                header.tintColor = UIColor.darkGray
                header.textLabel?.textAlignment = NSTextAlignment.center
            }
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return tableView == productTable
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        let itemToMove : ProductItem = productArray.remove(at: sourceIndexPath.row)
        productArray.insert(itemToMove, at: destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return tableView == productTable
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let removeAction = UITableViewRowAction(style: .normal, title: "Remove") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            self.productArray.remove(at: indexPath.row)
            self.fillTable(segment: self.currentSeg)
            self.productTable.reloadData()
        }
        removeAction.backgroundColor = .red
        
        return [removeAction]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == timePicker {
            return 2
        } else {
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == timePicker {
            if component == 0 {
                return hours.count
            } else {
                return minutes.count
            }
        } else {
            return keys.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == timePicker {
            if component == 0 {
                return String(hours[row])
            } else {
                
                return String(minutes[row])
            }
        } else {
            return keys[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 11)
        
        // where data is an Array of String
        if pickerView == timePicker {
            if component == 0 {
                label.text = "\(hours[row])"
            } else {
                label.text = "\(minutes[row])"
            }
        } else {
            label.text = keys[row]
        }
        
        return label
    }
    
}
    

































