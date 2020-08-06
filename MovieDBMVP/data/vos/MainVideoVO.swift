//
//  MainVideoVO.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mainVideoVO = try? newJSONDecoder().decode(MainVideoVO.self, from: jsonData)

import Foundation
import RealmSwift

// MARK: - Result
class MainVideoVO: Object, Codable {
    
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
    @objc dynamic var key: String? = ""

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
