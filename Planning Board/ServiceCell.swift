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
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.grayColor
        label.font = label.font.withSize(25)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = label.font.withSize(11)
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(service: Service, reuseIdentifier: String) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.service = service
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(cardView)
        cardView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))
        
        [titleLabel, dateLabel, typeLabel].forEach { self.cardView.addSubview($0) }
        titleLabel.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        titleLabel.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.3).isActive = true
        titleLabel.text = self.service.title
    }
}
