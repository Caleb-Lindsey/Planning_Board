//
//  Datasource.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 2/11/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import Firebase

struct GlobalVariables {
    static var userName = String()
    static var segmentArray = [String]()
    static var popoverChoice = String()
    static var greenColor = UIColor(red: 75/255.0, green: 108/255.0, blue: 35/255.0, alpha: 1)
    static var lighterGreenColor = UIColor(red: 85/255.0, green: 142/255.0, blue: 25/255.0, alpha: 1)
    static var grayColor = UIColor(red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1)
    static var segObjArr = [SegmentObject]()
    static var memberArr = [Member]()
    static var serviceDetailArray : [ProductItem] = [ProductItem]()
    static var arrayOfServices : [ServiceObject] = [ServiceObject]()
    static var arrayOfIcons : [UIImage] = [
        UIImage(named:"bible_icon")!,
        UIImage(named:"clock")!,
        UIImage(named:"door_icon")!,
        UIImage(named:"fire_icon")!,
        UIImage(named:"giving")!,
        UIImage(named:"meeting_icon")!,
        UIImage(named:"mike_icon")!,
        UIImage(named:"movie_icon")!,
        UIImage(named:"plan_icon")!,
        UIImage(named:"prayer_hands")!,
        UIImage(named:"speaking_icon")!,
        UIImage(named:"party")!,
        UIImage(named:"unload")!,
        UIImage(named:"groceries")!,
        UIImage(named:"dedications")!,
        UIImage(named:"clapperBoard")!,
        UIImage(named:"candy")!,
        UIImage(named:"baptisms")!,
        UIImage(named:"balloons")!]
}

class Datasource {
    
    func fillServiceData()
    {
        print("Filling Services")
        if let data = UserDefaults.standard.object(forKey: "ServiceList") as? NSData {
            GlobalVariables.arrayOfServices = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [ServiceObject]
        }
    }
    
    func fillSegmentData() {
        
        print("Filling Segments")
        if let data = UserDefaults.standard.object(forKey: "SegmentList") as? NSData {
            GlobalVariables.segObjArr = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [SegmentObject]
            
            
            
        }
        
    }
    
    func fillElementData() {
        
        
        
    }
    
    func fillMemberData() {
        
        print("Filling Members")
        if let data = UserDefaults.standard.object(forKey: "MemberList") as? NSData {
            GlobalVariables.memberArr = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Member]
        }
        
    }
    
    func uploadService() {
        
        let data = NSKeyedArchiver.archivedData(withRootObject: GlobalVariables.arrayOfServices)
        UserDefaults.standard.set(data, forKey: "ServiceList")
        print("Services Saved")
    }
    
    func uploadSegment() {
        
        let data = NSKeyedArchiver.archivedData(withRootObject: GlobalVariables.segObjArr)
        UserDefaults.standard.set(data, forKey: "SegmentList")
        print("Segments Saved")
        
    }
    
    func uploadElement() {
        
        
        
    }
    
    func uploadMember() {
        
        let data = NSKeyedArchiver.archivedData(withRootObject: GlobalVariables.memberArr)
        UserDefaults.standard.set(data, forKey: "MemberList")
        print("Members Saved")
        
    }
    
}

















