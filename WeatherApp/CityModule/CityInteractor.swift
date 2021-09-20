//
//  CityInteractor.swift
//  WeatherApp
//
//  Created by Max Nechaev on 11.09.2021.
//

import Foundation

protocol CityInteractorOutputs: AnyObject {

}

protocol CityInteractorProtocol {
    
}

class CityInteractor: CityInteractorProtocol {

    //MARK: - Dependencies
    
    var dataFetcher: DataFetcherServiceProtocol
    weak var presenter: CityInteractorOutputs?

    //MARK: - Init

    init(dataFetcher: DataFetcherServiceProtocol) {
        self.dataFetcher = dataFetcher
    }
    
}
