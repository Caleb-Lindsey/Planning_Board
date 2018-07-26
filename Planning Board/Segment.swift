//
//  SegmentObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/25/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Segment: NSObject, NSCoding {
    
    var title = String()
    var elements = [Element]()
    var iconImage = UIImage()
    var lastUsed = Date()
    
    init(title: String, elements: [Element], iconImage: UIImage) {
        self.title = title
        self.elements = elements
        self.iconImage = iconImage
        self.lastUsed = Date()
    }
    
    override init() {
        self.title = ""
        self.elements = [Element]()
        self.iconImage = UIImage()
        self.lastUsed = Date()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "Title") as! String
        self.elements = aDecoder.decodeObject(forKey: "Elements") as! [Element]
        self.iconImage = aDecoder.decodeObject(forKey: "IconImage") as! UIImage
        self.lastUsed = aDecoder.decodeObject(forKey: "LastUsed") as! Date
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Segment {
        self.title = aDecoder.decodeObject(forKey: "Title") as! String
        self.elements = aDecoder.decodeObject(forKey: "Elements") as! [Element]
        self.iconImage = aDecoder.decodeObject(forKey: "IconImage") as! UIImage
        self.lastUsed = aDecoder.decodeObject(forKey: "LastUsed") as! Date
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(elements, forKey: "Elements")
        aCoder.encode(iconImage, forKey: "IconImage")
        aCoder.encode(lastUsed, forKey: "LastUsed")
    }
}
