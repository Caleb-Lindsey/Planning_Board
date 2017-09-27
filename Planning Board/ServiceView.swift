//
//  LandingView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import Firebase

class ServiceView : PBViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Variables
    let myIndexPath = IndexPath(row: 0, section: 0)
    let dataHandle = Datasource()
    let formatter = DateFormatter()

    //Left Side
    let leftTopLabel : UILabel = {
        let label = UILabel()
        label.text = "Services"
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
    
    let segmentControl : UISegmentedControl = {
        let controller = UISegmentedControl(items: ["Most Recent","ABC"])
        controller.selectedSegmentIndex = 0
        controller.tintColor = GlobalVariables.greenColor
        controller.backgroundColor = GlobalVariables.grayColor
        controller.addTarget(self, action: #selector(orderServiceArray), for: .valueChanged)
        return controller
    }()
    
    let leftTableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let newSegmentButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus4"), for: .normal)
        button.addTarget(self, action: #selector(newService), for: .touchUpInside)
        return button
    }()
    
    let detailButton : UIButton = {
        let button = UIButton()
        button.setTitle("View Service Detail", for: .normal)
        button.backgroundColor = GlobalVariables.greenColor
        button.titleLabel?.textColor = UIColor.white
        button.layer.cornerRadius = 10
        return button
    }()
    
    //Right side
    let rightTopLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Helvetica", size: 22)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.3
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.text = "[Date]"
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.2
        return label
    }()
    
    let summaryView : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        textView.font = UIFont(name: "Helvetica", size: 16)
        textView.isEditable = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBar.backgroundColor = UIColor.clear
        formatter.dateFormat = "MM-dd-yyyy"
        
        GlobalVariables.userName = UserDefaults.standard.value(forKey: "username") as! String
        
        if let window = UIApplication.shared.keyWindow {
        
            let statusBarHeight = statusBar.frame.height

            //Place left top label
            leftTopLabel.frame = CGRect(x: 0, y: statusBarHeight, width: window.frame.width * (4/10), height: 75)
            view.addSubview(leftTopLabel)
            
            //Place segment control
            segmentControl.frame = CGRect(x: 0, y: leftTopLabel.frame.maxY, width: window.frame.width * (4/10), height: 35)
            view.addSubview(segmentControl)
            
            //Place left table view
            leftTableView.frame = CGRect(x: 0, y: segmentControl.frame.maxY, width: window.frame.width * (4/10), height: window.frame.height - statusBarHeight - (tabBarController?.tabBar.frame.height)!)
            leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "leftCell")
            leftTableView.dataSource = self
            leftTableView.delegate = self
            view.addSubview(leftTableView)
            
            //Place new segment button
            newSegmentButton.frame = CGRect(x: leftTopLabel.frame.width - 35 - 20, y: 0, width: 35, height: 35)
            newSegmentButton.center.y = leftTopLabel.frame.height / 2
            leftTopLabel.addSubview(newSegmentButton)
            
            //Place right top label
            rightTopLabel.frame = CGRect(x: leftTopLabel.frame.maxX, y: statusBarHeight, width: window.frame.width * (6/10), height: 75)
            view.addSubview(rightTopLabel)
            
            //Place date label
            dateLabel.frame = CGRect(x: 0, y: rightTopLabel.frame.maxY, width: rightTopLabel.frame.width - 15, height: 50)
            dateLabel.center.x = rightTopLabel.center.x - 15
            view.addSubview(dateLabel)
            
            //Place summary view
            summaryView.frame = CGRect(x: 0, y: dateLabel.frame.maxY, width: window.frame.width * (5/10), height: window.frame.height / 1.4)
            summaryView.center.x = rightTopLabel.center.x
            view.addSubview(summaryView)
            
            //Place detail button
            detailButton.frame = CGRect(x: summaryView.frame.maxX - summaryView.frame.width / 2, y: summaryView.frame.maxY + 25, width: summaryView.frame.width / 2, height: 35)
            //view.addSubview(detailButton)
            
            
        }
        
        loadServices()
        
        
    }
    
    func newService() {
        
        let planServiceView : UIViewController = PlanServiceController()
        self.navigationController?.pushViewController(planServiceView, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.arrayOfServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leftTableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath)
        cell.textLabel?.text = GlobalVariables.arrayOfServices[indexPath.row].title
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        summaryView.text = GlobalVariables.arrayOfServices[indexPath.row].summary
        rightTopLabel.text = GlobalVariables.arrayOfServices[indexPath.row].title
        
        let dateString = formatter.string(from: GlobalVariables.arrayOfServices[indexPath.row].date)
        dateLabel.text = dateString
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        leftTableView.reloadData()
    }
    
    func loadServices() {
        
        dataHandle.fillServiceData()
        dataHandle.fillSegmentData()
        dataHandle.fillMemberData()
        
        leftTableView.reloadData()
        leftTableView.selectRow(at: myIndexPath, animated: true, scrollPosition: .none)
        
        if GlobalVariables.arrayOfServices != [] {
            
            summaryView.text = GlobalVariables.arrayOfServices[0].summary
            let dateString = formatter.string(from: GlobalVariables.arrayOfServices[0].date)
            dateLabel.text = dateString
            rightTopLabel.text = GlobalVariables.arrayOfServices[0].title
            if segmentControl.selectedSegmentIndex == 0 && GlobalVariables.arrayOfServices.count > 2 {
                orderServiceArrayByDate(array: &GlobalVariables.arrayOfServices)
            }
            
        }
        
    }
    
    func orderServiceArray() {
        
        if segmentControl.selectedSegmentIndex == 0 && GlobalVariables.arrayOfServices.count > 2 {
            orderServiceArrayByDate(array: &GlobalVariables.arrayOfServices)
        } else if segmentControl.selectedSegmentIndex == 1 && GlobalVariables.arrayOfServices.count > 2 {
            orderServiceArrayAlphabetically()
        }
        
        leftTableView.reloadData()
        
    }
    
    func orderServiceArrayByDate(array:inout [ServiceObject]) {
        
        let arrayCount = array.count
        
        
        for value in 1...arrayCount - 1 {
            if array[value - 1].date > array[value].date {
                let largerValue = array[value - 1]
                array[value - 1] = array[value]
                array[value] = largerValue
            }
        }
        
        
        
        
    }
    
    func orderServiceArrayAlphabetically() {
        
        GlobalVariables.arrayOfServices.sort { $0.title < $1.title }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if tableView == leftTableView {
            if editingStyle == .delete {
                
                GlobalVariables.arrayOfServices.remove(at: indexPath.row)
                leftTableView.reloadData()
                dataHandle.uploadService()
                
            }
        }
        
    }
    
}













