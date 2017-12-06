//
//  FinalService.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/14/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import MessageUI

class FinalService : UIViewController, UIDocumentInteractionControllerDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
    
    //Variables
    let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    var interactionController: UIDocumentInteractionController?
    let dataHandle = Datasource()
    let checkMark = PBAnimations()
    
    let serviceTitle : CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Service Title"
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
    
    let serviceType : CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Service Type"
        return textfield
    }()
    
    let saveToApp : UIButton = {
        let button = UIButton()
        button.backgroundColor = GlobalVariables.greenColor
        button.setTitle("Save to Planning Board", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveService), for: .touchUpInside)
        return button
    }()
    
    let exportButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = GlobalVariables.greenColor
        button.setTitle("Export", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(emailService), for: .touchUpInside)
        button.isEnabled = false
        button.layer.opacity = 0.5
        return button
    }()
    
    let savedLabel : UILabel = {
        let label = UILabel()
        label.text = "Upload Complete"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica", size: 18)
        label.textAlignment = .center
        return label
    }()
    
    let doneButton : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = GlobalVariables.greenColor
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(returnToMain), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        button.layer.opacity = 0.5
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup View
        view.backgroundColor = GlobalVariables.grayColor
        self.navigationItem.title = "Finalize Service"
        self.navigationController?.navigationBar.barTintColor = GlobalVariables.grayColor
        self.navigationController?.navigationBar.tintColor = GlobalVariables.lighterGreenColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
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
            serviceTitle.delegate = self

            view.addSubview(serviceTitle)
            
            //Place service type
            serviceType.frame = CGRect(x: serviceTitle.frame.origin.x, y: serviceTitle.frame.maxY + 25, width: serviceTitle.frame.width, height: serviceTitle.frame.height)
            serviceType.delegate = self
            //view.addSubview(serviceType)
            
            //Place save to app button
            saveToApp.frame = CGRect(x: serviceType.frame.origin.x, y: serviceTitle.frame.maxY + 25, width: serviceType.frame.width, height: serviceType.frame.height * 1.5)
            view.addSubview(saveToApp)
            
            //Place export button
            exportButton.frame = CGRect(x: saveToApp.frame.origin.x, y: saveToApp.frame.maxY + 10, width: saveToApp.frame.width, height: saveToApp.frame.height)
            view.addSubview(exportButton)
            
            //Place return button
            doneButton.frame = CGRect(x: exportButton.frame.maxX - 150, y: exportButton.frame.maxY + 10, width: 150, height: 35)
            view.addSubview(doneButton)
            
            
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
                if serviceArray[item].minutes != 0 || serviceArray[item].seconds != 0 {
                    
                    let minutesLabel = "\(serviceArray[item].minutes!)"
                    var secondsLabel = "\(serviceArray[item].seconds!)"
                    var tab = "   |   "
                    
                    if serviceArray[item].minutes! < 10 {
                        tab = "     |   "
                    }
                    
                    if serviceArray[item].seconds! < 10 {
                        secondsLabel = "0\(secondsLabel)"
                    }
                    
                    line = "[\(minutesLabel):\(secondsLabel)]\(tab)\(line)"
                    
                } else {
                    
                    line = "           |  \(line)"
                    
                }
                
            } else {
                
                //Add Host
                if serviceArray[item].host != nil {
                    line = "\(line)  (\((serviceArray[item].host?.fullName())!))"
                }
                
                //Add Time
                if serviceArray[item].minutes != 0 || serviceArray[item].seconds != 0 {
                    
                    let minutesLabel = "\(serviceArray[item].minutes!)"
                    var secondsLabel = "\(serviceArray[item].seconds!)"
                    
                    if serviceArray[item].seconds! < 10 {
                        secondsLabel = "0\(secondsLabel)"
                    }
                    
                    if serviceArray[item].minutes! < 10 {
                        line = "            - \(line)"
                    } else {
                        line = "           - \(line)"
                    }
                    
                    line = "[\(minutesLabel):\(secondsLabel)]\(line)"
                    
                } else {
                    line = "                      - \(line)"
                }
                
            }
            
            summary += "\(line)\n\n"
            
        }
        
        return summary
    }
    
//    func writeToFile() {
//        
//        let file = "\((serviceTitle.text)!).pages" //this is the file. we will write to and read from it
//        
//        let text = serviceView.text! //just a text
//        
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            
//            let path = dir.appendingPathComponent(file)
//            
//            //writing
//            do {
//                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
//                try openInPages(body: serviceView.text, title: file)
//                doneButton.isUserInteractionEnabled = true
//                doneButton.layer.opacity = 1
//            }
//            catch {
//                print("nope")
//            }
//            
//        }
//        
//    }
//    
//    func openInPages(body: String, title: String) throws {
//        // create a file path in a temporary directory
//        let fileName = "\(title)"
//        let filePath = (NSTemporaryDirectory() as NSString).appendingPathComponent(fileName)
//        
//        // save the body to the file
//        try body.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)
//        
//        interactionController?.delegate = self
//        
//        // present Open In menu
//        interactionController = UIDocumentInteractionController(url: NSURL(fileURLWithPath: filePath) as URL)
//        interactionController?.presentOptionsMenu(from: exportButton.frame, in: self.view, animated: true)
//    }
    
    
    @objc func saveService() {
        
        if serviceTitle.text == "" {
            serviceTitle.layer.borderWidth = 3
            serviceTitle.layer.borderColor = UIColor.red.cgColor
        } else {
            
            serviceTitle.layer.borderWidth = 0
            serviceTitle.layer.borderColor = UIColor.red.cgColor
            
            let service : ServiceObject = ServiceObject(title: serviceTitle.text!, type: serviceType.text!, date: datePicker.date, summary: serviceView.text!, fullDetail: "")
            GlobalVariables.arrayOfServices.append(service)
            
            dataHandle.uploadService()
        
            saveToApp.isUserInteractionEnabled = false
            saveToApp.layer.opacity = 0.8
            
            saveToApp.addSubview(checkMark.checkImageView)
            savedLabel.frame = CGRect(x: saveToApp.frame.width / 2 - 100, y: saveToApp.frame.height, width: 200, height: 50)
            checkMark.checkImageView.frame = CGRect(x: savedLabel.frame.maxX, y: savedLabel.frame.origin.y, width: 50, height: 50)
            saveToApp.addSubview(savedLabel)
            saveToApp.setTitle("", for: .normal)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                
                self.checkMark.checkImageView.frame.origin.y = self.saveToApp.frame.height / 2 - 25
                self.savedLabel.frame.origin.y = self.saveToApp.frame.height / 2 - 25
                
            }, completion: {(finished: Bool) in
                
                self.checkMark.playCheckGif()
                self.doneButton.isUserInteractionEnabled = true
                self.doneButton.isEnabled = true
                self.exportButton.isEnabled = true
                self.doneButton.layer.opacity = 1
                self.exportButton.layer.opacity = 1
                
            })
            
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
    
    @objc func emailService() {
        
        if serviceTitle.text != "" && serviceView.text != "" {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let dateString = formatter.string(from: datePicker.date)
            
            let mailController : MFMailComposeViewController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setSubject("\(serviceTitle.text!)  (\(dateString))")
            mailController.setMessageBody(serviceView.text!, isHTML: false)
            
            self.present(mailController, animated: true, completion: nil)
            
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if result == .sent {
            controller.dismiss(animated: true, completion: {
                self.returnToMain()
            })
        } else {
            controller.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
}























































