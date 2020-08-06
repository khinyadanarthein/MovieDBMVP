//
//  Extensions.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 31/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

extension Data{
    
    func seralizeData<T:Codable>() -> T?{
        
        do{
            
            let data = try JSONDecoder().decode(T.self, from: self)
            return data
            
        }catch let ex {
            
            debugPrint(ex.localizedDescription)
            return nil
        }
        
    }
}
