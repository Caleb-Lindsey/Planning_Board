//
//  DivisionSetupController.swift
//  Pods
//
//  Created by Caleb Lindsey on 1/4/17.
//
//

import Foundation
import UIKit
import Firebase

class DivisionSetupController: UIViewController{
    
    //Outlets
    @IBOutlet weak var segment0: UITextField!
    @IBOutlet weak var segment1: UITextField!
    @IBOutlet weak var segment2: UITextField!
    @IBOutlet weak var segment3: UITextField!
    @IBOutlet weak var segment4: UITextField!
    @IBOutlet weak var segment5: UITextField!
    @IBOutlet weak var segment6: UITextField!
    @IBOutlet weak var segment7: UITextField!
    @IBOutlet weak var segment8: UITextField!
    @IBOutlet weak var segment9: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    //Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        continueButton.tintColor = UIColor.white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func continuePressed(_ sender: Any) {
        
        if segment0.text! != "" {
            GlobalVariables.segmentArray.append(segment0.text!)
        }
        if segment1.text! != "" {
            GlobalVariables.segmentArray.append(segment1.text!)
        }
        if segment2.text! != "" {
            GlobalVariables.segmentArray.append(segment2.text!)
        }
        if segment3.text! != "" {
            GlobalVariables.segmentArray.append(segment3.text!)
        }
        if segment4.text! != "" {
            GlobalVariables.segmentArray.append(segment4.text!)
        }
        if segment5.text! != "" {
            GlobalVariables.segmentArray.append(segment5.text!)
        }
        if segment6.text! != "" {
            GlobalVariables.segmentArray.append(segment6.text!)
        }
        if segment7.text! != "" {
            GlobalVariables.segmentArray.append(segment7.text!)
        }
        if segment8.text! != "" {
            GlobalVariables.segmentArray.append(segment8.text!)
        }
        if segment9.text! != "" {
            GlobalVariables.segmentArray.append(segment9.text!)
        }
        
        if GlobalVariables.segmentArray.isEmpty == false {
            post(arrayOfSegments: GlobalVariables.segmentArray)
        } else {
            print("nada")
        }
    }
    
    
    
    
    func post(arrayOfSegments : Array<Any>) {
        
        var count : Int = 0
        let databaseRef = FIRDatabase.database().reference()
        
        while count < arrayOfSegments.count {
            
            let post : [String : AnyObject] =
                [arrayOfSegments[count] as! String : arrayOfSegments[count] as AnyObject]
            
            
            databaseRef.child(GlobalVariables.userName).child("Service Parts").updateChildValues(post)
            
            
            count += 1

        }
        
        count = 0
        
        while count < arrayOfSegments.count {
            
            let post : [String : AnyObject] =
                ["Segment" : arrayOfSegments[count] as AnyObject]
            
            
            databaseRef.child(GlobalVariables.userName).child("ZZZ_DeveloperTools_ZZZ").child("Segment\(count + 1)").updateChildValues(post)
            
            
            count += 1
            
        }
        
        
        
        continueButton.tintColor = UIColor.gray
        continueButton.isUserInteractionEnabled = false
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}



























