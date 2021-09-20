//
//  MainConfigurator.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import UIKit

class MainConfigurator {
    static func configure() -> UIViewController {
        
        let dataFetcherService = DataFetcherService()
        let interactor = MainInteractor(dataFetcher: dataFetcherService)
        let router = MainRouter()
        let presenter = MainPresenter(router: router, interactor: interactor)
        let view = MainViewController(output: presenter)
        
        presenter.viewController = view
                
        interactor.dataFetcher = dataFetcherService
        interactor.presenter = presenter
        
        return view
    }
}
