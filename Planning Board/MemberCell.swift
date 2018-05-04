//
//  MemberCell.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 12/6/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class MemberCell : UITableViewCell {
    
    // Variables
    var member : Member!
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel : UILabel = {
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
    
    init(member: Member, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.member = member
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        // Profile Image View
        profileImageView.frame = CGRect(x: 15, y: 15, width: 50, height: contentView.frame.height - 15 - 15)
        profileImageView.image = member.profilePic
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        self.contentView.addSubview(profileImageView)
        
        // Name Label
        nameLabel.frame = CGRect(x: profileImageView.frame.maxX + 15, y: 0, width: contentView.frame.width - 15 - profileImageView.frame.width - 15, height: 20)
        nameLabel.frame.origin.y = profileImageView.frame.origin.y + profileImageView.frame.height / 5
        nameLabel.text = member.fullName()
        self.contentView.addSubview(nameLabel)
        
        // Sub Label
        subLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.maxY, width: nameLabel.frame.width, height: nameLabel.frame.height)
        subLabel.text = getSubLabel()
        self.contentView.addSubview(subLabel)
        
        
    }
    
    private func getSubLabel() -> String {
        
        if member.canHost != [] {
            
            if member.canHost.count >= 3 {
                return "\(member.canHost[0]), \(member.canHost[1]) + \(member.canHost.count - 2) more"
            } else if member.canHost.count == 2 {
                return "\(member.canHost[0]) and \(member.canHost[1])"
            } else {
                return "\(member.canHost[0])"
            }
            
        } else {
            return " "
        }
        
    }
    
}


















