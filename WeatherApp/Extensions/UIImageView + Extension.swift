//
//  UIImageView + Extension.swift
//  WeatherApp
//
//  Created by Max Nechaev on 10.09.2021.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
