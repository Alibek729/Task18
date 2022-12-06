//
//  NetworkManger.swift
//  Test Task15
//
//  Created by Alibek Kozhambekov on 29.11.2022.
//

import Foundation

struct NetworkManager {
    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept": "application/json"]
        request.httpBody = nil
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error {
                    completion(.failure(error))
                    return
                }
                guard let safeData = data else { return }
                completion(.success(safeData))
            }
        }.resume()
    }
}
