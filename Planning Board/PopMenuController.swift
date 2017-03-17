//
//  PopMenuController.swift
//  
//
//  Created by Caleb Lindsey on 1/10/17.
//
//

import Foundation
import Firebase


class PopMenuController : UIViewController, UIPopoverPresentationControllerDelegate {
    
    //Outlets
    @IBOutlet weak var Open: UIBarButtonItem!
    @IBOutlet weak var serviceButton: UIButton!
    @IBOutlet weak var segmentsButton: UIButton!
    @IBOutlet weak var peopleButton: UIButton!
    
    //Variable
    var checkTimer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.serviceButton.isUserInteractionEnabled = false
        self.segmentsButton.isUserInteractionEnabled = false
        self.peopleButton.isUserInteractionEnabled = false
        
        GlobalVariables.userName = UserDefaults.standard.value(forKey: "username") as! String
        
        // Pull from Firebase to fill Variables
        Datasource().fillData {
            print(GlobalVariables.resourceDict)
            GlobalVariables.segmentArray = Array(GlobalVariables.resourceDict.keys)
            //Try turning off the buttons so no one clicks on them before they are loaded and add a spin wheel
            self.serviceButton.isUserInteractionEnabled = true
            self.segmentsButton.isUserInteractionEnabled = true
            self.peopleButton.isUserInteractionEnabled = true
        }
        
        Open.target = self.revealViewController()
        Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func plusPressed(_ sender: Any) {
        
        
        checkTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkOption), userInfo: nil, repeats: true)
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "popOver") as! PopOverController
        VC.preferredContentSize = CGSize(width: 350, height: 120)
        let navController = UINavigationController(rootViewController: VC)
        navController.modalPresentationStyle = UIModalPresentationStyle.popover
        let popOver = navController.popoverPresentationController
        popOver?.delegate = self
        popOver?.barButtonItem = (sender as! UIBarButtonItem)
        
        self.present(navController, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print("dismissed")
        
        checkTimer.invalidate()
        
    }
    
    func checkOption() {
        
        switch GlobalVariables.popoverChoice {
            case "Service":
                checkTimer.invalidate()
                performSegue(withIdentifier: "toService", sender: Any?.self)
                GlobalVariables.popoverChoice = ""
            case "Resource":
                checkTimer.invalidate()
                performSegue(withIdentifier: "addResource", sender: Any?.self)
            GlobalVariables.popoverChoice = ""
        case nil:
            print("nada")
        default:
            print(".")
            
        }
        
    }
    
    
    
    
}


















