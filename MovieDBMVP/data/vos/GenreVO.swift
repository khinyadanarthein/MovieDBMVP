//
//  GenreVO.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - GenreVO
class GenreResponse: Codable {
    
    let genres = [GenreVO]()
    
    enum CodingKeys: String, CodingKey {
        case genres = "genres"
       
    }

    
}

// MARK: - Genre
class GenreVO: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
