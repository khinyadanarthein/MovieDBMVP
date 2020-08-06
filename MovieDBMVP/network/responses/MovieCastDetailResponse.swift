//
//  MovieActorResponse.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
// MARK: - ActorResponse
class MovieCastDetailResponse: Codable {
    let page, totalResults, totalPages: Int
    let results: [MovieCastDetailVO]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }

    init(page: Int, totalResults: Int, totalPages: Int, results: [MovieCastDetailVO]) {
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}
