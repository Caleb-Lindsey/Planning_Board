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
    var time : Int?
    
    init(segment: Segment) {
        self.title = segment.name
        self.segment = segment
    }
    
    init(element: String, segment: Segment) {
        self.title = element
        self.segment = segment
    }
    
    func setHost(host: Member) {
        self.host = host
    }
    
    func setTime(time: Int) {
        self.time = time
    }
    
}
