//
//  FinalService.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/14/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class FinalService : UIViewController, UIDocumentInteractionControllerDelegate {
    
    //Variables
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    var interactionController: UIDocumentInteractionController?
    let dataHandle = Datasource()
    
    let serviceTitle : UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.placeholder = "Service Title"
        textfield.layer.cornerRadius = 5
        textfield.layer.borderColor = GlobalVariables.greenColor.cgColor
        textfield.layer.borderWidth = 0.4
        return textfield
    }()
    
    let serviceView : UITextView = {
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
    
    let datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        picker.minimumDate = Date()
        return picker
    }()
    
    let serviceType : UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.placeholder = "Service Type"
        textfield.layer.cornerRadius = 5
        textfield.layer.borderColor = GlobalVariables.greenColor.cgColor
        textfield.layer.borderWidth = 0.4
        return textfield
    }()
    
    let saveToApp : UIButton = {
        let button = UIButton()
        button.backgroundColor = GlobalVariables.greenColor
        button.setTitle("Save to Planning Board", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveService), for: .touchUpInside)
        return button
    }()
    
    let exportButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = GlobalVariables.greenColor
        button.setTitle("Export", for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(writeToFile), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup View
        view.backgroundColor = GlobalVariables.grayColor
        self.navigationItem.title = "Finalize Service"
        self.navigationController?.navigationBar.barTintColor = GlobalVariables.grayColor
        self.navigationController?.navigationBar.tintColor = GlobalVariables.lighterGreenColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        serviceView.text = formatSummary(serviceArray: GlobalVariables.serviceDetailArray)
        
        if let window = UIApplication.shared.keyWindow {
            
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            let topBorder = (self.navigationController?.navigationBar.frame.height)! + (statusBar.frame.height)
            
            //Place service view
            serviceView.frame = CGRect(x: window.frame.width / 2 - 25, y: topBorder + 45, width: window.frame.width / 2, height: window.frame.height * (7/10))
            view.addSubview(serviceView)
            
            //Place date picker
            datePicker.frame = CGRect(x: 35, y: topBorder + 45, width: window.frame.width - serviceView.frame.width - 50 - 25, height: 100)
            view.addSubview(datePicker)
            
            //Place service title
            serviceTitle.frame = CGRect(x: datePicker.frame.origin.x, y: datePicker.frame.maxY + 25 , width: datePicker.frame.width, height: 35)
            serviceTitle.leftView = paddingView
            serviceTitle.leftViewMode = .always
            view.addSubview(serviceTitle)
            
            //Place service type
            serviceType.frame = CGRect(x: serviceTitle.frame.origin.x, y: serviceTitle.frame.maxY + 25, width: serviceTitle.frame.width, height: serviceTitle.frame.height)
            serviceType.leftView = paddingView2
            serviceType.leftViewMode = .always
            view.addSubview(serviceType)
            
            //Place save to app button
            saveToApp.frame = CGRect(x: serviceType.frame.origin.x, y: serviceType.frame.maxY + 25, width: serviceType.frame.width, height: serviceType.frame.height * 1.5)
            view.addSubview(saveToApp)
            
            //Place export button
            exportButton.frame = CGRect(x: saveToApp.frame.origin.x, y: saveToApp.frame.maxY + 10, width: saveToApp.frame.width, height: saveToApp.frame.height)
            view.addSubview(exportButton)
            
            
        }
        
    }
    
    func formatSummary(serviceArray : [ProductItem]) -> String {
        
        var summary = String()
        var line = String()
        
        for item in 0..<serviceArray.count {
            
            line = serviceArray[item].title
            
           if serviceArray[item].type == "Segment" {
            
                //Add Host
                if serviceArray[item].host != nil {
                    line = "\(line)  (\((serviceArray[item].host?.fullName())!))"
                }
            
                //Add Time
                if serviceArray[item].minutes != 0 {
                    
                    if serviceArray[item].minutes! >= 10 {
                        line = "  \((serviceArray[item].minutes)!):00 | \(line)"
                    } else {
                        line = "  \((serviceArray[item].minutes)!):00   | \(line)"
                    }
                    
                } else {
                    
                    line = "           |  \(line)"
                    
                }
            
                //Add Key
                if serviceArray[item].songKey != "none" {
                    
                    line = "\(line) {\(serviceArray[item].songKey)}"
                    
                }
            
           } else {
            
                line = "                      - \(line)"
            
                //Add Host
                if serviceArray[item].host != nil {
                    line = "\(line)  (\((serviceArray[item].host?.fullName())!))"
                }
            
                //Add Time
                if serviceArray[item].minutes != 0 {
                    
                    line = "\(line) [\((serviceArray[item].minutes)!):00]"
                    
                }
            
                //Add Key
                if serviceArray[item].songKey != "none" {
                    
                    line = "\(line) {\(serviceArray[item].songKey)}"
                    
                }
            
            }
            
            summary += "\(line)\n\n"
        
        }
        
        return summary
    }
    
    func writeToFile() {
        
        let file = "\((serviceTitle.text)!).txt" //this is the file. we will write to and read from it
        
        let text = serviceView.text! //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                try openInPages(body: serviceView.text, title: file)
            }
            catch {
                print("nope")
            }
            
        }
        
    }
    
    func openInPages(body: String, title: String) throws {
        // create a file path in a temporary directory
        let fileName = "\(title)"
        let filePath = (NSTemporaryDirectory() as NSString).appendingPathComponent(fileName)
        
        // save the body to the file
        try body.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
        
        interactionController?.delegate = self
        
        // present Open In menu
        interactionController = UIDocumentInteractionController(url: NSURL(fileURLWithPath: filePath) as URL)
        interactionController?.presentOptionsMenu(from: exportButton.frame, in: self.view, animated: true)
    }
    
    
    func saveService() {
        
        let service : ServiceObject = ServiceObject(title: serviceTitle.text!, type: serviceType.text!, date: Date(), summary: serviceView.text!, fullDetail: "")
        GlobalVariables.arrayOfServices.append(service)
        
        dataHandle.uploadService(service: service)
        print("Prepare to upload")
    }
    
}






























