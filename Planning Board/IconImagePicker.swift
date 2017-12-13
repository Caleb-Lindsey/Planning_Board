//
//  IconImagePicker.swift
//  Planning Board
//
//  Created by Caleb Lindsey on 12/13/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit

class IconImagePicker : UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GlobalVariables.arrayOfIcons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.frame.height
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerView : UIView = UIView(frame: self.frame)
        pickerView.frame.size.width /= 3
        pickerView.layer.borderWidth = 1
        pickerView.layer.cornerRadius = pickerView.frame.width / 2
        let pickerImageView : UIImageView = UIImageView(image: GlobalVariables.arrayOfIcons[row])
        pickerImageView.frame = CGRect(x: pickerView.frame.width / 4, y: pickerView.frame.height / 4, width: pickerView.frame.width / 2, height: pickerView.frame.height / 2)
        pickerImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi / 2)
        pickerView.addSubview(pickerImageView)
        return pickerView
    }
    
}















