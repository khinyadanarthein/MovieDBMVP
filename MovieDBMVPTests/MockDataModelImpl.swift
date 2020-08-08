//
//  MockDataModelImpl.swift
//  MovieDBMVPTests
//
//  Created by Khin Yadanar Thein on 08/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
import Foundation
@testable import RealmSwift
@testable import RxRealm
@testable import RxSwift
@testable import MovieDBMVP

class MockDataModelImpl: XCTestCase {
    
    static let shared:MockDataModelImpl = MockDataModelImpl()
    let mockApi:Api = MockApiClient.shared
    let mockdb :Dao = MockRealmHelper.shared
    let bag:DisposeBag = DisposeBag()
}
extension MockDataModelImpl : DataModel {
    
    func getMovieSlidesFromAPI(page: Int, apiKey: String, sortkey: String) {
        _ = mockApi.getSlideVideos(page: page, apiKey: apiKey, sortkey: sortkey)
            .flatMap{ response -> Observable<Bool> in
                XCTAssertEqual(response.results.count, 20)
                XCTAssertEqual(response.totalResults, 10000)
                return self.mockdb.saveSlideVideos(data: response.results)
                
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    
    }
    
    func getMovieSlides() -> Observable<[MainVideoVO]> {
        let data = mockdb.getMovieSlides()
        XCTAssertNotNil(data)
        return data
    }
    
    func getMovieVideo(id: Int, success: @escaping (MovieVideoDetailVO) -> Void, fail: @escaping (String) -> Void) {
        return mockApi.getMovieVideo(id: id, success: { (data) in
            XCTAssertEqual(data.id, "5ec686d50fb17f001d7aa5e4")
            XCTAssertEqual(data.key, "aK-X2d0lJ_s")
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getBestPopularMoviesFromAPI(page: Int, apiKey: String) {
        _ = mockApi.getPopularMovies(page: page, apiKey: apiKey)
            .flatMap{ response -> Observable<Bool> in
                XCTAssertEqual(response.results.count, 20)
                XCTAssertEqual(response.totalResults, 10000)
                return self.mockdb.saveBestPopularMovies(data: response.results)
                
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
        
    }
    
    func getBestPopularMovies() -> Observable<[BestMovieVO]> {
        let data = mockdb.getPopularMovies()
        XCTAssertNotNil(data)
        return data
    }
    
    func getGenreListFromAPI(apiKey: String) {
        
    }
    
    func getGenresList() -> Observable<[GenreVO]> {
        let data = mockdb.getGenres()
        XCTAssertNotNil(data)
        return data
    }
    
    func getGenreMovieListFromAPI(page: Int, genreId: Int, apiKey: String) {
        
    }
    
    func getGenresMovieList() -> Observable<[GenreMovieVO]> {
        let data = mockdb.getGenreMovies()
        XCTAssertNotNil(data)
        return data
    }
    
    func getShowcaseListFromAPI(page: Int, date: String, apiKey: String) {
        
    }
    
    func getShowcaseList() -> Observable<[MovieShowCaseVO]> {
        let data = mockdb.getShowcaseMovies()
        XCTAssertNotNil(data)
        return data
    }
    
    func getActorListFromAPI(page: Int, apiKey: String) {
        
    }
    
    func getActorList() -> Observable<[MovieCastDetailVO]> {
        let data = mockdb.getPopularActors()
        XCTAssertNotNil(data)
        return data
    }
    
    func getMovieDetail(id: Int, apiKey: String, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        
    }
    
    func getMovieCreditsFromAPI(movieId: Int, apiKey: String) {
        
    }
    
    func getMovieCredits(id: Int, apiKey: String, success: @escaping (MovieCreditResponse) -> Void, fail: @escaping (String) -> Void) {
        
    }
    
    func getMovieCasts() -> Observable<[MovieCastVO]> {
        let data = mockdb.getMovieCasts()
        XCTAssertNotNil(data)
        return data
    }
    
    func getMovieCrews() -> Observable<[MovieCrewVO]> {
        let data = mockdb.getMovieCrews()
        XCTAssertNotNil(data)
        return data
    }
    
    
    
}
