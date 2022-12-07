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
    var images = [UIImage]()
    
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
    
    func loadImage(urlString: String) -> UIImage? {
        guard
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url)
        else {
            print("Ошибка, не удалось загрузить изображение")
            return nil
        }
        
        return UIImage(data: data)
    }
    
    func getImageURL(urlString: String, completion: @escaping (String?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let someDictionaryFromJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            let imageUrl = someDictionaryFromJSON?["message"] as? String
            completion(imageUrl, error)
        }
        task.resume()
    }
    
    func convertImage(urlString: String) -> UIImage {
        var image: UIImage?
        
        let url = URL(string: urlString)
                let sessionTask = URLSession.shared
                let request = URLRequest(url: url!)
                let task = sessionTask.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
                    DispatchQueue.main.async {
                        guard let safeData = data else {return}
                        if (error == nil) {
                            image = UIImage(data: safeData)
                        }
                    }
                })
                task.resume()
        return image ?? UIImage(systemName: "nosign.app.fill")!
    }
}
