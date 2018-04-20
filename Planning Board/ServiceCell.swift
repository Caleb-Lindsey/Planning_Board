//
//  ServiceCell.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 4/19/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class ServiceCell : UITableViewCell {
    
    var service : ServiceObject!
    
    let titleLabel : UILabel = {
        let label = UILabel()
        //label.layer.borderWidth = 0.5
        label.font = label.font.withSize(25)
        label.textAlignment = .center
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = label.font.withSize(11)
        //label.layer.borderWidth = 0.5
        return label
    }()
    
    let typeLabel : UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 0.5
        return label
    }()
    
    init(service: ServiceObject, reuseIdentifier: String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.service = service
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cellWidth : CGFloat = self.contentView.frame.width
        let cellHeight : CGFloat = self.contentView.frame.height
        
        // Place Date Label
        dateLabel.frame = CGRect(x: 0, y: 0, width: cellWidth - 5 - 5, height: 20)
        let formatter = DateFormatter()
        formatter.dateFormat = "E, M-d-yy"
        dateLabel.text = formatter.string(from: self.service.date)
        self.contentView.addSubview(dateLabel)
        
        // Place Title Label
        titleLabel.frame = CGRect(x: 5, y: dateLabel.frame.maxY, width: dateLabel.frame.width, height: cellHeight - dateLabel.frame.height)
        self.contentView.addSubview(titleLabel)
        
    }
    
}











