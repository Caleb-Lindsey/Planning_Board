//
//  ManageSegmentsController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ManageSegmentsController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Variables
    let elementMenu = ResourceAddition(type: "Segment")
    
    //Setup Left Segments Area
    let segmentView : UIView = {
        let segView = UIView()
        segView.backgroundColor = UIColor.lightGray
        segView.layer.zPosition = 10
        return segView
    }()
    
    let segTable : UITableView = {
        let segTab = UITableView()
        segTab.layer.zPosition = 12
        return segTab
    }()
    
    let addSegmentButton : UIButton = {
       
        let addSegBttn = UIButton()
        addSegBttn.setImage(#imageLiteral(resourceName: "compose_button"), for: .normal)
        return addSegBttn
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        placeInterface()
        elementMenu.launchResourceView()
        
        //Setup Left Segment TABLE
        segTable.register(UITableViewCell.self, forCellReuseIdentifier: "manageSegCell")
        segTable.delegate = self
        segTable.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let indexPath = IndexPath(row: 0, section: 0)
        segTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }
    
    
    @IBAction func newSegmentPressed(_ sender: Any) {
        
        
        
    }
    
    func placeInterface() {
        
        if let window = UIApplication.shared.keyWindow {
            
            window.addSubview(segmentView)
            segmentView.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: 360, height: window.frame.height - (navigationController?.navigationBar.frame.maxY)!)
            segmentView.layer.borderWidth = 2
            
            segmentView.addSubview(segTable)
            segTable.frame = CGRect(x: 0, y: 75, width: 360, height: segmentView.frame.height - 75)
            
            segmentView.addSubview(addSegmentButton)
            addSegmentButton.frame = CGRect(x: segmentView.frame.width - 15 - 30, y: (segmentView.frame.height - segTable.frame.height) / 2 - 15, width: 30, height: 30)
            //addSegmentButton.addTarget(self, action: #selector(), for: .touchUpInside)
            
            }
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = segTable.dequeueReusableCell(withIdentifier: "manageSegCell", for: indexPath)
        cell.textLabel?.text = GlobalVariables.segObjArr[indexPath.row].name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.segObjArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func viewWillDisappear(_ animated: Bool) {
        elementMenu.checkAnimation.checkImageView.removeFromSuperview()
        segTable.removeFromSuperview()
        segmentView.removeFromSuperview()
        elementMenu.addResourceView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        elementMenu.slideSegment(segment: GlobalVariables.segObjArr[indexPath.row])
        
        
    }
    
}
















