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

    
    //    func getShowCaseVideos(page : Int, date : String, apiKey : String) -> Observable<MovieShowCaseResponse>
//    func getPopularActors(page : Int, apiKey : String) -> Observable<MovieCastDetailResponse>
    
    //play video
    //func getVideoLink(movieId : Int, apiKey : String) -> Observable<MovieVideoDetailVO>
    
    func getMovieVideo(id : Int, success: @escaping (MovieVideoDetailVO) -> Void, fail: @escaping (String) -> Void)
    
    func getGenre(id : Int, success: @escaping (GenreResponse) -> Void, fail: @escaping (String) -> Void)
    
}
