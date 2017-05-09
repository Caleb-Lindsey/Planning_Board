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
    static var grayColor = UIColor(colorLiteralRed: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1)
    static var segObjArr = [SegmentObject]()
}

class Datasource {
    
    //Variables
    let databaseReference = FIRDatabase.database().reference()
    
    func fillData(completion : @escaping () -> ()) {
        
        databaseReference.child(GlobalVariables.userName).child("Service Parts").observe(.childAdded, with: {
            snapshot in
            
            let dataDict = snapshot.value as! [String : String]
            let dataKey : String = snapshot.key
            
            //GlobalVariables.resourceDict[dataKey] = Array(dataDict.values)
            
            let newSegObj = SegmentObject(Name: dataKey, Elements: Array(dataDict.values), IconImage: #imageLiteral(resourceName: "fire_icon"), Duration: 0)
            GlobalVariables.segObjArr.append(newSegObj)
            
            GlobalVariables.segmentArray.append(newSegObj.name)
            
            DispatchQueue.main.async {
                completion()
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
        
        let newSegObj = SegmentObject(Name: segmentName, Elements: elementArray, IconImage: #imageLiteral(resourceName: "fire_icon"), Duration: 0)
        GlobalVariables.segObjArr.append(newSegObj)
        
    }
    
    func addElement(row : Int,segment : SegmentObject ,newElement : String) {
        
        let post : [String : AnyObject] = ["element\(row)" : newElement as AnyObject]
        databaseReference.child(GlobalVariables.userName).child("Service Parts").child(segment.name).updateChildValues(post)
        
    }
    
}



















