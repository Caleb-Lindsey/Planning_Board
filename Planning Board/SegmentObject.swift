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
    - Date Property to distinguish when it was last used
*/

class SegmentObject {
    
    var name = String()
    var elements = [String]()
    var iconImage = UIImage()
    var duration = Float()
    
    init(Name: String, Elements: [String], IconImage: UIImage, Duration: Float) {
        
        self.name = Name
        self.elements = Elements
        self.iconImage = IconImage
        self.duration = Duration
        
    }
    
}
