//
//  DataFetcherService.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import Foundation

//MARK: - Data fetcher service

protocol DataFetcherServiceProtocol {
    func fetchCoordinates(urlString: String, completion: @escaping ([CoordinatesElement]?) -> Void)
    func fetchWeather(urlString: String, completion: @escaping (Weather?) -> Void)
}

class DataFetcherService: DataFetcherServiceProtocol {
    
    var fetcherCoordinates: DataFetcherCoordinates
    var fetcherWeather: DataFetcherWeather
    
    init(fetcherCoordinates: DataFetcherCoordinates = NetworkDataFetcherCoordinates(),
         fetcherWeather: DataFetcherWeather = NetworkDataFetcherWeather()) {
        self.fetcherCoordinates = fetcherCoordinates
        self.fetcherWeather = fetcherWeather
    }
    
    func fetchCoordinates(urlString: String, completion: @escaping ([CoordinatesElement]?) -> Void) {
        fetcherCoordinates.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
    func fetchWeather(urlString: String, completion: @escaping (Weather?) -> Void) {
        fetcherWeather.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
}
