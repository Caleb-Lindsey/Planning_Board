//
//  LandingView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import Firebase

class LandingView : PBViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Variables
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var dimmerView : UIView = UIView()
    let myIndexPath = IndexPath(row: 0, section: 0)
    let dataHandle = Datasource()

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
        label.text = "Samson - #PushPrayPioneer"
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
        label.text = "3 • 5 • 17"
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
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBar.backgroundColor = UIColor.clear
        
        dimmerView.backgroundColor = UIColor.black
        dimmerView.layer.opacity = 0.5
        dimmerView.frame = view.frame
        view.addSubview(dimmerView)
        
        GlobalVariables.userName = UserDefaults.standard.value(forKey: "username") as! String
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        if let window = UIApplication.shared.keyWindow {
        
            let statusBarHeight = statusBar.frame.height

            //Place left top label
            leftTopLabel.frame = CGRect(x: 0, y: statusBarHeight, width: window.frame.width * (4/10), height: 75)
            view.addSubview(leftTopLabel)
            
            //Place left table view
            leftTableView.frame = CGRect(x: 0, y: leftTopLabel.frame.maxY, width: window.frame.width * (4/10), height: window.frame.height - statusBarHeight - (tabBarController?.tabBar.frame.height)!)
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
            
            //MOCK
            let tab : String = "    "
            summaryView.text = "8:25am\(tab) | Locker Room" +
                            "\n\n8:45am\(tab) | Walk-In\n" +
                            "\n\n9:02am\(tab) | Worship Bumper" +
                            "\n\n9:02am\(tab) | Worship Set" +
                                "\n\(tab)- Only Wanna Sing (Vinny)" +
                                "\n\(tab) Welcome (Melissa)" +
                                "\n\(tab)- Love So Great (Vinny)" +
                                "\n\(tab)- Open Heaven (Vinny/Melissa)" +
                                "\n\(tab)- Nothing But the Blood Tag (Melissa)" +
                            "\n\n9:20am\(tab) | Transition / Prayer & Praise (P.Nate)" +
                            "\n\n9:24am\(tab) | Highlights (P.Jordan)" +
                            "\n\(tab)Speaker Notes:" +
                                "\n\(tab)- Connect Card" +
                                "\n\(tab)- Growth Track (9am Only)" +
                                "\n\(tab)- Elevate" +
                                "\n\(tab)- Easter Service" +
                            "\n\n9:28am\(tab) | Offering (P.Steve)" +
                            "\n\n9:31am\(tab) | Highlight Videos" +
                            "\n\n9:34am\(tab) | Grace To Grace (Melissa)" +
                            "\n\n9:39am\(tab) | Preching: Pastor Jordan Boyce (35mins)" +
                            "\n\n10:14am\(tab)| Transition To Campuses / Closing Prayer (P. Jordan)" +
                            "\n\n10:15am\(tab)| Open Heaven Tag (Vinny/Melissa)" +
                            "\n\n10:18am\(tab)| Salvation Call (P. Jordan)" +
                            "\n\n10:21am\(tab)| Release"
            
        }
        
        // Pull from Firebase to fill Variables
        dataHandle.fillData {
            
            self.dataHandle.fillMemberData {
                self.dimmerView.removeFromSuperview()
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                GlobalVariables.initialLoadComplete = true
            }
            
        }
        
    }
    
    func newService() {
        
        let planServiceView : UIViewController = PlanServiceController()
        self.navigationController?.pushViewController(planServiceView, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leftTableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath)
        cell.textLabel?.text = "Samson - #PushPrayPioneer"
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
}





























