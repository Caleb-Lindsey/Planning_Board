//
//  MemberObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/24/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class Member: Codable {
    
    var firstName: String!
    var lastName: String!
    var canHost: [String]?
    var profilePic: String?
    
    init(FirstName: String, LastName: String) {
        self.firstName = FirstName
        self.lastName = LastName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.canHost = try container.decodeIfPresent([String].self, forKey: .canHost)
        self.profilePic = try container.decodeIfPresent(String.self, forKey: .profilePic)
    }
    
    func fullName() -> String {
        return "\(firstName!) \(lastName!)"
    }
}
