//
//  DataModelImpl.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

class DataModelImpl: DataModel {
    
    static let shared:DataModelImpl = DataModelImpl()
    let api:Api = ApiClient.shared
    let db :Dao = RealmHelper.shared
    
    private init(){}
    
    func getMovieSlidesFromAPI(page: Int, apiKey: String, sortkey: String) {
        _ = api.getSlideVideos(page: page, apiKey: apiKey, sortkey: sortkey)
            .flatMap{self.db.saveSlideVideos(data: $0.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getMovieSlides() -> Observable<[MainVideoVO]> {
        db.getMovieSlides()
    }
    
    func getMovieVideo(id: Int, success: @escaping (MovieVideoDetailVO) -> Void, fail: @escaping (String) -> Void) {
        return api.getMovieVideo(id: id, success: { (data) in
            _ = self.db.saveVideoDetail(data: data)
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getMovieSlidesDetail() -> [MovieVideoDetailVO] {
        db.getMovieSlidesDetail()
    }
            
    func getBestPopularMoviesFromAPI(page: Int, apiKey: String) {
        _ = api.getPopularMovies(page: page, apiKey: apiKey)
            .flatMap{self.db.saveBestPopularMovies(data: $0.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getBestPopularMovies() -> Observable<[BestMovieVO]> {
        db.getPopularMovies()
    }
    
    //MARK: -Genre
    func getGenreListFromAPI(apiKey: String) {
        _ = api.getGenreTypes(apiKey: apiKey)
            .flatMap{self.db.saveGenres(data: $0.genres)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getGenresList() -> Observable<[GenreVO]> {
        db.getGenres()
    }
    
    func getGenre() {
        api.getGenre(id: 12, success: { (data) in
            print("Genre \(data.genres.count)")
            
        }) { (error) in
            print(error)
        }
    }
    
    func getGenresMovieList() -> Observable<[GenreMovieVO]> {
        db.getGenreMovies()
    }
    
    func getGenreMovieListFromAPI(page: Int, genreId: Int, apiKey: String) {
        db.deleteGenreMovies()
        _ = api.getMoviesByGenre(page: page, genreId: genreId, apiKey: apiKey)
        .flatMap{self.db.saveGenreMovies(data: $0.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    //MARK: -Showcase
    func getShowcaseListFromAPI(page: Int, date: String, apiKey: String) {
        _ = api.getShowCaseVideos(page: page, date: date, apiKey: apiKey)
        .flatMap{self.db.saveShowcaseMovie(data: $0.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getShowcaseList() -> Observable<[MovieShowCaseVO]> {
        db.getShowcaseMovies()
    }
    
    
    //MARK: -Actor
    func getActorListFromAPI(page: Int, apiKey: String) {
        _ = api.getPopularActors(page: page, apiKey: apiKey)
            .flatMap{self.db.saveActors(data: $0.results)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getActorList() -> Observable<[MovieCastDetailVO]> {
        db.getPopularActors()
    }
    //MARK: -Detail
    
    func getMovieDetail(id: Int, apiKey: String, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        
        return api.getMovieDetail(id: id, apiKey: apiKey, success: { (data) in
            _ = self.db.saveMovieDetail(data: data)
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    func getMovieCreditsFromAPI(movieId: Int, apiKey: String) {
        db.deleteOldMovieCredits()
         _ = api.getMovieCredits(movieId: movieId, apiKey: apiKey)
            .flatMap{self.db.saveMovieCredits(cast: $0.cast, crew: $0.crew)}
                   .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    func getMovieCrews() -> Observable<[MovieCrewVO]> {
        db.getMovieCrews()
    }
    
    func getMovieCasts() -> Observable<[MovieCastVO]> {
        db.getMovieCasts()
    }
    
    func getMovieCredits(id: Int, apiKey: String, success: @escaping (MovieCreditResponse) -> Void, fail: @escaping (String) -> Void) {
        
        return api.getMovieCreditsAll(id: id, apiKey: apiKey, success: { (data) in
            
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
}
