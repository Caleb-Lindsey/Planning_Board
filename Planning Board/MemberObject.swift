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

class Member : NSObject, NSCoding {
    
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
    override init() {
        self.firstName = ""
        self.lastName = ""
        self.canHost = [String]()
        self.profilePic = UIImage()
    }
    
    func fullName() -> String {
        return firstName + " " + lastName
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.firstName = aDecoder.decodeObject(forKey: "FirstName") as! String
        self.lastName = aDecoder.decodeObject(forKey: "LastName") as! String
        self.canHost = aDecoder.decodeObject(forKey: "canHost") as! [String]
        self.profilePic = aDecoder.decodeObject(forKey: "ProfilePic") as! UIImage
        
    }
    
    func initWithCoder(aDecoder: NSCoder) -> Member {
        
        self.firstName = aDecoder.decodeObject(forKey: "FirstName") as! String
        self.lastName = aDecoder.decodeObject(forKey: "LastName") as! String
        self.canHost = aDecoder.decodeObject(forKey: "canHost") as! [String]
        self.profilePic = aDecoder.decodeObject(forKey: "ProfilePic") as! UIImage
        
        return self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: "FirstName")
        aCoder.encode(lastName, forKey: "LastName")
        aCoder.encode(canHost, forKey: "canHost")
        aCoder.encode(profilePic, forKey: "ProfilePic")
        
    }
    
}
























