//
//  ServiceComponent.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/8/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

enum ServiceComponentType {
    case segment(Segment)
    case element(Element)
    
    func getTitle() -> String {
        switch self {
        case .segment(let segment):
            return segment.title
        case .element(let element):
            return element.title
        }
    }
}

class ServiceComponent: Codable {
    
    var type: ServiceComponentType
    var host: Member?
    var time: Int = 0
    
    init(type: ServiceComponentType) {
        self.type = type
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(ServiceComponentType.self, forKey: .type)
        self.host = try container.decodeIfPresent(Member.self, forKey: .host)
        self.time = try container.decode(Int.self, forKey: .time)
    }
    
    func getTimeLabel() -> String {
        if self.time > 0 {
            let minutes: Int = (time % 3600) / 60
            let seconds: Int = (time % 3600) % 60
            if seconds < 10 {
                return "\(minutes):0\(seconds)"
            }
            return "\(minutes):\(seconds)"
        }
        return "0:00"
    }
}
