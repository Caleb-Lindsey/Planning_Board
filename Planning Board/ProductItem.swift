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
 - Song Key
 - Parent Segment
 */

class ProductItem {
    
    var title : String = String()
    var type : String = String()
    var minutes : Int? = Int()
    var seconds: Int? = Int()
    var host : Member? = Member()
    var PBdescription : String = String()
    var parentSegment : String = String()
    
    init() {
        self.title = ""
        self.type = "element"
        self.minutes = 0
        self.seconds = 0
        self.host = nil
        self.PBdescription = ""
        self.parentSegment = ""
    }
    
}
