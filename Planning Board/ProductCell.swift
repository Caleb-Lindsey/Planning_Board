//
//  PlannerItemCell.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/8/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class ProductCell : UITableViewCell {
    
    var productItem : ProductItem!
    var tableView : UITableView!
    
    let timeLabel : UILabel = {
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
    
    let hostImage : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = Global.greenColor.cgColor
        imageView.layer.borderWidth = 0.4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "blank_profile")
        return imageView
    }()
    
    init(productItem: ProductItem, reuseIdentifier: String?, tableView: UITableView) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.productItem = productItem
        self.tableView = tableView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeLabel.frame = CGRect(x: 15, y: 5, width: contentView.frame.width * (1/4) - 20, height: contentView.frame.height - 10)
        productItem.time = 180
        timeLabel.text = productItem.getTimeLabel()
        contentView.addSubview(timeLabel)
        
        hostImage.frame = CGRect(x: contentView.frame.width - timeLabel.frame.height - 15, y: 5, width: timeLabel.frame.height, height: timeLabel.frame.height)
        hostImage.layer.cornerRadius = hostImage.frame.width / 2
        //hostImageView.image = productItem.host?.profilePic
        contentView.addSubview(hostImage)
        
        titleLabel.frame = CGRect(x: timeLabel.frame.maxX + 5, y: 5, width: contentView.frame.width - timeLabel.frame.width - hostImage.frame.width - 40, height: timeLabel.frame.height)
        titleLabel.text = productItem.element?.title
        contentView.addSubview(titleLabel)
    }
    
}

















