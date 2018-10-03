//
//  ServiceObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/14/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Service: Codable {
    
    var title: String = String()
    var type: String = String()
    var date: Date = Date()
    //var summary
    
    init(title: String, type: String, date: Date) {
        self.title = title
        self.type = type
        self.date = date
    }
    
    func getFormattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, M-dd-yyyy"
        return formatter.string(from: self.date)
    }
}
