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
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    var arrayOfCellData = [cellData]()
    var elementArray = [String]()
    var productArray = [ProductItem]()
    var count : Int = 0
    var currentLoaded = String()
    var currentSeg = SegmentObject()
    var segmentPath : Int = Int()
    let minutes = Array(0...90)
    let seconds = Array(0...59)
    var detailsViewIsVisible : Bool = false
    var selectedItem : ProductItem!
    var selectedHost : Member?
    let paddingView = UIEdgeInsetsMake(5, 10, 5, 10)
    var hostArray : [Member] = [Member]()
    var initialIndexPath : IndexPath!
    
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
        return table
    }()
    
    let continueButton : UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = Global.greenColor
        button.addTarget(self, action: #selector(continueToFinal), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let detailsView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.borderColor = Global.greenColor.cgColor
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
    
    let hostTable : UITableView = {
        let table = UITableView()
        return table
    }()
    
    let detailDescription : UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.textColor = UIColor.lightGray
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    let notesLabel : UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.textColor = UIColor.white
        label.textAlignment = .left
        return label
    }()
    
    let syncButton : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = UIColor.gray
        button.titleLabel?.textColor = UIColor.white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(syncDetails), for: .touchUpInside)
        return button
    }()
    
    let ElementSegmentControl : UISegmentedControl = {
        let controller = UISegmentedControl(items: ["Most Recent","ABC"])
        controller.selectedSegmentIndex = 0
        controller.tintColor = Global.greenColor
        controller.backgroundColor = Global.grayColor
        controller.layer.opacity = 0
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(gestureRecognizer:)))
        productTable.addGestureRecognizer(longpress)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Setup View
        view.backgroundColor = Global.grayColor
        self.navigationItem.title = "Create Service"
        self.navigationController?.navigationBar.barTintColor = Global.grayColor
        self.navigationController?.navigationBar.tintColor = Global.lighterGreenColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        if Global.segObjArr != [] {
            
            currentLoaded = Global.segObjArr[0].name
            currentSeg = Global.segObjArr[0]
            fillTable(segment: Global.segObjArr[0])
            
            while count < Global.segObjArr.count {
            
                arrayOfCellData.append(cellData(cell: 1, text: Global.segObjArr[count].name, image: Global.segObjArr[count].iconImage))
                
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
            elementTable.register(UITableViewCell.self, forCellReuseIdentifier: "elementCell")
            elementTable.delegate = self
            elementTable.dataSource = self
            view.addSubview(elementTable)
            
            //Place product table
            productTable.frame = CGRect(x: elementTable.frame.maxX + 25, y: segmentTable.frame.origin.y, width: window.frame.width * (4.5/10), height: window.frame.height * (7.5/10))
            productTable.layer.cornerRadius = 10
            productTable.register(UITableViewCell.self, forCellReuseIdentifier: "productCell")
            productTable.delegate = self
            productTable.dataSource = self
            view.addSubview(productTable)
            
            //Place complete button
            continueButton.frame = CGRect(x: productTable.frame.origin.x, y: productTable.frame.maxY + 15, width: productTable.frame.width, height: 30)
            view.addSubview(continueButton)
            
            //Place details view
            detailsView.frame = CGRect(x: productTable.frame.width, y: 0, width: productTable.frame.width, height: productTable.frame.height)
            productTable.addSubview(detailsView)
            
            //Place back button
            backButton.frame = CGRect(x: 5, y: 25, width: 60, height: 35)
            detailsView.addSubview(backButton)
            
            //Place time picker
            timePicker.frame = CGRect(x: detailsView.frame.width - 85 - 25, y: backButton.frame.maxY + 15, width: 85, height: 50)
            timePicker.delegate = self
            timePicker.dataSource = self
            detailsView.addSubview(timePicker)
            
            //Place detail host table
            hostTable.frame = CGRect(x: 0, y: timePicker.frame.maxY + 15, width: detailsView.frame.width - 30, height: 200)
            hostTable.center.x = detailsView.frame.width / 2
            hostTable.register(UITableViewCell.self, forCellReuseIdentifier: "hostCell")
            hostTable.delegate = self
            hostTable.dataSource = self
            detailsView.addSubview(hostTable)
            
            //Place notes label
            notesLabel.frame = CGRect(x: hostTable.frame.origin.x, y: hostTable.frame.maxY + 15, width: hostTable.frame.width / 2, height: 15)
            detailsView.addSubview(notesLabel)
            
            //Place detail description
            detailDescription.frame = CGRect(x: 0, y: notesLabel.frame.maxY + 2, width: hostTable.frame.width, height: hostTable.frame.height)
            detailDescription.textContainerInset = paddingView
            detailDescription.center.x = hostTable.center.x
            detailsView.addSubview(detailDescription)
            
            //Place sync button
            syncButton.frame = CGRect(x: detailsView.frame.width - 10 - 75, y: detailsView.frame.height - 45 - 10, width: 75, height: 45)
            detailsView.addSubview(syncButton)
            
            //Place element segment control
            ElementSegmentControl.frame = CGRect(x: elementTable.frame.origin.x, y: elementTable.frame.origin.y - 30, width: elementTable.frame.width, height: 35)
            ElementSegmentControl.layer.zPosition = elementTable.layer.zPosition - 1
            view.addSubview(ElementSegmentControl)
            
            //Additional
            elementTable.frame.origin.y = productTable.frame.origin.y
            durationLabel.frame = CGRect(x: timePicker.frame.origin.x - 5 - 80 , y: timePicker.frame.midY - 15, width: 80, height: 30)
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        segmentTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        elementTable.reloadData()
        Global.serviceDetailArray.removeAll()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.hidesBackButton = false
        statusBar.backgroundColor = Global.grayColor
        
    }
    
    func fillTable(segment : SegmentObject) {
        
        currentLoaded = segment.name
        currentSeg = segment
        elementArray = [currentSeg.name] + segment.elements
        elementTable.reloadData()
        
    }
    
    @objc func dismissDetails() {
        
        productTable.separatorStyle = .singleLine
        detailsViewIsVisible = false
        self.productTable.isScrollEnabled = true

        productTable.reloadData()
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            
            self.detailsView.frame.origin.x = self.productTable.frame.width
            
        }, completion: {(finished: Bool) in
            
            self.timePicker.selectRow(0, inComponent: 0, animated: false)
            self.timePicker.selectRow(0, inComponent: 1, animated: false)
            self.hostArray.removeAll()
            self.selectedHost = nil
            self.detailDescription.text = "Additional notes...."
            
        })
        
    }
    
    @objc func syncDetails() {
        
        //Sync Time
        selectedItem.minutes = minutes[timePicker.selectedRow(inComponent: 0)]
        selectedItem.seconds = seconds[timePicker.selectedRow(inComponent: 1)]
        
        //Sync Host     
        if hostTable.indexPathForSelectedRow != nil {
            selectedItem.host = hostArray[(hostTable.indexPathForSelectedRow?.row)!]
        }
        
        
        //Sync Description
        selectedItem.PBdescription = detailDescription.text
        
        //Dismiss
        dismissDetails()
        productTable.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == segmentTable {
            return arrayOfCellData.count
        } else if tableView == elementTable {
            return elementArray.count
        } else if tableView == productTable {
            return productArray.count
        }else {
            return hostArray.count
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
                
                cell.mainImageView.image = #imageLiteral(resourceName: "fire_icon")
                cell.mainLabel.text = arrayOfCellData[indexPath.row].text
                return cell
                
            }
        } else if tableView == elementTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell")
            
            cell?.accessoryType = (cell?.isSelected)! ? .checkmark : .none
            cell?.selectionStyle = .none
            
            cell?.textLabel?.text = elementArray[indexPath.row]
            
            if indexPath.row == 0 {
                cell?.textLabel?.textAlignment = .center
            }
            
            return cell!
        } else if tableView == productTable {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "productCell")
            
            if productArray[indexPath.row].type == "Segment" {
                cell?.indentationWidth = 5
                cell?.indentationLevel = 1
                cell?.textLabel?.text = productArray[indexPath.row].title
                cell?.textLabel?.textColor = UIColor.black
            } else {
                cell?.indentationWidth = 20
                cell?.indentationLevel = 2
                cell?.textLabel?.text = "- " + productArray[indexPath.row].title
                cell?.textLabel?.textColor = UIColor.darkGray
            }
            
            if productArray[indexPath.row].host != nil {
                let title = (cell?.textLabel?.text)! + " (" + (productArray[indexPath.row].host?.fullName())! + ") "
                cell?.textLabel?.text = title
            }
            
            if productArray[indexPath.row].minutes != 0 || productArray[indexPath.row].seconds != 0 {
                
                var minutesLabel = ""
                var secondsLabel = ""
                
                minutesLabel = "\(productArray[indexPath.row].minutes!)"
                
                if productArray[indexPath.row].seconds! < 10 {
                    secondsLabel = "0\(productArray[indexPath.row].seconds!)"
                } else {
                    secondsLabel = "\(productArray[indexPath.row].seconds!)"
                }
                
                let title = "[\(minutesLabel):\(secondsLabel)] | " + (cell?.textLabel?.text)!
        
                cell?.textLabel?.text = title
                
                minutesLabel = ""
                secondsLabel = ""
                
            } else {
                
                if productArray[indexPath.row].type == "Segment" {
                    let title = "        " + (cell?.textLabel?.text)!
                    cell?.textLabel?.text = title
                } else {
                    let title = "      " + (cell?.textLabel?.text)!
                    cell?.textLabel?.text = title
                }
                
            }
            
            cell?.textLabel?.font = UIFont(name: "Helvetica", size: 14)
            cell?.textLabel?.numberOfLines = 2
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hostCell")
            cell?.textLabel?.text = hostArray[indexPath.row].fullName()
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
            if Global.segObjArr != [] {
                
                segmentPath = indexPath.row
                
                if currentLoaded != Global.segObjArr[indexPath.row].name {
                    
                    //Load the tableview using the element array
                    fillTable(segment: Global.segObjArr[indexPath.row])
                    
                }
                
            }
        } else if tableView == elementTable {
            if elementArray != [] {
                
                let newProduct = ProductItem()
                newProduct.title = (elementTable.cellForRow(at: indexPath)?.textLabel?.text!)!
                newProduct.parentSegment = currentSeg.name
                
                if indexPath.row == 0 {
                    newProduct.type = "Segment"
                } else {
                    newProduct.type = "Element"
                }
                
                productArray.append(newProduct)
                productTable.reloadData()
                
            }
            
        } else if tableView == productTable {
            
            productTable.separatorStyle = .none
            selectedItem = productArray[indexPath.row]
            detailsViewIsVisible = true
            
            //Find Hosts
            for host in Global.memberArr {
                
                for segment in host.canHost {
                    if segment == selectedItem.parentSegment {
                        hostArray.append(host)
                    }
                }
                
            }
            
            tableView.reloadData()
            hostTable.reloadData()
            
            //Fill detail view
            timePicker.selectRow(productArray[indexPath.row].minutes!, inComponent: 0, animated: false)
            timePicker.selectRow(productArray[indexPath.row].seconds!, inComponent: 1, animated: false)
            
            var itemCount = 0
            for item in hostArray {
                
                if item.fullName() == productArray[indexPath.row].host?.fullName() {
                    hostTable.selectRow(at: IndexPath(row: itemCount, section: 0), animated: true, scrollPosition: .none)
                }
                itemCount += 1
            }
            
            self.detailsView.frame.origin.y = self.productTable.contentOffset.y
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                
                self.detailsView.frame.origin.x = 0
                self.productTable.isScrollEnabled = false
                
            }, completion: {(finished: Bool) in
                
                
                
            })
            
        } else {
            selectedHost = hostArray[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == segmentTable {
            return "Segments"
        } else if tableView == elementTable {
            if Global.segObjArr != [] {
                if currentLoaded.count > 25 {
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
        
        let duplicateAction = UITableViewRowAction(style: .normal, title: "duplicate") { (rowAction, indexPath) in
            
            self.productArray.append(self.productArray[indexPath.row])
            self.productTable.reloadData()

        }
        
        return [removeAction, duplicateAction]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == timePicker {
            return 2
        } else {
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return minutes.count
        } else {
            return seconds.count
        }
         
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return String(minutes[row])
        } else {
            return String(seconds[row])
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
        
        if component == 0 {
            label.text = "\(minutes[row])"
        } else {
            label.text = "\(seconds[row])"
        }
        
        return label
    }
    
    @objc func continueToFinal() {
        
        for line in 0..<productArray.count {
            Global.serviceDetailArray.append(productArray[line])
        }
        
        self.navigationController?.pushViewController(FinalService(), animated: true)
        
    }
    
    func orderElementArray() {
        
        if ElementSegmentControl.selectedSegmentIndex == 0 {
            orderElementsByDate()
        } else {
            orderElementsAlph()
        }
        
        elementTable.reloadData()
        
    }
    
    func orderElementsByDate() {
        
    }
    
    func orderElementsAlph() {
        elementArray.sort { $0 < $1 }
    }
    
    @objc func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: productTable)
        let indexPath = productTable.indexPathForRow(at: locationInView)
        
        struct My {
            static var cellSnapshot : UIView? = nil
            static var cellIsAnimating : Bool = false
            static var cellNeedToShow : Bool = false
        }
        struct Path {
            static var initialIndexPath : NSIndexPath? = nil
        }
        
        switch state {
        case UIGestureRecognizerState.began:
            if indexPath != nil {
                initialIndexPath = indexPath
                let cell = productTable.cellForRow(at: indexPath!) as UITableViewCell?
                My.cellSnapshot  = snapshopOfCell(inputView: cell!)
                
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                productTable
                    .addSubview(My.cellSnapshot!)
                
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    center?.y = locationInView.y
                    My.cellIsAnimating = true
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell?.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        My.cellIsAnimating = false
                        if My.cellNeedToShow {
                            My.cellNeedToShow = false
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                cell?.alpha = 1
                            })
                        } else {
                            cell?.isHidden = true
                        }
                    }
                })
            }
            
        case UIGestureRecognizerState.changed:
            if My.cellSnapshot != nil {
                var center = My.cellSnapshot!.center
                center.y = locationInView.y
                My.cellSnapshot!.center = center
                
                if ((indexPath != nil) && (indexPath != initialIndexPath)) {
                    productArray.insert(productArray.remove(at: initialIndexPath!.row), at: indexPath!.row)
                    productTable.moveRow(at: initialIndexPath! as IndexPath, to: indexPath!)
                    initialIndexPath = indexPath
                }
            }
        default:
            if initialIndexPath != nil {
                let cell = productTable.cellForRow(at: initialIndexPath! as IndexPath) as UITableViewCell?
                if My.cellIsAnimating {
                    My.cellNeedToShow = true
                } else {
                    cell?.isHidden = false
                    cell?.alpha = 0.0
                }
                
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = (cell?.center)!
                    My.cellSnapshot!.transform = CGAffineTransform.identity
                    My.cellSnapshot!.alpha = 0.0
                    cell?.alpha = 1.0
                    
                }, completion: { (finished) -> Void in
                    if finished {
                        self.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                    }
                })
            }
        }
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
}
    






















