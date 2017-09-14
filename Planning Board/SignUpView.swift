//
//  SignUpView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 7/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class SignUpView : PBViewController {
    
    let userDefaults = UserDefaults.standard
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    let paddingView3 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    
    let userNameField : UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.backgroundColor = UIColor.white
        field.layer.cornerRadius = 5
        return field
    }()
    
    let passwordField : UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.backgroundColor = UIColor.white
        field.layer.cornerRadius = 5
        return field
    }()
    
    let churchField : UITextField = {
        let field = UITextField()
        field.placeholder = "Church/Organization Name"
        field.backgroundColor = UIColor.white
        field.layer.cornerRadius = 5
        return field
    }()
    
    let submitButton : UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = GlobalVariables.greenColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(submitData), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Place username field
        userNameField.frame = CGRect(x: view.frame.width / 2 - 150, y: view.frame.height * (4/10), width: 300, height: 35)
        userNameField.leftView = paddingView
        userNameField.leftViewMode = .always
        view.addSubview(userNameField)
        
        //Place password field
        passwordField.frame = CGRect(x: userNameField.frame.origin.x, y: userNameField.frame.maxY + 15, width: 300, height: 35)
        passwordField.leftView = paddingView2
        passwordField.leftViewMode = .always
        view.addSubview(passwordField)
        
        //Place church/organization name field
        churchField.frame = CGRect(x: passwordField.frame.origin.x, y: passwordField.frame.maxY + 15, width: 300, height: 35)
        churchField.leftView = paddingView3
        churchField.leftViewMode = .always
        view.addSubview(churchField)
        
        //Place submit button
        submitButton.frame = CGRect(x: 0, y: churchField.frame.maxY + 15, width: 150, height: 40)
        submitButton.center.x = churchField.center.x
        view.addSubview(submitButton)
        
    }
    
    func submitData() {
        
        var alertMessage : String = ""
        var valid : Bool = true
        
        userNameField.layer.borderWidth = 0
        passwordField.layer.borderWidth = 0
        churchField.layer.borderWidth = 0
        
        if userNameField.text != "" {
            if (userNameField.text?.characters.count)! < 8 {
                alertMessage += "• Username must be atleast 8 characters long.\n"
                userNameField.layer.borderColor = UIColor.red.cgColor
                userNameField.layer.borderWidth = 3
                valid = false
            }
            
        } else {
            alertMessage += "• Username is requiered.\n"
            userNameField.layer.borderColor = UIColor.red.cgColor
            userNameField.layer.borderWidth = 3
            valid = false
        }
        
        if passwordField.text != "" {
            if (passwordField.text?.characters.count)! < 8 {
                alertMessage += "• Password must be atleast 8 characters long.\n"
                passwordField.layer.borderColor = UIColor.red.cgColor
                passwordField.layer.borderWidth = 3
                valid = false
            }
        } else {
            alertMessage += "• Password is requiered.\n"
            passwordField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderWidth = 3
            valid = false
        }
        
        if churchField.text == "" {
            alertMessage += "• Church/Organization name is requiered."
            churchField.layer.borderColor = UIColor.red.cgColor
            churchField.layer.borderWidth = 3
            valid = false
        }
        
        if valid {
            
            GlobalVariables.userName = passwordField.text!
            userDefaults.set(GlobalVariables.userName, forKey: "username")
            
    
            
            self.present(CustomTabBar(), animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Requiered Fields", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}



















