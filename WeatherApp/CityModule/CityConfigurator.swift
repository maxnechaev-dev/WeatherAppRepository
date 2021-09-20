//
//  CityConfigurator.swift
//  WeatherApp
//
//  Created by Max Nechaev on 11.09.2021.
//

import UIKit

class CityConfigurator {
    
    static func configure(weather: Weather) -> UIViewController {
                
        let dataFetcherService = DataFetcherService()
        let interactor = CityInteractor(dataFetcher: dataFetcherService)
        let router = CityRouter()
        let presenter = CityPresenter(router: router, interactor: interactor)
        let view = CityViewController(output: presenter)
        
        presenter.viewController = view
                
        interactor.dataFetcher = dataFetcherService
        interactor.presenter = presenter
        
        view.weather = weather
        
        return view
    }
}
