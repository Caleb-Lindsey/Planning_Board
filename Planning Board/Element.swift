//
//  Element.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/21/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class Element {
    
    var title = String()
    var link = String()
    var lastUsed = Date()
    
    init(title: String, link: String) {
        self.title = title
        self.link = link
    }
}
