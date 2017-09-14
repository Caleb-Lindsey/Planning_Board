//
//  CustomTextField.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 8/30/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class CustomTextField : UITextField, UITextFieldDelegate {
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 35))
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.layer.borderColor = GlobalVariables.greenColor.cgColor
        self.layer.borderWidth = 0.4
        self.returnKeyType = UIReturnKeyType.done
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
