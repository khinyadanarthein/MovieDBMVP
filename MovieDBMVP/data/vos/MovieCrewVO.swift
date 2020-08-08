//
//  MovieCrewVO.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Crew
class MovieCrewVO: Object,Codable {
    @objc dynamic var creditID: String? = ""
    @objc dynamic var department: String? = ""
    @objc dynamic var gender, id: Int
    @objc dynamic var job: String? = ""
    @objc dynamic var name: String? = ""
    @objc dynamic var profilePath: String? = ""

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
