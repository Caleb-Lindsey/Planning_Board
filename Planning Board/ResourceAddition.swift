//
//  ResourceAddition.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 2/13/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import Foundation

class ResourceAddition : NSObject {
    
    let addResourceView : UIView = {
        
        let rv = UIView()
        rv.backgroundColor = UIColor.gray
        rv.layer.cornerRadius = 10
        rv.layer.borderWidth = 2
        rv.isUserInteractionEnabled = false
        return rv
        
    }()
    
    let doneButton : UIButton = {
        
        let bttn = UIButton()
        bttn.titleLabel?.text = "Done"
        bttn.setTitle("Done", for: .normal)
        bttn.backgroundColor = UIColor.green
        bttn.isEnabled = true
        bttn.isUserInteractionEnabled = true
        return bttn
        
    }()
    
    func launchAdditionView() {
        
        if let window = UIApplication.shared.keyWindow {
            window.isUserInteractionEnabled = true
            window.addSubview(addResourceView)
            
            let width : CGFloat = window.frame.width - 200
            let height : CGFloat = window.frame.height / 2
            let method = #selector(handleDismiss)
            addResourceView.frame = CGRect(x: window.center.x - (width / 2), y: window.frame.height , width: width , height: height)
            addResourceView.layer.opacity = 0
            
            addResourceView.addSubview(doneButton)
            doneButton.addTarget(self, action: method, for: .touchUpInside)
            doneButton.frame = CGRect(x: addResourceView.frame.width - 100, y: 60, width: 50, height: 50)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.addResourceView.frame = CGRect(x: window.center.x - (width / 2), y: window.center.y - (height / 2) , width: width , height: height)
                self.addResourceView.layer.opacity = 1
                
            }, completion: nil)
            
        }
        
    }
    
    func handleDismiss() {
        print("Dismissed")
        if let window = UIApplication.shared.keyWindow {
            
            let width : CGFloat = window.frame.width - 200
            let height : CGFloat = window.frame.height / 2
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.addResourceView.frame = CGRect(x: window.center.x - (width / 2), y: window.frame.height , width: width , height: height)
                
            })
            
            addResourceView.removeFromSuperview()
            
        }
        
    }
    
}
