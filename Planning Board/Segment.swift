//
//  SegmentObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/25/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Segment: Codable {
    
    var id: Int
    var title: String
    var iconImage: String?
    var lastUsed: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.iconImage = try container.decodeIfPresent(String.self, forKey: .iconImage)
        self.lastUsed = try container.decodeIfPresent(String.self, forKey: .lastUsed)
    }
}
