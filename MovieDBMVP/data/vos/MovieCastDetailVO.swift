//
//  ActorVO.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - MovieActorVO
class MovieCastDetailVO: Codable {
    
 @objc dynamic var popularity: Double = 0.0
    let knownForDepartment: KnownForDepartment
    let name: String
    let id: Int
    let profilePath: String
    let adult: Bool
    let knownFor: [KnownFor]
    let gender: Int

    enum CodingKeys: String, CodingKey {
        case popularity
        case knownForDepartment = "known_for_department"
        case name, id
        case profilePath = "profile_path"
        case adult
        case knownFor = "known_for"
        case gender
    }

    init(popularity: Double, knownForDepartment: KnownForDepartment, name: String, id: Int, profilePath: String, adult: Bool, knownFor: [KnownFor], gender: Int) {
        self.popularity = popularity
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.id = id
        self.profilePath = profilePath
        self.adult = adult
        self.knownFor = knownFor
        self.gender = gender
    }
}

// MARK: - KnownFor
class KnownFor: Codable {
    let originalName: String?
    let genreIDS: [Int]
    let mediaType: MediaType
    let name: String?
    let originCountry: [String]?
    let voteCount: Int
    let firstAirDate: String?
    let backdropPath: String?
    let originalLanguage: OriginalLanguage
    let id: Int
    let voteAverage: Double
    let overview: String
    let posterPath: String?
    let video: Bool?
    let title, releaseDate, originalTitle: String?
    let adult: Bool?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case mediaType = "media_type"
        case name
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
        case video, title
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case adult
    }

}
