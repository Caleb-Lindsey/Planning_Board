//
//  MemberObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/24/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Member: Codable {
    
    var id: Int
    var firstName: String
    var lastName: String
    var username: String
    var profilePic: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.username = try container.decode(String.self, forKey: .username)
        self.profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic)
    }
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
}
