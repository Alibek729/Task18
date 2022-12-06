//
//  MovieResponse.swift
//  Test Task15
//
//  Created by Alibek Kozhambekov on 29.11.2022.
//

import UIKit

struct MovieResponse: Decodable {
    var searchType: String
    var expression: String
    var results: [Results]
}

struct Results: Decodable {
    var image: String
    var title: String
    var description: String
}

