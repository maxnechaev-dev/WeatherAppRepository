//
//  CityPresenter.swift
//  WeatherApp
//
//  Created by Max Nechaev on 11.09.2021.
//

import UIKit

class CityPresenter {
    
    weak var viewController: CityViewController?
    private var router: CityRouterProtocol
    private var interactor: CityInteractorProtocol
    
    //MARK: - Init

    init(router: CityRouterProtocol,
         interactor: CityInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func fillByData() {
        
        guard let cityWeather = viewController?.weather else { return print("Can't take weather") }
        
        viewController?.nameLabel.text = cityWeather.info.tzinfo.name.replacingOccurrences(of: "/", with: ", ").replacingOccurrences(of: "_", with: " ")
        viewController?.tempLabel.text = "\(cityWeather.fact.temp)°C"
        viewController?.feelsLikeLabel.text = "Feels like \(cityWeather.fact.feels_like)°C"
        viewController?.conditionLabel.text = cityWeather.fact.condition.capitalized
        viewController?.imageView.image = UIImage(named: cityWeather.fact.icon)
    }
    
}

extension CityPresenter: CityInteractorOutputs {
    
}

extension CityPresenter: CityViewOutput {
    
}
