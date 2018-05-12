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
    
    let hostImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = Global.greenColor.cgColor
        imageView.layer.borderWidth = 0.4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        
        timeButton.frame = CGRect(x: 5, y: 5, width: contentView.frame.width * (1/4) - 10, height: contentView.frame.height - 10)
        timeButton.addTarget(self, action: #selector(timePressed), for: .touchUpInside)
        contentView.addSubview(timeButton)
        
        hostImageView.frame = CGRect(x: contentView.frame.width - timeButton.frame.height - 5, y: 5, width: timeButton.frame.height, height: timeButton.frame.height)
        hostImageView.layer.cornerRadius = hostImageView.frame.width / 2
        //hostImageView.image = productItem.host?.profilePic
        hostImageView.image = #imageLiteral(resourceName: "blank_profile")
        contentView.addSubview(hostImageView)
        
        titleLabel.frame = CGRect(x: timeButton.frame.maxX + 5, y: 5, width: contentView.frame.width - timeButton.frame.width - hostImageView.frame.width - 20, height: timeButton.frame.height)
        titleLabel.text = productItem.title
        contentView.addSubview(titleLabel)
    }
    
    @objc func timePressed() {
        print("Time Pressed.")
    }
    
    func setTimeLabel() {
        timeButton.setTitle("\(productItem.time ?? 0)", for: .normal)
    }
    
}

















