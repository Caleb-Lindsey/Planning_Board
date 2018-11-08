//
//  Element.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/21/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class Element: Codable {
    
    var title: String!
    var link: String?
    var lastUsed: String?
    
    init(title: String) {
        self.title = title
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
        self.lastUsed = try container.decodeIfPresent(String.self, forKey: .lastUsed)
    }
}
