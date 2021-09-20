//
//  UIStackView + Extension.swift
//  WeatherApp
//
//  Created by Max Nechaev on 11.09.2021.
//

import UIKit

extension UIStackView {
    convenience init (arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
