//
//  NetworkDataFetcher.swift
//  Test Task15
//
//  Created by Alibek Kozhambekov on 05.12.2022.
//

import Foundation
import UIKit

class NetworkDataFetcher {
    let networkManager = NetworkManager()
    
    func fetchMovies(urlString: String, response: @escaping (MovieResponse?) -> ()) {
        networkManager.request(urlString: urlString) { result in
            switch result {
                
            case .success(let safeData):
                do {
                    let movies = try JSONDecoder().decode(MovieResponse.self, from: safeData)
                    response(movies)
                } catch let jsonError {
                    print("Error to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error receiving equested Data", error.localizedDescription)
                response(nil)
            }
        }
    }
}
