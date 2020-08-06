//
//  MovieVideoResponse.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 05/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

// MARK: - MovieVideoResponse
class MovieVideoResponse: Codable {
    let id: Int?
    let results : [MovieVideoDetailVO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case results
    }

}
