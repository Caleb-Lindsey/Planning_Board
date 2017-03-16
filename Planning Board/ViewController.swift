//
//  ViewController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 12/30/16.
//  Copyright © 2016 KlubCo. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var signInWarning: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    //Variables
    var userEmail = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signInWarning.text = ""
        signInButton.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    @IBAction func signInPressed(_ sender: Any) {
        signInButton.isUserInteractionEnabled = false
        self.view.endEditing(true)
        verifyUserName()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func login() {
        
        FIRAuth.auth()?.signIn(withEmail: userEmail, password: userPassword.text!, completion: {
            user, error in
            
            if error != nil {
                self.signInWarning.text = "- username or password is incorrect."
                self.signInButton.isUserInteractionEnabled = true
            } else {
                self.signInWarning.text = ""
                UserDefaults.standard.set(true, forKey: "logged_in")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "mySegueID", sender: nil)

            }
            
        })
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func verifyUserName() {
    
        let databaseRef = FIRDatabase.database().reference()
        
        if self.userName.text != "" {
            databaseRef.child(self.userName.text!).observeSingleEvent(of: .childAdded, with: {
                snapshot in
                
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
        
    }

}







