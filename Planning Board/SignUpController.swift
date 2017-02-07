//
//  SignUpController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 1/3/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct GlobalVariables {
    static var userName = String()
    static var segmentArray = [String]()
    static var popoverChoice = String()
}

class SignUpController : UIViewController {

    //Outlets
    @IBOutlet weak var signUpName: UITextField!
    @IBOutlet weak var signUpEmail: UITextField!
    @IBOutlet weak var signUpPassword: UITextField!
    @IBOutlet weak var signUpPasswordTwo: UITextField!
    @IBOutlet weak var passwordWarning: UILabel!
    @IBOutlet weak var passwordWarningTwo: UILabel!
    @IBOutlet weak var emailWarning: UILabel!
    @IBOutlet weak var churchNameWarning: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Variables
    var validUserName = Bool()
    var password = String()
    var match = Bool()
    var passwordCount = Bool()
    var givenUserName = String()
    var userChurchEmail = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        passwordWarning.text = ""
        passwordWarningTwo.text = ""
        emailWarning.text = ""
        churchNameWarning.text = ""
        getStartedButton.isUserInteractionEnabled = false
        getStartedButton.tintColor = UIColor.gray
        verifyButton.tintColor = UIColor.white
        
        scrollView.contentSize.height = view.bounds.height + 250
        scrollView.keyboardDismissMode = .onDrag
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func creatUser(_ sender: Any) {
        
        //Resign First Responder
        self.signUpEmail.resignFirstResponder()
        self.signUpPassword.resignFirstResponder()
        
        //Confirm username
        if signUpName.text == "" {
            validUserName = false
            print("Church name is not valid")
            churchNameWarning.text = "- Invalid church/organization name."
        } else {
            validUserName = true
            churchNameWarning.text = ""
            GlobalVariables.userName = signUpName.text!
            
        }
        
        //Confirm Password Match
        if signUpPassword.text == signUpPasswordTwo.text {
            
            password = signUpPasswordTwo.text!
            match = true
            print("Password match")
            passwordWarningTwo.text = ""
            
        } else {
            match = false
            passwordWarningTwo.text = "- Passwords do not match."
            print("Passwords do not match")
        }
        
        //Confirm Password Count
        if password.characters.count >= 6 {
            passwordCount = true
            passwordWarning.text = ""
        } else {
            passwordCount = false
            print("Password is not greater than 6 characters")
            passwordWarning.text = "- Password must contain at least 6 characters."
        }
        
        if match == true && passwordCount == true && validUserName == true {
            FIRAuth.auth()?.createUser(withEmail: signUpEmail.text!, password: password, completion: {
                user, error in
                
                if error != nil {
                    self.login()
                } else {
                    print("User Created!")
                    self.login()
                }
                
            })
        }
        
    }
    
    func login() {
        
        FIRAuth.auth()?.signIn(withEmail: signUpEmail.text!, password: password, completion: {
            user, error in
            
            if error != nil {
                self.emailWarning.text = "Invalid e-mail."
                print("Incorrect")
            } else {
                print("Successful Sign In!")
                UserDefaults.standard.set(true, forKey: "logged_in")
                UserDefaults.standard.set(GlobalVariables.userName, forKey: "username")
                UserDefaults.standard.synchronize()
                self.verifyButton.isUserInteractionEnabled = false
                self.verifyButton.tintColor = UIColor.gray
                self.emailWarning.text = ""
                self.givenUserName = self.signUpName.text!
                self.userChurchEmail = self.signUpEmail.text!
                self.post(userName: self.givenUserName, churchEmail: self.userChurchEmail)
                
                
                self.navigationController?.navigationBar.isUserInteractionEnabled = false
                self.navigationController?.navigationBar.tintColor = UIColor.lightGray
                self.getStartedButton.tintColor = UIColor.white
                self.getStartedButton.isUserInteractionEnabled = true
                
            }
            
        })
        
    }
    
    func post(userName : String, churchEmail : String) {
        
        let databaseRef = FIRDatabase.database().reference()
        
        let post : [String : AnyObject] =
            ["UserName" : userName as AnyObject,
                "Email" : churchEmail as AnyObject]
        
        databaseRef.child(userName).child("Account").setValue(post)
        
    }
    
}















