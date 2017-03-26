//
//  MemberObject.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 3/24/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

/*
 A class to hold all information about a member.
    - First Name
    - Last Name
    - Profile Picture
    - Array of hostable segments
*/

class Member {
    
    //Variables
    var firstName = String()
    var lastName = String()
    var canHost = [String]()
    var profilePic = UIImage()
    
    init(FirstName: String, LastName: String, CanHost: [String], ProfilePic: UIImage) {
    
        self.firstName = FirstName
        self.lastName = LastName
        self.canHost = CanHost
        self.profilePic = ProfilePic
        
    }
}
























