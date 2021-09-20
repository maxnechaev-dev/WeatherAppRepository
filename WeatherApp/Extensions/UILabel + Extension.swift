//
//  UILabel + Extension.swift
//  WeatherApp
//
//  Created by Max Nechaev on 10.09.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String,
                     font: UIFont?,
                     textColor: UIColor) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = textColor
    }
}
