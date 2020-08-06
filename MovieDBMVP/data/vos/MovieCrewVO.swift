//
//  MovieCrewVO.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

// MARK: - Crew
class MovieCrewVO: Codable {
    let creditID: String
    let department: String
    let gender, id: Int
    let job, name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }

    init(creditID: String, department: String, gender: Int, id: Int, job: String, name: String, profilePath: String?) {
        self.creditID = creditID
        self.department = department
        self.gender = gender
        self.id = id
        self.job = job
        self.name = name
        self.profilePath = profilePath
    }
    
}
