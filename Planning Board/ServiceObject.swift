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

class ServiceObject {
    
    var title : String = String()
    var type : String = String()
    var date : NSDate = NSDate()
    var summary : String = String()
    var fullDetail : String = String()
    
    init(title: String, type: String, date: NSDate, summary: String, fullDetail: String) {
        
        self.title = title
        self.type = type
        self.date = date
        self.summary = summary
        self.fullDetail = fullDetail
        
    }
    
}
