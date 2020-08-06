//
//  MovieVideoDetailVO.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift
// MARK: - MovieVideoDetailVO

class MovieVideoDetailVO: Object, Codable {
    @objc dynamic var id: String? = ""
    @objc dynamic var iso639_1: String? = ""
    @objc dynamic var iso3166_1: String? = ""
    @objc dynamic var key: String? = ""
    @objc dynamic var name: String? = ""
    @objc dynamic var site: String? = ""
    @objc dynamic var movieSize: Int = 0
    @objc dynamic var type: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case movieSize = "size"
        case key, name, site, type
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
