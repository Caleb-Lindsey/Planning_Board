//
//  Element.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/21/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class Element: Codable {
    
    var id: Int
    var title: String
    var link: String?
    var lastUsed: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
        self.lastUsed = try container.decodeIfPresent(String.self, forKey: .lastUsed)
    }
}
