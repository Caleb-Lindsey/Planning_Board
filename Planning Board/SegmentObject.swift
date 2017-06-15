//
//  SegmentObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/25/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

/*
 A class to hold all information about a segment.
    - Name
    - Element Array
    - Icon Image
    - Default Duration
    - Last Used Date
*/

class SegmentObject {
    
    var name = String()
    var elements = [String]()
    var iconImage = UIImage()
    var lastUsed = Date()
    
    init(Name: String, Elements: [String], IconImage: UIImage) {
        
        self.name = Name
        self.elements = Elements
        self.iconImage = IconImage
        self.lastUsed = Date()
        
    }
    init() {
        self.name = ""
        self.elements = [String]()
        self.iconImage = UIImage()
        self.lastUsed = Date()
    }
    
}


