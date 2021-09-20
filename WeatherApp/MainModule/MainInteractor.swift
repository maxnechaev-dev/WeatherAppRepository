//
//  MainInteractor.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import UIKit

protocol MainInteractorOutputs: AnyObject {
    func getWeather(lat: String, lon: String)
    func getWeatherForOneCity(lat: String, lon: String)
    func reloadData(weather: Weather)
    func pushViewControllerToSelectedCity(element: Weather)
    func incorrectCityAlert()
}

protocol MainInteractorProtocol {
    func fetchCoordinates(with url: String)
    func fetchWeather(with url: String)
    func fetchCoordinatesForOneCity(with url: String)
    func fetchWeatherForOneCity(with url: String)
}

class MainInteractor: MainInteractorProtocol {
    
    let url = "https://api.weather.yandex.ru/v2/forecast?lat=55.75396&lon=37.620393&extra=true"
    
    //MARK: - Dependencies
    
    var dataFetcher: DataFetcherServiceProtocol
    weak var presenter: MainInteractorOutputs?

    //MARK: - Init

    init(dataFetcher: DataFetcherServiceProtocol) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchCoordinates(with url: String){
        dataFetcher.fetchCoordinates(urlString: url) { [weak self] coords in
            guard let coords = coords else { return print("Can't take coords") }
            guard let element = coords.first else { return print("Can't take first coords element") }
            guard let self = self else { return }
            let lat = element.lat
            let lon = element.lon
            
            self.presenter?.getWeather(lat: lat, lon: lon)
        }
    }
    
    func fetchWeather(with url: String) {
        dataFetcher.fetchWeather(urlString: url) { [weak self] weather in
            guard let self = self else { return }
            guard let weather = weather else { return print("Can't get weather") }
            self.presenter?.reloadData(weather: weather)
        }
    }
    
    func fetchCoordinatesForOneCity(with url: String){
        dataFetcher.fetchCoordinates(urlString: url) { [weak self] coords in
            guard let coords = coords else { return print("Can't take coords") }
            guard let self = self else { return }
            guard let element = coords.first else {
                self.presenter?.incorrectCityAlert()
                return print("Can't take first coords element") }
            let lat = element.lat
            let lon = element.lon
            
            self.presenter?.getWeatherForOneCity(lat: lat, lon: lon)
        }
    }
    
    func fetchWeatherForOneCity(with url: String) {
        dataFetcher.fetchWeather(urlString: url) { [weak self] weather in
            guard let self = self else { return }
            guard let weather = weather else { return print("Can't get weather") }
            self.presenter?.pushViewControllerToSelectedCity(element: weather)
        }
    }
}
