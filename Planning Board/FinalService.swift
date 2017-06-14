//
//  FinalService.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/14/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class FinalService : UIViewController {
    
    //Variables
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))

    
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
            
            
        }
        
    }
    
    func formatSummary(serviceArray : [ProductItem]) -> String {
        
        var summary = String()
        
        for item in 0..<serviceArray.count {
            
            
            
            summary += "\(serviceArray[item].title)\n"
            
        }
        
        return summary
    }
    
}






























