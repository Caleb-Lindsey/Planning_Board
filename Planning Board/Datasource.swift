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
    static var greenColor = UIColor(colorLiteralRed: 75/255.0, green: 108/255.0, blue: 35/255.0, alpha: 1)
    static var lighterGreenColor = UIColor(colorLiteralRed: 85/255.0, green: 142/255.0, blue: 25/255.0, alpha: 1)
    static var grayColor = UIColor(colorLiteralRed: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1)
    static var segObjArr = [SegmentObject]()
    static var memberArr = [Member]()
    static var initialLoadComplete : Bool = false
    static var serviceDetailArray : [ProductItem] = [ProductItem]()
}

class Datasource {
    
    //Variables
    let databaseReference = FIRDatabase.database().reference()
    
    func fillData(completion : @escaping () -> ()) {
        
        databaseReference.child(GlobalVariables.userName).child("Service Parts").observe(.childAdded, with: {
            snapshot in
            let dataDict = snapshot.value as! [String : String]
            let dataKey : String = snapshot.key
            
            let newSegObj = SegmentObject(Name: dataKey, Elements: Array(dataDict.values), IconImage: #imageLiteral(resourceName: "fire_icon"))
            GlobalVariables.segObjArr.append(newSegObj)
            
            GlobalVariables.segmentArray.append(newSegObj.name)
            
            
        })
        
        completion()
    }
    
    func fillMemberData(completion : @escaping () -> ()) {
        
            databaseReference.child(GlobalVariables.userName).child("Members").observe(.childAdded, with: {
                snapshot in
                if GlobalVariables.initialLoadComplete == false {
                    var dataDict = snapshot.value as! [String : String]
                    let first : String = dataDict["firstName"]!
                    dataDict.removeValue(forKey: "firstName")
                    let last : String = dataDict["lastName"]!
                    dataDict.removeValue(forKey: "lastName")
                    
                    let newMember = Member(FirstName: first, LastName: last, CanHost: Array(dataDict.values), ProfilePic: #imageLiteral(resourceName: "Ryan_Young"))
                    GlobalVariables.memberArr.append(newMember)
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            })
        
    }
    
    func uploadSegment(segmentName : String, elementArray : [String]) {
        
        var elementCount : Int = 1
        
        for index in 0..<elementArray.count {
            let post : [String : AnyObject] = ["element\(elementCount)" : elementArray[index] as AnyObject]
            databaseReference.child(GlobalVariables.userName).child("Service Parts").child(segmentName).updateChildValues(post)
            elementCount += 1
        }
        
        let newSegObj = SegmentObject(Name: segmentName, Elements: elementArray, IconImage: #imageLiteral(resourceName: "fire_icon"))
        GlobalVariables.segObjArr.append(newSegObj)
        
    }
    
    func addElement(row : Int,segment : SegmentObject ,newElement : String) {
        
        let post : [String : AnyObject] = ["element\(row)" : newElement as AnyObject]
        databaseReference.child(GlobalVariables.userName).child("Service Parts").child(segment.name).updateChildValues(post)
        
    }
    
    func removeElement(segmentObject : SegmentObject) {
        
        removeSegment(segmentObject: segmentObject)
        uploadSegment(segmentName: segmentObject.name , elementArray: segmentObject.elements)
        
    }
    
    func removeSegment(segmentObject : SegmentObject) {
        
        databaseReference.child(GlobalVariables.userName).child("Service Parts").child(segmentObject.name).removeValue()
        
    }
    
    
    func uploadMember(firstName : String, lastName : String, hostables : [String]) {
        
        let firstPost : [String : AnyObject] = ["firstName" : firstName as AnyObject]
        let lastPost : [String : AnyObject] = ["lastName" : lastName as AnyObject]
        var hostCount : Int = 1
        
        databaseReference.child(GlobalVariables.userName).child("Members").child("\(firstName) \(lastName)").updateChildValues(firstPost)
        databaseReference.child(GlobalVariables.userName).child("Members").child("\(firstName) \(lastName)").updateChildValues(lastPost)

        for index in 0..<hostables.count {
            let post : [String : AnyObject] = ["segment\(hostCount)" : hostables[index] as AnyObject]
            databaseReference.child(GlobalVariables.userName).child("Members").child("\(firstName) \(lastName)").updateChildValues(post)
            hostCount += 1
        }
        
        let newMemberObject = Member(FirstName: firstName, LastName: lastName, CanHost: hostables, ProfilePic: #imageLiteral(resourceName: "Ryan_Young"))
        GlobalVariables.memberArr.append(newMemberObject)
        
    }
    
    func removeMember(member : Member) {
        
        databaseReference.child(GlobalVariables.userName).child("Members").child("\(member.firstName) \(member.lastName)").removeValue()
        
    }
    
    func removeHostable(member : Member) {
        
        removeMember(member: member)
        uploadMember(firstName: member.firstName, lastName: member.lastName, hostables: member.canHost)
        
    }
    
}



















