//
//  MovieCreditResponse.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

// MARK: - MovieCreditResponse
class MovieCreditResponse: Codable {
    let id: Int
    let cast: [MovieCastVO]
    let crew: [MovieCrewVO]

    init(id: Int, cast: [MovieCastVO], crew: [MovieCrewVO]) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
}
