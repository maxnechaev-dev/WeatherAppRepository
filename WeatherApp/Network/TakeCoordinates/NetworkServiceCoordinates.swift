//
//  NetworkServiceCoordinates.swift
//  WeatherApp
//
//  Created by Max Nechaev on 09.09.2021.
//

import Foundation

protocol NetworkingCoordinates {
    func request (urlString: String, completion: @escaping (Result <Data, Error>) -> Void)
    }

class NetworkServiceCoordinates: NetworkingCoordinates {
    
    func request (urlString: String, completion: @escaping (Result <Data, Error>) -> Void) {

        guard let url = URL(string: urlString) else {
            return print("Can't get URL") }

        let request = URLRequest(url: url)
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
