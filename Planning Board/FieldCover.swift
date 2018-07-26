//
//  FieldCover.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 1/23/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class FieldCover: UIView {
    
    var displayMessage: String!
    
    let displayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 25)
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.displayMessage = "Start Creating Data Above"
    }
    
    init(displayMessage: String, frame: CGRect) {
        super.init(frame: frame)
        self.displayMessage = displayMessage
        
        backgroundColor = Global.grayColor
        layer.borderColor = Global.greenColor.cgColor
        layer.borderWidth = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayLabel.frame = CGRect(x: 15, y: self.frame.height / 5, width: self.frame.width - 15 - 15, height: 100)
        displayLabel.text = self.displayMessage
        self.addSubview(displayLabel)
    }
}
