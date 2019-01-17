//
//  ServiceObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/14/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Service: Codable {
    
    var id: Int
    var title: String
    var date: String?
    var type: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }
    
    func getFormattedDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/dd/yy"
        
        if let date = dateFormatterGet.date(from: self.date ?? "") {
            return dateFormatterPrint.string(from: date)
        }
        return ""
    }
}
