//
//  MovieCastVO.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Cast
class MovieCastVO: Object, Codable {
    @objc dynamic var castID: Int
    @objc dynamic var character : String? = ""
    @objc dynamic var creditID: String? = ""
    @objc dynamic var gender : Int
    @objc dynamic var id: Int
    @objc dynamic var name: String? = ""
    @objc dynamic var order: Int
    @objc dynamic var profilePath: String? = ""

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
