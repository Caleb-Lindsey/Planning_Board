//
//  SignUpView.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 7/17/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class SignUpView : PBViewController {
    
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
        userNameField.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height * (4/10), width: 200, height: 35)
        view.addSubview(userNameField)
        
        //Place password field
        passwordField.frame = CGRect(x: userNameField.frame.origin.x, y: userNameField.frame.maxY + 15, width: 200, height: 35)
        view.addSubview(passwordField)
        
        //Place church/organization name field
        churchField.frame = CGRect(x: passwordField.frame.origin.x, y: passwordField.frame.maxY + 15, width: 200, height: 35)
        view.addSubview(churchField)
        
    }
    
    func submitData() {
        
        
        
    }
    
}



















