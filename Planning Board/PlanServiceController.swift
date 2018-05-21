//
//  PlanServiceController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 1/11/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class PlanServiceController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Variables
    let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
    var selectedSegment : Segment!
    var elementArray = [Element]()
    var productArray = [ProductItem]()
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
        let topBorder = (self.navigationController?.navigationBar.frame.height)! + (statusBar.frame.height)
        setupTables()
        
        //Place segment table
        segmentTable.frame = CGRect(x: 0, y: topBorder + 65, width: 100, height: view.frame.height - topBorder - 65)
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
        productTable.frame = CGRect(x: elementTable.frame.maxX + 25, y: segmentTable.frame.origin.y, width: view.frame.width * (4.5/10), height: view.frame.height * (7.5/10))
        productTable.layer.cornerRadius = 10
        productTable.register(UITableViewCell.self, forCellReuseIdentifier: "productCell")
        productTable.delegate = self
        productTable.dataSource = self
        view.addSubview(productTable)
        
        //Place complete button
        continueButton.frame = CGRect(x: productTable.frame.origin.x, y: productTable.frame.maxY + 15, width: productTable.frame.width, height: 30)
        view.addSubview(continueButton)
        
        let indexPath = IndexPath(row: 0, section: 0)
        segmentTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        elementTable.reloadData()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.hidesBackButton = false
        statusBar.backgroundColor = Global.grayColor
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == segmentTable {
            return Global.segmentArray.count
        } else if tableView == elementTable {
            return elementArray.count
        } else {
            return productArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == segmentTable {
            let cell = PlannerSegmentCell(segment: Global.segmentArray[indexPath.row], reuseIdentifier: "plannerSegmentCell")
            return cell
        } else if tableView == elementTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell")
            cell?.textLabel?.text = elementArray[indexPath.row].title
            return cell!
        } else {
            let cell : ProductCell = ProductCell(productItem: productArray[indexPath.row], reuseIdentifier: "productCell", tableView: productTable)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == segmentTable {
            return 90
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case segmentTable:
            selectedSegment = Global.segmentArray[indexPath.row]
            elementArray = selectedSegment.elements
            elementTable.reloadData()
        case elementTable:
            let newProduct = ProductItem(element: elementArray[indexPath.row])
            if productArray.isEmpty {
                productArray = [newProduct]
            } else {
                productArray.append(newProduct)
            }
            productTable.reloadData()
        case productTable:
            let productItem : ProductItem = productArray[indexPath.row]
            let productPanel : ProductPanel = ProductPanel(productItem: productItem, superView: self.productTable)
            self.productTable.addSubview(productPanel)
            productPanel.animateIntoView()
        default:
            print("error")
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == segmentTable {
            return "Segments"
        } else if tableView == elementTable {
            return "Elements"
        } else {
            return "My Service"
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
    
    func setupTables() {
        if let segment = Global.segmentArray.first {
            selectedSegment = segment
            elementArray = selectedSegment.elements
            elementTable.reloadData()
        }
    }
    
    @objc func continueToFinal() {
        self.navigationController?.pushViewController(FinalService(), animated: true)
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
