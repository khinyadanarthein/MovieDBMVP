//
//  MainPresenter.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
protocol MainPresenter {

    var movieSlides:[MainVideoVO]  {get set}
    var slidemMovieVideo : [Int:MovieVideoDetailVO] {get set}
    var showcaseVideo : [Int:MovieVideoDetailVO] {get set}
    var bestMovieList : [BestMovieVO] {get set}
    var genreList : [GenreVO] {get set}
    var genreMovieList : [GenreMovieVO] {get set}
    var actorList : [MovieCastDetailVO] {get set}
    var showcaseList : [MovieShowCaseVO] {get set}
    var selectedGenre : Int {get set}
    var updatedSlideIndex : Int {get set}
    
    func onUIReady()
    func attachView(view : MainPageView)
    func deattachView()
    func getMovieVideo(movieId : Int, index: Int, section : Int)
    func getMovieByGenreId (genreId : Int)
    func onTapMovie(movieId : Int)
}
