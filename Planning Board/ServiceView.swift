//
//  LandingView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

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
        label.font = label.font.withSize(30)
        label.textColor = UIColor.white
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 0.3
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let segmentControl : UISegmentedControl = {
        let controller = UISegmentedControl(items: ["Most Recent","A-Z"])
        controller.selectedSegmentIndex = 0
        controller.tintColor = Global.greenColor
        controller.backgroundColor = Global.grayColor
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
        button.backgroundColor = Global.greenColor
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
        label.text = ""
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
        formatter.dateFormat = "E, M-dd-yy"
        
        let statusBarHeight = statusBar.frame.height

        //Place left top label
        leftTopLabel.frame = CGRect(x: 0, y: statusBarHeight, width: view.frame.width * (4/10), height: 75)
        view.addSubview(leftTopLabel)
        
        //Place segment control
        segmentControl.frame = CGRect(x: 0, y: leftTopLabel.frame.maxY, width: leftTopLabel.frame.width, height: 35)
        view.addSubview(segmentControl)
        
        //Place left table view
        leftTableView.frame = CGRect(x: 0, y: segmentControl.frame.maxY, width: leftTopLabel.frame.width, height: view.frame.height - statusBarHeight - (tabBarController?.tabBar.frame.height)! - leftTopLabel.frame.height - segmentControl.frame.height)
        leftTableView.register(ServiceCell.self, forCellReuseIdentifier: "leftCell")
        leftTableView.dataSource = self
        leftTableView.delegate = self
        view.addSubview(leftTableView)
        
        //Place new segment button
        newSegmentButton.frame = CGRect(x: leftTopLabel.frame.width - 35 - 20, y: 0, width: 35, height: 35)
        newSegmentButton.center.y = leftTopLabel.frame.height / 2
        leftTopLabel.addSubview(newSegmentButton)
        
        //Place right top label
        rightTopLabel.frame = CGRect(x: leftTopLabel.frame.maxX, y: statusBarHeight, width: view.frame.width * (6/10), height: 75)
        view.addSubview(rightTopLabel)
        
        //Place date label
        dateLabel.frame = CGRect(x: 0, y: rightTopLabel.frame.maxY, width: rightTopLabel.frame.width - 15, height: 50)
        dateLabel.center.x = rightTopLabel.center.x - 15
        view.addSubview(dateLabel)
        
        //Place summary view
        summaryView.frame = CGRect(x: 0, y: dateLabel.frame.maxY, width: view.frame.width * (5/10), height: view.frame.height / 1.4)
        summaryView.center.x = rightTopLabel.center.x
        view.addSubview(summaryView)
        
        //Place detail button
        detailButton.frame = CGRect(x: summaryView.frame.maxX - summaryView.frame.width / 2, y: summaryView.frame.maxY + 25, width: summaryView.frame.width / 2, height: 35)
        //view.addSubview(detailButton)
        
        loadServices()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Global.arrayOfServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thisService : Service = Global.arrayOfServices[indexPath.row]
        let cell : ServiceCell = ServiceCell(service: thisService, reuseIdentifier: "leftCell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        summaryView.text = Global.arrayOfServices[indexPath.row].summary
        rightTopLabel.text = Global.arrayOfServices[indexPath.row].title
        dateLabel.text = formatter.string(from: Global.arrayOfServices[indexPath.row].date)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            if editingStyle == .delete {
                Global.arrayOfServices.remove(at: indexPath.row)
                leftTableView.reloadData()
                dataHandle.saveServicesToFile(services: Global.arrayOfServices)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        leftTableView.reloadData()
        setupView()
    }
    
    @objc func newService() {
        let planServiceView : UIViewController = PlanServiceController()
        self.navigationController?.pushViewController(planServiceView, animated: true)
    }
    
    func loadServices() {
        
        leftTableView.selectRow(at: myIndexPath, animated: true, scrollPosition: .none)
        
        if !Global.arrayOfServices.isEmpty {
            summaryView.text = Global.arrayOfServices[0].summary
            let dateString = formatter.string(from: Global.arrayOfServices[0].date)
            dateLabel.text = dateString
            rightTopLabel.text = Global.arrayOfServices[0].title
            if segmentControl.selectedSegmentIndex == 0 && Global.arrayOfServices.count > 2 {
                //orderServiceArrayByDate(array: &GlobalVariables.arrayOfServices)
            }
        }
        
    }
    
    func setupView() {
        if !Global.arrayOfServices.isEmpty {
            leftTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isSelected = true
            leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
}
