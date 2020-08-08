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
class MovieCastDetailVO: Object, Codable {
    
    @objc dynamic var popularity: Double
    @objc dynamic var knownForDepartment: String? = ""
    @objc dynamic var name: String? = ""
    @objc dynamic var id: Int
    @objc dynamic var profilePath: String? = ""
    @objc dynamic var adult: Bool
    @objc dynamic var gender: Int
    //var knownFor = List<KnownFor>()

    enum CodingKeys: String, CodingKey {
        case popularity
        case knownForDepartment = "known_for_department"
        case name, id
        case profilePath = "profile_path"
        case adult
        //case knownFor = "known_for"
        case gender
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - KnownFor
class KnownFor: Object, Codable {
    @objc dynamic var originalName: String?
    //var genreIDS = List<Int>()
    @objc dynamic var mediaType: String?
    @objc dynamic var name: String?
    var originCountry: List<String>?
    @objc dynamic var voteCount: Int
    @objc dynamic var firstAirDate: String?
    @objc dynamic var backdropPath: String?
    @objc dynamic var originalLanguage: String? = ""
    @objc dynamic var id: Int
    @objc dynamic var voteAverage: Double
    @objc dynamic var overview: String
    @objc dynamic var posterPath: String?
    @objc dynamic var video: Bool
    @objc dynamic var title : String?
    @objc dynamic var releaseDate : String?
    @objc dynamic var originalTitle: String?
    @objc dynamic var adult: Bool

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        //case genreIDS = "genre_ids"
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

    override static func primaryKey() -> String? {
        return "id"
    }
}
