//
//  PlanServiceController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 1/11/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation
import Firebase

struct cellData {
    
    var cell : Int!
    var text : String!
    var image : UIImage!
    
}

class PlanServiceController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Outlets
    @IBOutlet weak var segmentTable: UITableView!
    @IBOutlet weak var elementTable: UITableView!
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var topProductButton: UIButton!
    
    //Variables
    var arrayOfCellData = [cellData]()
    var elementArray = [String]()
    var productArray = [String]()
    var count : Int = 0
    var currentLoaded = String()
    var elementDict = Dictionary<String,Array<String>>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up tables
        segmentTable.tableFooterView = UIImageView()
        segmentTable.register(UITableViewCell.self, forCellReuseIdentifier: "segmentCell")
        elementTable.tableFooterView = UIImageView()
        elementTable.allowsMultipleSelection = true
        elementTable.isScrollEnabled = false
        elementTable.layer.cornerRadius = 10
        elementTable.register(UITableViewCell.self, forCellReuseIdentifier: "elementCell")
        productTable.isScrollEnabled = false
        productTable.layer.cornerRadius = 10
        productTable.register(UITableViewCell.self, forCellReuseIdentifier: "productCell")
        
        elementArray = ["Element 1","Element 2","Element 3","Element 4","Element 5","Element 6","Element 7"]
        productArray = []
        
        if GlobalVariables.segmentArray != [] {
            
            currentLoaded = GlobalVariables.segmentArray[0]
            fillTable(tableName: GlobalVariables.segmentArray[0])
            
            while count < GlobalVariables.segmentArray.count {
            
                arrayOfCellData.append(cellData(cell: 1, text: GlobalVariables.segmentArray[count], image: UIImage.init(named: "dove")))
                
                count += 1
            
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let indexPath = IndexPath(row: 0, section: 0)
        segmentTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editServiceOrderPressed(_ sender: Any) {
        
        if productTable.isEditing {
            productTable.setEditing(false, animated: true)
            topProductButton.setTitle("Edit Service Order", for: .normal)
        } else {
            productTable.setEditing(true, animated: true)
            topProductButton.setTitle("Done", for: .normal)
        }
    }
    
    func fillTable(tableName : String) {
        
        let databaseRef = FIRDatabase.database().reference()
        var currentArray = [String]()
        
        databaseRef.child(GlobalVariables.userName).child("Service Parts").child(tableName).observe(.childAdded, with: {
            snapshot in
            
            let value = snapshot.value!
            currentArray.append(value as! String)
            self.elementDict[tableName]?.append(value as! String)
            
            self.elementArray = currentArray
            if currentArray.count > 10 {
                self.elementTable.isScrollEnabled = true
            } else {
                self.elementTable.isScrollEnabled = false
            }
            self.elementTable.reloadData()
            
            //Apply Checkmarks to previously selected rows
            for elementNum in 0..<self.elementArray.count {
                for productNum in 0..<self.productArray.count {
                    
                    if self.elementArray[elementNum] == self.productArray[productNum] {
                        self.elementTable.cellForRow(at: NSIndexPath(row: elementNum, section: 0) as IndexPath)?.accessoryType = .checkmark
                        
                    }
                    
                }
                
            }
            
        })
        
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
            cell?.indentationWidth = 20.0
            cell?.indentationLevel = 2
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
    
                if currentLoaded != GlobalVariables.segmentArray[indexPath.row] {
                    
                    //Load the tableview using the element array
                    fillTable(tableName: GlobalVariables.segmentArray[indexPath.row])
                    currentLoaded = GlobalVariables.segmentArray[indexPath.row]
                    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == productTable {
            if editingStyle == .delete {
                productArray.remove(at: indexPath.row)
                fillTable(tableName: currentLoaded)
                if productArray.count <= 17 {
                    productTable.isScrollEnabled = false
                }
                productTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if productTable.isEditing == false {
            return .delete
        } else {
            return .none
        }
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
    
}




