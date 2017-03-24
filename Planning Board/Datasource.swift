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
    static var resourceDict = [String : [String]]()
}

class Datasource {
    
    func fillData(completion : @escaping () -> ()) {
        
        let databaseReference = FIRDatabase.database().reference()
        
        
        databaseReference.child(GlobalVariables.userName).child("Service Parts").observe(.childAdded, with: {
            snapshot in
            
            let dataDict = snapshot.value as! [String : String]
            let dataKey : String = snapshot.key
            
            GlobalVariables.resourceDict[dataKey] = Array(dataDict.values)
            
            DispatchQueue.main.async {
                completion()
            }
            
        })

    }
    
}
