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
    
    init(Name: String, Elements: [String], IconImage: UIImage) {
        
        self.name = Name
        self.elements = Elements
        self.iconImage = IconImage
        
    }
    init() {
        self.name = ""
        self.elements = [String]()
        self.iconImage = UIImage()
    }
    
}
