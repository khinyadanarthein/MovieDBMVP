//
//  DetailPresenter.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 07/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol DetailPresenter {
    
    var movieDetail:MovieDetailVO {get set}
    var movieCastList : [MovieCastVO] {get set}
    var movieCrewList : [MovieCrewVO] {get set}
    func onUIReady(movieId : Int)
    func getMovieVideo(movieId : Int)
    func rateMovie(movieId : Int)
    func addFavMovie(movieId : Int)
    func attachView(view:DetailView)
    func deattachView()
}
