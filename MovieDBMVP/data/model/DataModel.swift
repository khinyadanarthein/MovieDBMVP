//
//  DataModel.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

protocol DataModel {
    func getMovieSlidesFromAPI(page: Int, apiKey: String, sortkey : String)
    func getMovieSlides() -> Observable<[MainVideoVO]>
    func getMovieVideo(id : Int, success: @escaping (MovieVideoDetailVO) -> Void, fail: @escaping (String) -> Void)
    func getMovieSlidesDetail() -> [MovieVideoDetailVO]
    
    func getBestPopularMoviesFromAPI(page: Int, apiKey: String)
    func getBestPopularMovies() -> Observable<[BestMovieVO]>
    
    func getGenreListFromAPI(apiKey: String)
    func getGenresList() -> Observable<[GenreVO]>
    
    func getGenre() 
}
