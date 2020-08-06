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
}
