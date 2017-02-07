//
//  ElementSetupController.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 1/5/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class ElementSetupController: UIViewController {
    
    // Outlets
    @IBOutlet weak var SegmentLabel: UILabel!
    @IBOutlet weak var element1: UITextField!
    @IBOutlet weak var element2: UITextField!
    @IBOutlet weak var element3: UITextField!
    @IBOutlet weak var element4: UITextField!
    @IBOutlet weak var element5: UITextField!
    @IBOutlet weak var element6: UITextField!
    @IBOutlet weak var element7: UITextField!
    @IBOutlet weak var element8: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    //Variables
    var nextCounter = Int()
    var count : Int = 0
    var elementArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        
        finishButton.isUserInteractionEnabled = false
        finishButton.tintColor = UIColor.gray
        nextButton.tintColor = UIColor.white
        
        if GlobalVariables.segmentArray.isEmpty == false {
            SegmentLabel.text = GlobalVariables.segmentArray[0]
        }
        
        nextCounter = GlobalVariables.segmentArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        
        if element1.text != "" {
            elementArray.append(element1.text!)
        }
        if element2.text != "" {
            elementArray.append(element2.text!)
        }
        if element3.text != "" {
            elementArray.append(element3.text!)
        }
        if element4.text != "" {
            elementArray.append(element4.text!)
        }
        if element5.text != "" {
            elementArray.append(element5.text!)
        }
        if element6.text != "" {
            elementArray.append(element6.text!)
        }
        if element7.text != "" {
            elementArray.append(element7.text!)
        }
        if element8.text != "" {
            elementArray.append(element8.text!)
        }
        
        if elementArray.isEmpty == false {
            post(arrayOfElements : elementArray)
        } else {
            print("nada again")
            clearAndReset()
        }
    }
    
    func post(arrayOfElements : Array<Any>) {
        
        let databaseRef = FIRDatabase.database().reference()
        var elementCount : Int = 0
        while elementCount < arrayOfElements.count {
            
            let post : [String : AnyObject] =
                ["element\(elementCount + 1)" : arrayOfElements[elementCount] as AnyObject]
            
            databaseRef.child(GlobalVariables.userName).child("Service Parts").child(GlobalVariables.segmentArray[count]).updateChildValues(post)
            
            elementCount += 1
            
        }
        
        clearAndReset()
        
    }
    
    func clearAndReset() {
        nextCounter -= 1
        print(nextCounter)
        
        if nextCounter <= 0 {
            nextButton.isUserInteractionEnabled = false
            SegmentLabel.text = "Complete"
            finishButton.isUserInteractionEnabled = true
            finishButton.tintColor = UIColor.white
            
            element1.isUserInteractionEnabled = false
            element1.backgroundColor = UIColor.darkGray
            element2.isUserInteractionEnabled = false
            element2.backgroundColor = UIColor.darkGray
            element3.isUserInteractionEnabled = false
            element3.backgroundColor = UIColor.darkGray
            element4.isUserInteractionEnabled = false
            element4.backgroundColor = UIColor.darkGray
            element5.isUserInteractionEnabled = false
            element5.backgroundColor = UIColor.darkGray
            element6.isUserInteractionEnabled = false
            element6.backgroundColor = UIColor.darkGray
            element7.isUserInteractionEnabled = false
            element7.backgroundColor = UIColor.darkGray
            element8.isUserInteractionEnabled = false
            element8.backgroundColor = UIColor.darkGray
            
            
        }
        
        count += 1
        elementArray.removeAll()
        
        element1.text = ""
        element2.text = ""
        element3.text = ""
        element4.text = ""
        element5.text = ""
        element6.text = ""
        element7.text = ""
        element8.text = ""
        
        if nextCounter != 0 {
            SegmentLabel.text = GlobalVariables.segmentArray[count]
        }
        
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}



















