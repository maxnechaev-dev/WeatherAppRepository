//
//  NetworkDataFetcherWeather.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import Foundation

protocol DataFetcherWeather {
    func fetchGenericJSONData <T: Decodable> (urlString: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcherWeather: DataFetcherWeather {

    var networking: NetworkingWeather
    
    init(networking: NetworkingWeather = NetworkServiceWeather()) {
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
