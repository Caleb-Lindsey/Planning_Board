//
//  PlannerItemCell.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/8/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class ComponentCell: UITableViewCell {
    
    var serviceComponent: ServiceComponent!
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.layer.borderWidth = 0.4
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 6
        label.textAlignment = .center
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let hostImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = Colors.greenColor.cgColor
        imageView.layer.borderWidth = 0.4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "blank_profile")
        return imageView
    }()
    
    init(productItem: ServiceComponent, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.serviceComponent = productItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeLabel.frame = CGRect(x: 15, y: 5, width: contentView.frame.width * (1/4) - 20, height: contentView.frame.height - 10)
        serviceComponent.time = 180
        timeLabel.text = serviceComponent.getTimeLabel()
        contentView.addSubview(timeLabel)
        
        hostImage.frame = CGRect(x: contentView.frame.width - timeLabel.frame.height - 15, y: 5, width: timeLabel.frame.height, height: timeLabel.frame.height)
        hostImage.layer.cornerRadius = hostImage.frame.width / 2
        contentView.addSubview(hostImage)
        
        titleLabel.frame = CGRect(x: timeLabel.frame.maxX + 5, y: 5, width: contentView.frame.width - timeLabel.frame.width - hostImage.frame.width - 40, height: timeLabel.frame.height)
        titleLabel.text = serviceComponent.type.getTitle()
        contentView.addSubview(titleLabel)
    }
}
