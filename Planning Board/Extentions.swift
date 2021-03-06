//
//  Extentions.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 6/23/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func fillSuperView(viewToFill view: UIView) {
        self.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}

extension ServiceComponentType: Encodable {
    enum CodingKeys: CodingKey {
        case segment
        case element
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .segment(let value):
            try container.encode(value, forKey: .segment)
        case .element(let value):
            try container.encode(value, forKey: .element)
        }
    }
}

extension ServiceComponentType: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let segmentValue =  try container.decode(Segment.self, forKey: .segment)
            self = .segment(segmentValue)
        } catch {
            let elementValue =  try container.decode(Element.self, forKey: .element)
            self = .element(elementValue)
        }
    }
}
