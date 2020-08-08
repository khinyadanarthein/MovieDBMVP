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
    
    func getGenreMovieListFromAPI(page : Int, genreId: Int, apiKey: String)
    func getGenresMovieList() -> Observable<[GenreMovieVO]>
    func getGenre()
    
    func getShowcaseListFromAPI(page : Int, date: String, apiKey: String)
    func getShowcaseList() -> Observable<[MovieShowCaseVO]>
    
    func getActorListFromAPI(page: Int, apiKey: String)
    func getActorList() -> Observable<[MovieCastDetailVO]>
    
    func getMovieDetail(id : Int, apiKey: String, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void)
    func getMovieCreditsFromAPI(movieId: Int, apiKey: String)
    
    func getMovieCredits(id : Int, apiKey: String, success: @escaping (MovieCreditResponse) -> Void, fail: @escaping (String) -> Void)
    func getMovieCasts() -> Observable<[MovieCastVO]>
    func getMovieCrews() -> Observable<[MovieCrewVO]>
    
}
