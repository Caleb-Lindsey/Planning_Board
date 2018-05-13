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
    
    let timeButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.layer.borderWidth = 0.4
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 6
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let hostButton : UIButton = {
        let button = UIButton()
        button.layer.borderColor = Global.greenColor.cgColor
        button.layer.borderWidth = 0.4
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "blank_profile"), for: .normal)
        return button
    }()
    
    init(productItem: ProductItem, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.productItem = productItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timeButton.frame = CGRect(x: 15, y: 5, width: contentView.frame.width * (1/4) - 20, height: contentView.frame.height - 10)
        timeButton.addTarget(self, action: #selector(timePressed), for: .touchUpInside)
        productItem.time = 181
        timeButton.setTitle(productItem.getTimeLabel(), for: .normal)
        contentView.addSubview(timeButton)
        
        hostButton.frame = CGRect(x: contentView.frame.width - timeButton.frame.height - 15, y: 5, width: timeButton.frame.height, height: timeButton.frame.height)
        hostButton.addTarget(self, action: #selector(hostPressed), for: .touchUpInside)
        hostButton.layer.cornerRadius = hostButton.frame.width / 2
        //hostImageView.image = productItem.host?.profilePic
        contentView.addSubview(hostButton)
        
        titleLabel.frame = CGRect(x: timeButton.frame.maxX + 5, y: 5, width: contentView.frame.width - timeButton.frame.width - hostButton.frame.width - 40, height: timeButton.frame.height)
        titleLabel.text = productItem.title
        contentView.addSubview(titleLabel)
    }
    
    @objc func timePressed() {
        print("Time Pressed.")
    }
    
    @objc func hostPressed() {
        print("Host Pressed.")
    }
    
}

















