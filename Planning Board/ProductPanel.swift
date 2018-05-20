//
//  ProductPanel.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/19/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class ProductPanel : UIView {
    
    var superView : UITableView!
    var productItem : ProductItem!
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    let segmentLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = label.font.withSize(35)
        return label
    }()
    
    let doneButton : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    let timePicker : UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let hostTable : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let linkButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    init(productItem: ProductItem, superView: UITableView) {
        super.init(frame: CGRect(x: superView.frame.width, y: 0, width: superView.frame.width, height: superView.frame.height))
        self.productItem = productItem
        self.superView = superView
        self.frame.origin.x = superView.frame.width
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = superView.layer.cornerRadius
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cancelButton.frame = CGRect(x: 5, y: 5, width: 100, height: 44)
        self.addSubview(cancelButton)
        
        segmentLabel.frame = CGRect(x: 0, y: cancelButton.frame.maxY, width: self.frame.width, height: 50)
        segmentLabel.text = self.productItem.title
        self.addSubview(segmentLabel)
        
        doneButton.frame = CGRect(x: self.frame.width - 100 - 5, y: 5, width: 100, height: 44)
        self.addSubview(doneButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func animateIntoView() {
        self.superView.isScrollEnabled = false
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.frame.origin.x = 0
        })
    }
    
    @objc private func dismissView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.frame.origin.x = self.superView.frame.width
        }) { (finished) in
            self.removeFromSuperview()
            self.superView.isScrollEnabled = true
        }
    }
    
}
