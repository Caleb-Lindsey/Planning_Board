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
struct productCellData {
    var cell: Int!
    var title: String!
    var hostButton: UIButton!
    var descriptionButton: UIButton!
    var timeButton: UIButton!
}

class PlanServiceController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Variables
    var arrayOfCellData = [cellData]()
    var arrayOfProductData = [productCellData]()
    var elementArray = [String]()
    var productArray = [String]()
    var count : Int = 0
    var currentLoaded = String()
    var currentSeg = SegmentObject()
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    var segmentPath : Int = Int()
    
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
    
    let previewButton : UIButton = {
        let button = UIButton()
        button.setTitle("Preview", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = GlobalVariables.greenColor
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
            previewButton.frame = CGRect(x: productTable.frame.origin.x, y: productTable.frame.maxY + 15, width: productTable.frame.width, height: 30)
            view.addSubview(previewButton)
            
            //Additional
            elementTable.frame.origin.y = productTable.frame.origin.y
            
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
                
                if self.elementArray[elementNum] == self.productArray[productNum] {
                    self.elementTable.cellForRow(at: NSIndexPath(row: elementNum, section: 0) as IndexPath)?.accessoryType = .checkmark
                }
                
            }
            
        }
        
    }
    
    func removeFromProduct(indexPath : IndexPath) {
        
        for num in 0..<productArray.count {
            if productArray[num] == elementArray[indexPath.row] {
                productArray.remove(at: num)
                if productArray.count <= 17 {
                    productTable.isScrollEnabled = false
                }
                productTable.reloadData()
                break
            }
        }
        
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
            cell?.textLabel?.text = productArray[indexPath.row]
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
                
                productArray.append((elementTable.cellForRow(at: indexPath)?.textLabel?.text)!)
                if productArray.count > 17 {
                    productTable.isScrollEnabled = true
                }
                productTable.reloadData()
            } else {
                elementTable.cellForRow(at: indexPath)?.accessoryType = .none
                removeFromProduct(indexPath: indexPath)
            }
        } else if tableView == productTable {
            print("hello")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == elementTable {
            elementTable.cellForRow(at: indexPath)?.accessoryType = .none
            removeFromProduct(indexPath: indexPath)
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == elementTable {
            return 1
        } else {
            return 1
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
        } else {
            return "My Service"
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
        
        if tableView != productTable {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        let itemToMove:String = productArray[sourceIndexPath.row]
        productArray.remove(at: sourceIndexPath.row)
        productArray.insert(itemToMove, at: destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        if tableView != productTable {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let timeAction = UITableViewRowAction(style: .normal, title: "time") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
            print("time pressed")
        }
        timeAction.backgroundColor = .lightGray
        
        let hostAction = UITableViewRowAction(style: .normal, title: "Host") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            
        }
        hostAction.backgroundColor = .lightGray
        
        let removeAction = UITableViewRowAction(style: .normal, title: "Remove") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            self.productArray.remove(at: indexPath.row)
            self.fillTable(segment: self.currentSeg)
            self.productTable.reloadData()
        }
        removeAction.backgroundColor = .red
        
        return [removeAction,timeAction,hostAction]    }
    
}






























