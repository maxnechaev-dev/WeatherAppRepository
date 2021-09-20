//
//  MainRouter.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import UIKit

protocol MainRouterProtocol {
    func pushViewController(element: Weather, navigation: UINavigationController)
    func pushViewControllerToOneCity(element: Weather, navigation: UINavigationController)
}

class MainRouter: MainRouterProtocol {
    
    func pushViewController(element: Weather, navigation: UINavigationController) {
        let cityVC = CityConfigurator.configure(weather: element)
        navigation.pushViewController(cityVC, animated: true)
    }
    
    func pushViewControllerToOneCity(element: Weather, navigation: UINavigationController) {
        let cityVC = CityConfigurator.configure(weather: element)
        navigation.pushViewController(cityVC, animated: true)
    }
}
