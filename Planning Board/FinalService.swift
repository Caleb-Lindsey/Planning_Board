//
//  FinalService.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/14/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class FinalService: UIViewController, UITextFieldDelegate {
    
    //Variables
    let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    let dataHandle = Datasource()
    
    let serviceTitle: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Service Title"
        return textfield
    }()
    
    let serviceView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 0.8
        textView.font = UIFont(name: "Helvetica", size: 16)
        textView.isEditable = false
        textView.isScrollEnabled = true
        return textView
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        picker.minimumDate = Date()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup View
        view.backgroundColor = Colors.grayColor
        self.navigationItem.title = "Finalize Service"
        self.navigationController?.navigationBar.barTintColor = Colors.grayColor
        self.navigationController?.navigationBar.tintColor = Colors.lighterGreenColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        //serviceView.text = formatSummary(serviceArray: Global.serviceDetailArray)
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        let topBorder = (self.navigationController?.navigationBar.frame.height)! + (statusBar.frame.height)
        
        //Place service view
        serviceView.frame = CGRect(x: view.frame.width / 2 - 25, y: topBorder + 45, width: view.frame.width / 2, height: view.frame.height * (7/10))
        view.addSubview(serviceView)
        
        //Place date picker
        datePicker.frame = CGRect(x: 35, y: topBorder + 45, width: view.frame.width - serviceView.frame.width - 50 - 25, height: 100)
        view.addSubview(datePicker)
        
        //Place service title
        serviceTitle.frame = CGRect(x: datePicker.frame.origin.x, y: datePicker.frame.maxY + 25 , width: datePicker.frame.width, height: 35)
        serviceTitle.delegate = self

        view.addSubview(serviceTitle)
    }
    
//    func formatSummary(serviceArray: [ProductItem]) -> String {
//        var summary = String()
//        var line = String()
//
//        for item in 0..<serviceArray.count {
//
//            line = serviceArray[item].title
//
//            if serviceArray[item].type == "Segment" {
//
//                //Add Host
//                if serviceArray[item].host != nil {
//                    line = "\(line)  (\((serviceArray[item].host?.fullName())!))"
//                }
//
//                //Add Time
//                if serviceArray[item].minutes != 0 || serviceArray[item].seconds != 0 {
//
//                    let minutesLabel = "\(serviceArray[item].minutes!)"
//                    var secondsLabel = "\(serviceArray[item].seconds!)"
//                    var tab = "   |   "
//
//                    if serviceArray[item].minutes! < 10 {
//                        tab = "     |   "
//                    }
//
//                    if serviceArray[item].seconds! < 10 {
//                        secondsLabel = "0\(secondsLabel)"
//                    }
//
//                    line = "[\(minutesLabel):\(secondsLabel)]\(tab)\(line)"
//
//                } else {
//
//                    line = "           |  \(line)"
//
//                }
//
//            } else {
//
//                //Add Host
//                if serviceArray[item].host != nil {
//                    line = "\(line)  (\((serviceArray[item].host?.fullName())!))"
//                }
//
//                //Add Time
//                if serviceArray[item].minutes != 0 || serviceArray[item].seconds != 0 {
//
//                    let minutesLabel = "\(serviceArray[item].minutes!)"
//                    var secondsLabel = "\(serviceArray[item].seconds!)"
//
//                    if serviceArray[item].seconds! < 10 {
//                        secondsLabel = "0\(secondsLabel)"
//                    }
//
//                    if serviceArray[item].minutes! < 10 {
//                        line = "            - \(line)"
//                    } else {
//                        line = "           - \(line)"
//                    }
//
//                    line = "[\(minutesLabel):\(secondsLabel)]\(line)"
//
//                } else {
//                    line = "                      - \(line)"
//                }
//
//            }
//
//            summary += "\(line)\n\n"
//
//        }
//
//        return summary
//    }
    
    @objc func saveService() {
        
        if serviceTitle.text == "" {
            serviceTitle.layer.borderWidth = 3
            serviceTitle.layer.borderColor = UIColor.red.cgColor
        } else {
            serviceTitle.layer.borderWidth = 0
            
            let service: Service = Service(title: serviceTitle.text!, type: "", date: datePicker.date)
            Global.arrayOfServices.append(service)
            dataHandle.saveServicesToFile(services: Global.arrayOfServices)
            returnToMain()
        }
    }
    
    @objc func returnToMain() {
        self.navigationController?.pushViewController(ServiceView(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
