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
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 2
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = label.font.withSize(25)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = label.font.withSize(13)
        label.textColor = Colors.clearBlack
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunday Service"
        return label
    }()
    
    let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevron_right")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        
        [titleLabel, dateLabel, typeLabel, chevronImageView].forEach { self.cardView.addSubview($0) }
        titleLabel.anchor(top: cardView.topAnchor, leading: cardView.leadingAnchor, bottom: cardView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 5, bottom: 5, right: 5))
        titleLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.75).isActive = true
        titleLabel.text = self.service.title
        
        dateLabel.anchor(top: cardView.topAnchor, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 5, right: 5))
        dateLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.25).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.25).isActive = true
        dateLabel.text = self.service.getFormattedDate()
        
        chevronImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: cardView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 30, height: 30))
        chevronImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
    }
}
