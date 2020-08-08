//
//  MockApiClient.swift
//  MovieDBMVPTests
//
//  Created by Khin Yadanar Thein on 08/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
@testable import MovieDBMVP
@testable import RxSwift

class MockApiClient: XCTestCase {
    
    static let shared:MockApiClient = MockApiClient()
       
}

extension MockApiClient : Api {
    
    func getSlideVideos(page: Int, apiKey: String, sortkey: String) -> Observable<MainVideoResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "page-side-movies")
                
                let data:MainVideoResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getPopularMovies(page: Int, apiKey: String) -> Observable<BestMovieResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "trending_list_result")
                
                let data:BestMovieResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getGenreTypes(apiKey: String) -> Observable<GenreResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "genre-list")
                
                let data:GenreResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getMoviesByGenre(page: Int, genreId: Int, apiKey: String) -> Observable<GenreMovieResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "movies-by-genre-action")
                
                let data:GenreMovieResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getShowCaseVideos(page: Int, date: String, apiKey: String) -> Observable<MovieShowCaseResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "showcase-movies")
                
                let data:MovieShowCaseResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getMovieVideo(id: Int, success: @escaping (MovieVideoDetailVO) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "movie_video_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(MovieVideoDetailVO.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func getPopularActors(page: Int, apiKey: String) -> Observable<MovieCastDetailResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "popular-actors")
                
                let data:MovieCastDetailResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
  
    func getMovieDetail(id: Int, apiKey: String, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "movie_detail_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(MovieDetailVO.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func getMovieCredits(movieId: Int, apiKey: String) -> Observable<MovieCreditResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "movie-credits")
                
                let data:MovieCreditResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getMovieCreditsAll(id: Int, apiKey: String, success: @escaping (MovieCreditResponse) -> Void, fail: @escaping (String) -> Void) {
        
    }
    
  
}
