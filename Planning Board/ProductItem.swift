//
//  ProductItem.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/8/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

/*
 A class to hold all information about a product item.
 - Title
 - Time
 - Host
 - Description
 */

class ProductItem {
    
    var title : String = String()
    var hours : Int? = Int()
    var minutes : Int? = Int()
    var host : Member? = Member()
    var description : String = String()
    
    init() {
        
        self.title = ""
        self.hours = nil
        self.minutes = nil
        self.host = nil
        self.description = ""
        
    }
    
}
