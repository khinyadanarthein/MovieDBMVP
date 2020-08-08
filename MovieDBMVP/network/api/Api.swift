//
//  Api.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

protocol Api {
    func getSlideVideos(page : Int, apiKey : String, sortkey : String) -> Observable<MainVideoResponse>
    
    func getPopularMovies(page : Int, apiKey : String) -> Observable<BestMovieResponse>
    
    func getGenreTypes(apiKey : String) -> Observable<GenreResponse>
    
    func getMoviesByGenre(page : Int, genreId : Int, apiKey : String) -> Observable<GenreMovieResponse>

    func getShowCaseVideos(page : Int, date : String, apiKey : String) -> Observable<MovieShowCaseResponse>
    
    //play video
    func getMovieVideo(id : Int, success: @escaping (MovieVideoDetailVO) -> Void, fail: @escaping (String) -> Void)
   
    //MARK: -Actor List
    func getPopularActors(page : Int, apiKey : String) -> Observable<MovieCastDetailResponse>
    
    //MARK: -Detail
    func getMovieDetail(id : Int, apiKey : String, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void)
    func getMovieCredits(movieId : Int, apiKey : String) -> Observable<MovieCreditResponse>
    func getMovieCreditsAll(id : Int, apiKey : String, success: @escaping (MovieCreditResponse) -> Void, fail: @escaping (String) -> Void)
    
}
