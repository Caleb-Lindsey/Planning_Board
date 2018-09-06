//
//  ProductPanel.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 5/19/18.
//  Copyright © 2018 KlubCo. All rights reserved.
//

import UIKit

class ProductPanel: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    var superView: UITableView!
    var productItem: ProductItem!
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    let segmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = label.font.withSize(25)
        label.numberOfLines = 2
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    let timePicker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    let hostTable: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 8
        return tableView
    }()
    
    let linkButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Media", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
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
        
        segmentLabel.frame = CGRect(x: 0, y: cancelButton.frame.maxY, width: self.frame.width, height: 75)
        segmentLabel.text = self.productItem.element?.title
        self.addSubview(segmentLabel)
        
        doneButton.frame = CGRect(x: self.frame.width - 100 - 5, y: 5, width: 100, height: 44)
        self.addSubview(doneButton)
        
        timePicker.frame = CGRect(x: 0, y: segmentLabel.frame.maxY, width: self.frame.width, height: 75)
        timePicker.delegate = self
        timePicker.dataSource = self
        self.addSubview(timePicker)
        
        hostTable.frame = CGRect(x: 15, y: timePicker.frame.maxY, width: self.frame.width - 30, height: 250)
        hostTable.register(MemberCell.self, forCellReuseIdentifier: "panelHostCell")
        hostTable.delegate = self
        hostTable.dataSource = self
        self.addSubview(hostTable)
        
        linkButton.frame = CGRect(x: 15, y: hostTable.frame.maxY, width: hostTable.frame.width, height: 50)
        self.addSubview(linkButton)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 91
        case 1:
            return 60
        default:
            return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) minutes"
        case 1:
            return "\(row) seconds"
        default:
            return "\(row) seconds"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MemberCell = MemberCell(member: Member(FirstName: "Julius", LastName: "Hoff", CanHost: [], ProfilePic: #imageLiteral(resourceName: "Ryan_Young")), reuseIdentifier: "panelHostCell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
