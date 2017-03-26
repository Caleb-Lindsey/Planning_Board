//
//  PBAnimations.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/25/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class PBAnimations {
    
    var checkImages = [UIImage]()
    var checkImageView = UIImageView()
    
    init() {
        
        for index in 24...94 {
            
            checkImages.append(UIImage(named: "Check_000\(index)")!)
            
        }
    }
    
    deinit {
        print("Check is deinitialized")
    }
    
    func playCheckGif() {
        
        checkImageView.animationImages = checkImages
        checkImageView.animationRepeatCount = 1
        checkImageView.startAnimating()
        
    }
    
}
