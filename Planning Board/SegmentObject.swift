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

class SegmentObject : NSObject, NSCoding {
    
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
    override init() {
        self.name = ""
        self.elements = [String]()
        self.iconImage = UIImage()
        self.lastUsed = Date()
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.name = aDecoder.decodeObject(forKey: "Name") as! String
        self.elements = aDecoder.decodeObject(forKey: "Elements") as! [String]
        self.iconImage = aDecoder.decodeObject(forKey: "IconImage") as! UIImage
        self.lastUsed = aDecoder.decodeObject(forKey: "LastUsed") as! Date
        
    }
    
    func initWithCoder(aDecoder: NSCoder) -> SegmentObject {
        
        self.name = aDecoder.decodeObject(forKey: "Title") as! String
        self.elements = aDecoder.decodeObject(forKey: "Elements") as! [String]
        self.iconImage = aDecoder.decodeObject(forKey: "IconImage") as! UIImage
        self.lastUsed = aDecoder.decodeObject(forKey: "LastUsed") as! Date
        
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(elements, forKey: "Elements")
        aCoder.encode(iconImage, forKey: "IconImage")
        aCoder.encode(lastUsed, forKey: "LastUsed")
        
    }
    
}


