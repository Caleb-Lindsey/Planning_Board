//
//  Datasource.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 2/11/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import Firebase

class Datasource {
    
    func fillSegmentArray() {
        
        let databaseReference = FIRDatabase.database().reference()
        
        databaseReference.child(GlobalVariables.userName).child("ZZZ_DeveloperTools_ZZZ").observe(.childAdded, with: {
            snapshot in
            
            let dataDict = snapshot.value as! [String : String]
            
            GlobalVariables.segmentArray.append(dataDict["Segment"]! as String)
            //GlobalVariables.resourceDict["Segments"] = GlobalVariables.segmentArray

        })
        
    }
    
}
