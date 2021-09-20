//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import UIKit

class MainPresenter {
    
    var cellID = "MainCustomCell"
    var cities: [Weather]? = []
        
    //MARK: - Dependencies
    
    weak var viewController: MainViewController?
    private var router: MainRouterProtocol
    private var interactor: MainInteractorProtocol
    
    //MARK: - Init

    init(router: MainRouterProtocol,
         interactor: MainInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func fetchArrayOfCities(array: [String]) {
        for city in array {
            let urlCity = "https://nominatim.openstreetmap.org/search?city=\(city)&format=json"
            interactor.fetchCoordinates(with: urlCity)
        }
    }
    
    func fetchOneCity(cityName: String) {
        let urlCity = "https://nominatim.openstreetmap.org/search?city=\(cityName)&format=json"
        interactor.fetchCoordinatesForOneCity(with: urlCity)
    }
}

//MARK: - Realisation of MainViewOutput

extension MainPresenter: MainViewOutput {

    func cellForItemAt(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MainCustomCell
        
        guard let cities = cities else { return cell }
        let cityWeather = cities[indexPath.row]
        cell.imageView.image = UIImage(named: cityWeather.fact.icon)
        cell.tempLabel.text = "\(cityWeather.fact.temp)°C"
        cell.conditionLabel.text = cityWeather.fact.condition.capitalized
                
        let cityName = viewController?.defaultCities[indexPath.row]
        cell.cityNameLabel.text = cityName

        return cell
    }
    
    func sizeForItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 1
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 4)
    }
    
    func userSelect(element: Weather, navigationController: UINavigationController) {
        viewController?.searchBar.resignFirstResponder()
        router.pushViewController(element: element, navigation: navigationController)
    }
    
    func searchBarClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return print("Don't have text in search bar") }
        let correctName = searchText.replacingOccurrences(of: " ", with: "-")
        fetchOneCity(cityName: correctName)
        searchBar.resignFirstResponder()
    }
    
    func pushViewControllerToSelectedCity(element: Weather) {
        guard let navigation = viewController?.navigationController else { return print("ViewController don't have navigation controller") }
        router.pushViewControllerToOneCity(element: element, navigation: navigation)
    }
    
    func incorrectCityAlert() {
        viewController?.setupAlertController()
    }
}

//MARK: - Realisation of MainInteractorOutputs

extension MainPresenter: MainInteractorOutputs {
    func getWeather(lat: String, lon: String) {
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&extra=true"
        interactor.fetchWeather(with: url)
    }
    
    func getWeatherForOneCity(lat: String, lon: String) {
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&extra=true"
        interactor.fetchWeatherForOneCity(with: url)
    }
    

    func reloadData(weather: Weather) {
        addInArray(object: weather)
        if cities?.count == 10 {
            self.viewController?.cartoonImageView.isHidden = true
            self.viewController?.greetingsLabel.isHidden = true
            self.viewController?.collectionView.isHidden = false
            self.viewController?.collectionView.reloadData()
        }
    }
    
    //Append weather objects in array to parse them in CollectionView
    func addInArray(object: Weather) {
        cities?.append(object)
    }
}
