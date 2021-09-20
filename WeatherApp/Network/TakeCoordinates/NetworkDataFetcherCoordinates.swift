//
//  NetworkDataFetcherCoordinates.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import Foundation

//MARK: - Протокол, который декодирует полученные данные

protocol DataFetcherCoordinates {
    func fetchGenericJSONData <T: Decodable> (urlString: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcherCoordinates: DataFetcherCoordinates {

    var networking: NetworkingCoordinates
    
    init(networking: NetworkingCoordinates = NetworkServiceCoordinates()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData <T: Decodable> (urlString: String, response: @escaping (T?) -> Void) {
        
        networking.request(urlString: urlString) { (result) in
            switch result {
            
            case .success(let data):
                
                do {
                    if let data = data as? T {
                        response(data)
                        return
                    }
                    let elements = try JSONDecoder().decode(T.self, from: data)
                    response(elements)
                    
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
                
            case .failure(let error):
                print("Error received requesting data:", error.localizedDescription)
                response (nil)
            }
        }
    }
}
