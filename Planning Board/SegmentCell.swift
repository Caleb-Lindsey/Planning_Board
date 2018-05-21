//
//  SegmentCell.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 12/6/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class SegmentCell : UITableViewCell {
    
    // Variables
    var segment : Segment!
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        return label
    }()
    
    let subLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: "Helvetica", size: 10)
        return label
    }()
    
    init(segment: Segment, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.segment = segment
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Profile Image View
        iconImageView.frame = CGRect(x: 15, y: 15, width: 50, height: contentView.frame.height - 15 - 15)
        iconImageView.image = segment.iconImage
        self.contentView.addSubview(iconImageView)
        
        // Name Label
        titleLabel.frame = CGRect(x: iconImageView.frame.maxX + 15, y: 0, width: contentView.frame.width - 15 - iconImageView.frame.width - 15, height: 20)
        titleLabel.frame.origin.y = iconImageView.frame.origin.y + iconImageView.frame.height / 5
        titleLabel.text = segment.title
        self.contentView.addSubview(titleLabel)
        
        // Sub Label
        subLabel.frame = CGRect(x: titleLabel.frame.origin.x, y: titleLabel.frame.maxY, width: titleLabel.frame.width, height: titleLabel.frame.height)
        subLabel.text = getSubLabel()
        self.contentView.addSubview(subLabel)
        
    }
    
    private func getSubLabel() -> String {
        if !segment.elements.isEmpty {
            if segment.elements.count >= 3 {
                return "\(segment.elements[0].title), \(segment.elements[1].title) + \(segment.elements.count - 2) more"
            } else if segment.elements.count == 2 {
                return "\(segment.elements[0].title) and \(segment.elements[1].title)"
            } else {
                return "\(segment.elements[0].title)"
            }
        } else {
            return " "
        }
    }
    
}



















