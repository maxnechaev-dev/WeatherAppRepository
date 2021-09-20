//
//  NetworkServiceGetWeather.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import Foundation

protocol NetworkingWeather {
    func request (urlString: String, completion: @escaping (Result <Data, Error>) -> Void)
    }

class NetworkServiceWeather: NetworkingWeather {

    func request (urlString: String, completion: @escaping (Result <Data, Error>) -> Void) {

        guard let url = URL(string: urlString) else { return print("Can't get URL") }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("3fe8a75b-f3be-4632-a87b-925522a8a70d", forHTTPHeaderField: "X-Yandex-API-Key")
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    
    private func createDataTask (from request: URLRequest, completion: @escaping (Result <Data, Error>) -> Void) -> URLSessionDataTask {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }
    }
    
}
