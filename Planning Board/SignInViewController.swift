//
//  SignInViewController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 4/6/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController : UIViewController {
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Planning Board"
        label.textColor = GlobalVariables.greenColor
        label.font = UIFont(name: "Helvetica", size: 55)
        label.textAlignment = .center
        return label
    }()
    
    let signInButton : UIButton = {
        
        let button : UIButton = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = GlobalVariables.greenColor
        return button
        
    }()
    
    let userName : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "username"
        return textField
    }()
    
    let userPassword : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signInWarning : UILabel = {
        let warning = UILabel()
        warning.text = ""
        warning.font = UIFont(name: "Helvetica", size: 11)
        warning.textColor = UIColor.red
        warning.textAlignment = .center
        return warning
    }()
    
    let signUpBar : UIButton = {
        let button = UIButton()
        button.setTitle("Don't have an account? | Sign up", for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.backgroundColor = GlobalVariables.greenColor
        button.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return button
    }()
    
    //Variables
    var userEmail = String()
    
    override func viewDidLoad() {
        
        //For Testing
        userName.text = "Cal117"
        userPassword.text = "123456"
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = GlobalVariables.grayColor
        navigationController?.navigationBar.isHidden = true
        
        signInButton.isUserInteractionEnabled = true
        
        if let window = UIApplication.shared.keyWindow {
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
            
            //Place TitleLabel
            titleLabel.frame = CGRect(x: 0, y: window.center.y - 250, width: window.frame.width, height: 65)
            view.addSubview(titleLabel)
            
            //Place username field
            userName.frame = CGRect(x: 0, y: titleLabel.frame.maxY + 75, width: 250.0, height: 35.0)
            userName.center.x = window.center.x
            userName.layer.cornerRadius = 10
            userName.leftView = paddingView
            userName.leftViewMode = UITextFieldViewMode.always
            view.addSubview(userName)
            
            //Place password field
            userPassword.frame = CGRect(x: 0, y: userName.frame.maxY + 15, width: 250.0, height: 35.0)
            userPassword.center.x = window.center.x
            userPassword.layer.cornerRadius = 10
            userPassword.leftView = paddingView2
            userPassword.leftViewMode = UITextFieldViewMode.always
            view.addSubview(userPassword)
            
            //Place sign in button
            signInButton.frame = CGRect(x: 0, y: userPassword.frame.maxY + 50, width: 100, height: 50)
            signInButton.center.x = window.center.x
            signInButton.layer.cornerRadius = 8
            signInButton.addTarget(self, action: #selector(signInPressed(_:)), for: .touchUpInside)
            view.addSubview(signInButton)
            
            //Place sign in warning
            signInWarning.frame = CGRect(x: 0, y: userPassword.frame.maxY + 5, width: 250.0, height: 15)
            signInWarning.center.x = window.center.x
            view.addSubview(signInWarning)
            
            //Place signup bar
            signUpBar.frame = CGRect(x: 0, y: window.frame.maxY - 60, width: window.frame.width, height: 60)
            view.addSubview(signUpBar)
            
        }
        
    }
    
    func signInPressed(_ sender: Any) {
        signInButton.isUserInteractionEnabled = false
        self.view.endEditing(true)
        verifyUserName()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func verifyUserName() {
        print("verifying username")
        let databaseRef = FIRDatabase.database().reference()
        
        if self.userName.text != "" {
            print("here")
            databaseRef.child(self.userName.text!).observeSingleEvent(of: .childAdded, with: {
                snapshot in
                print("here")
                let dictionary = snapshot.value! as! [String : String]
                
                self.userEmail = dictionary["Email"]!
                GlobalVariables.userName = self.userName.text!
                UserDefaults.standard.set(GlobalVariables.userName, forKey: "username")
                UserDefaults.standard.synchronize()
                self.login()
                
                
            })
            
        } else {
            self.signInWarning.text = "- username or password is incorrect."
            signInButton.isUserInteractionEnabled = true
        }
        print("done verifying username")
    }
    
    func login() {
        print("login")
        FIRAuth.auth()?.signIn(withEmail: userEmail, password: userPassword.text!, completion: {
            user, error in
            
            if error != nil {
                self.signInWarning.text = "- username or password is incorrect."
                self.signInButton.isUserInteractionEnabled = true
            } else {
                self.signInWarning.text = ""
                UserDefaults.standard.set(true, forKey: "logged_in")
                UserDefaults.standard.synchronize()
                
                self.navigationController?.pushViewController(CustomTabBar(), animated: true)

            }
            
        })
        
        print("done login")

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func signUpPressed() {
        
        self.present(SignUpView(), animated: true, completion: nil)
        
    }
    
}







