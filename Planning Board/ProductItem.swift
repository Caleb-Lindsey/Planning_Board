//
//  ProductItem.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/8/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class ProductItem {
    
    var title: String!
    var segment: Segment!
    var host : Member?
    var time : Int = 0
    
    init(segment: Segment) {
        self.title = segment.name
        self.segment = segment
    }
    
    init(element: String, segment: Segment) {
        self.title = element
        self.segment = segment
    }
    
    func getTimeLabel() -> String {
        if self.time > 0 {
            //let hours : Int = time / 3600
            let minutes : Int = (time % 3600) / 60
            let seconds : Int = (time % 3600) % 60
            if seconds < 10 {
                return "\(minutes):0\(seconds)"
            } else {
                return "\(minutes):\(seconds)"
            }
        } else {
            return "0:00"
        }
    }
    
}
