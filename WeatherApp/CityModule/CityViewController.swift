//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Max Nechaev on 11.09.2021.
//

import UIKit

protocol CityViewOutput {
    func fillByData()
}

class CityViewController: UIViewController {
    
    var output: CityViewOutput
    
    var weather: Weather?
    
    let nameLabel = UILabel(text: "CityName", font: .systemFont(ofSize: 35, weight: .bold), textColor: .mainTextColor())
    let tempLabel = UILabel(text: "20°C", font: .systemFont(ofSize: 35, weight: .light), textColor: .mainTextColor())
    let feelsLikeLabel = UILabel(text: "Feels like 20°C", font: .systemFont(ofSize: 35, weight: .light), textColor: .mainTextColor())
    let conditionLabel = UILabel(text: "Overcast", font: .systemFont(ofSize: 25, weight: .light), textColor: .mainTextColor())
    let imageView = UIImageView(image: UIImage(named: "ovc_ts"), contentMode: .scaleAspectFit)
    let spaceImageView = UIImageView(image: UIImage(named: "space"), contentMode: .scaleAspectFit)

    
    //MARK: - init
    
    init(output: CityViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackgroundColor()
        setupViewsSettings()
        setupConstraints()
        fillByData()
    }
    
    func setupViewsSettings() {
        nameLabel.textAlignment = .center
        tempLabel.textAlignment = .center
        feelsLikeLabel.textAlignment = .center
        conditionLabel.textAlignment = .center
        
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        spaceImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fillByData() {
        output.fillByData()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup constraints

extension CityViewController {
    
    func setupConstraints() {
        let mainStackView = UIStackView(arrangedSubviews: [nameLabel, tempLabel, feelsLikeLabel], axis: .vertical, spacing: 20)
        
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(conditionLabel)
        view.addSubview(imageView)
        view.addSubview(spaceImageView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            conditionLabel.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
            
            imageView.trailingAnchor.constraint(equalTo: conditionLabel.leadingAnchor, constant: -5),
            imageView.centerYAnchor.constraint(equalTo: conditionLabel.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        NSLayoutConstraint.activate([
            spaceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spaceImageView.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 25),
            spaceImageView.widthAnchor.constraint(equalToConstant: 250),
            spaceImageView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
}
