//
//  PlannerSegmentCell.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/4/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class PlannerSegmentCell : UITableViewCell {
    
    var segment : Segment!
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
        
        iconImageView.frame = CGRect(x: 5, y: 5, width: self.contentView.frame.width - 10, height: self.contentView.frame.height * (3/4) - 5)
        iconImageView.image = self.segment.iconImage
        self.contentView.addSubview(iconImageView)
        
        titleLabel.frame = CGRect(x: iconImageView.frame.origin.x, y: iconImageView.frame.maxY, width: iconImageView.frame.width, height: self.contentView.frame.height * (1/4) - 5)
        titleLabel.text = self.segment.name
        self.contentView.addSubview(titleLabel)
        
    }
    
}
