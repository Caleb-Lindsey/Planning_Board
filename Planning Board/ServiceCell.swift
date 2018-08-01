//
//  ServiceCell.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 4/19/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class ServiceCell: UITableViewCell {
    
    var service: Service!
    
    let sideView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.grayColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        //label.layer.borderWidth = 0.5
        label.font = label.font.withSize(25)
        label.textAlignment = .center
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = label.font.withSize(11)
        //label.layer.borderWidth = 0.5
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 0.5
        return label
    }()
    
    init(service: Service, reuseIdentifier: String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.service = service
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cellWidth : CGFloat = self.contentView.frame.width
        let cellHeight : CGFloat = self.contentView.frame.height
        
        // Place Side View
        sideView.frame = CGRect(x: 0, y: 5, width: 5, height: cellHeight - 10)
        self.contentView.addSubview(sideView)
        
        // Place Date Label
        dateLabel.frame = CGRect(x: 0, y: 0, width: cellWidth - 5 - 5, height: 20)
        dateLabel.text = service.getFormattedDate()
        self.contentView.addSubview(dateLabel)
        
        // Place Title Label
        titleLabel.frame = CGRect(x: sideView.frame.maxX, y: dateLabel.frame.maxY, width: cellWidth - 10, height: cellHeight - dateLabel.frame.height)
        titleLabel.text = self.service.title
        self.contentView.addSubview(titleLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            sideView.backgroundColor = Colors.greenColor
            titleLabel.textColor = Colors.grayColor
        } else {
            sideView.backgroundColor = UIColor.lightGray
            titleLabel.textColor = UIColor.lightGray
        }
    }
}
