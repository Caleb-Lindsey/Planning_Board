//
//  SegmentObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/25/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Segment: Codable {
    
    var title: String!
    var elements: [Element]?
    var iconImage: String?
    var lastUsed: String?
    
    init(title: String) {
        self.title = title
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.elements = try container.decodeIfPresent([Element].self, forKey: .elements)
        self.iconImage = try container.decodeIfPresent(String.self, forKey: .iconImage)
        self.iconImage = try container.decodeIfPresent(String.self, forKey: .lastUsed)
    }
}
