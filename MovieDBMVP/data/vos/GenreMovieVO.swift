//
//  GenreMovieVO.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Result
class GenreMovieVO: Object, Codable {
    
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var posterPath: String? = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String? = ""
    @objc dynamic var originalLanguage: String? = ""
    @objc dynamic var originalTitle: String? = ""
    var genreIDS = List<Int>()
    @objc dynamic var title: String? = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var overview : String? = ""
    @objc dynamic var releaseDate: String? = ""

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

