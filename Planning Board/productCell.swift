//
//  productCell.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class ProductCell : UITableViewCell {
    
    var type : String = String()
    var time : Int = Int()
    var host : Member = Member()
    var cellDescription : String = String()
    
    init(Type : String, Time : Int, Host : Member, Description : String) {
        self.type = Type
        self.time = Time
        self.host = Host
        self.cellDescription = Description
        super.init(style: .default, reuseIdentifier: "customCell")
    }
    
    init() {
        self.type = "Test"
        self.time = Int()
        self.host = Member()
        self.cellDescription = String()
        super.init(style: .default, reuseIdentifier: "customCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
