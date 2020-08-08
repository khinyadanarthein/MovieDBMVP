//
//  CustomClass.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 03/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

class CommonUtils{
    static let shared : CommonUtils = CommonUtils()
    
    private init() {}
    
    func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    func getCurrentDate() -> String{
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        let dateString = formatter.string(from:now)
        return dateString
    }
    
}
