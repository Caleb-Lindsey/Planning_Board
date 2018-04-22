//
//  ServiceObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/14/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

/*
 A class to hold all information about a service item.
    - Title
    - Type
    - Date
    - Summary
    - Full Detail
*/

class Service : NSObject, NSCoding, Codable {
    
    var title : String = String()
    var type : String = String()
    var date : Date = Date()
    var summary : String = String()
    var fullDetail : String = String()
    
    init(title: String, type: String, date: Date, summary: String, fullDetail: String) {
        self.title = title
        self.type = type
        self.date = date
        self.summary = summary
        self.fullDetail = fullDetail
    }
    
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "Title") as! String
        self.type = aDecoder.decodeObject(forKey: "Type") as! String
        self.date = (aDecoder.decodeObject(forKey: "Date") as! NSDate) as Date
        self.summary = aDecoder.decodeObject(forKey: "Summary") as! String
        self.fullDetail = aDecoder.decodeObject(forKey: "FullDetail") as! String
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Service {
        self.title = aDecoder.decodeObject(forKey: "Title") as! String
        self.type = aDecoder.decodeObject(forKey: "Type") as! String
        self.date = (aDecoder.decodeObject(forKey: "Date") as! NSDate) as Date
        self.summary = aDecoder.decodeObject(forKey: "Summary") as! String
        self.fullDetail = aDecoder.decodeObject(forKey: "FullDetail") as! String
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(type, forKey: "Type")
        aCoder.encode(date, forKey: "Date")
        aCoder.encode(summary, forKey: "Summary")
        aCoder.encode(fullDetail, forKey: "FullDetail")
    }
    
}
