//
//  GenreMovieResponse.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

// MARK: - GenreMovieResponse
struct GenreMovieResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [GenreMovieVO]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
