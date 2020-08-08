//
//  CommonDelegates.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 02/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
protocol GenreTileDelegate {
    func onTapTitle(id : Int)
}

protocol VideoPlayDelegate {
    func onTapPlayButton(movieId : Int, index : Int, section : Int)
}

protocol MovieDetailDelegate {
    func onTapMovie(movieId : Int)
}
