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
    @IBOutlet weak var plusButton: UIBarButtonItem!
    
    //Variable
    var checkTimer = Timer()
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var dimmerView : UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dimmerView.backgroundColor = UIColor.black
        dimmerView.layer.opacity = 0.5
        dimmerView.frame = view.frame
        view.addSubview(dimmerView)
        
        GlobalVariables.userName = UserDefaults.standard.value(forKey: "username") as! String
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Pull from Firebase to fill Variables
        Datasource().fillData {
            
            self.dimmerView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
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
        VC.preferredContentSize = CGSize(width: 350, height: 70)
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




