//
//  LandingView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import MessageUI

class ServiceView : PBViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    //Variables
    let dataHandle = Datasource()

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
        
        setupView(row: 0)
        
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
        setupView(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Global.arrayOfServices.remove(at: indexPath.row)
            leftTableView.reloadData()
            dataHandle.saveServicesToFile(services: Global.arrayOfServices)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        leftTableView.reloadData()
    }
    
    @objc func newService() {
        self.navigationController?.pushViewController(PlanServiceController(), animated: true)
    }
    
    func setupView(row: Int) {
        if !Global.arrayOfServices.isEmpty {
            let thisService : Service = Global.arrayOfServices[row]
            summaryView.text = thisService.summary
            rightTopLabel.text = thisService.title
            dateLabel.text = thisService.getFormattedDate()
        }
    }
    
    @objc func emailService() {
//        if serviceTitle.text != "" && serviceView.text != "" {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MM-dd-yyyy"
//            let dateString = formatter.string(from: datePicker.date)
//            
//            let mailController : MFMailComposeViewController = MFMailComposeViewController()
//            mailController.mailComposeDelegate = self
//            mailController.setSubject("\(serviceTitle.text!)  (\(dateString))")
//            mailController.setMessageBody(serviceView.text!, isHTML: false)
//            
//            self.present(mailController, animated: true, completion: nil)
        }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .sent {
            controller.dismiss(animated: true, completion: {
                
            })
        } else {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
}
