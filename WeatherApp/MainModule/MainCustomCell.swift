//
//  MainCustomCell.swift
//  WeatherApp
//
//  Created by Max Nechaev on 10.09.2021.
//

import UIKit

class MainCustomCell: UICollectionViewCell {
    
    let cityNameLabel = UILabel(text: "Moscow", font: .systemFont(ofSize: 30, weight: .light), textColor: .mainTextColor())
    let tempLabel = UILabel(text: "20°C", font: .systemFont(ofSize: 35, weight: .light), textColor: .mainTextColor())
    let imageView = UIImageView(image: UIImage(named: "ovc_ts"), contentMode: .scaleAspectFit)
    let conditionLabel = UILabel(text: "Condition", font: .systemFont(ofSize: 20, weight: .light), textColor: .mainTextColor())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .mainCellsColor()
        layer.cornerRadius = 8
        setupConstraints()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainCustomCell {
    func setupConstraints() {
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tempLabel)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [cityNameLabel, conditionLabel], axis: .vertical, spacing: 3)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

