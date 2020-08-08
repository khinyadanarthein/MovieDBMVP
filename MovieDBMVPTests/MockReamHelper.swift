//
//  MockReamHelper.swift
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

class MockRealmHelper: XCTestCase {
     
    static let shared:MockRealmHelper = MockRealmHelper()
    
    let realm = try! Realm()
    
    //override private init(){}
  
}

extension MockRealmHelper : Dao {
    
    func saveSlideVideos(data: [MainVideoVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getMovieSlides() -> Observable<[MainVideoVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "page-side-movies")
                XCTAssertNotNil(response)
                
                let data:MainVideoResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func saveBestPopularMovies(data: [BestMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getPopularMovies() -> Observable<[BestMovieVO]> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "trending_list_result")
                XCTAssertNotNil(response)
                
                let data:BestMovieResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func saveGenres(data: [GenreVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 19)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getGenres() -> Observable<[GenreVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "genre-list")
                XCTAssertNotNil(response)
                
                let data:GenreResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.genres)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func saveGenreMovies(data: [GenreMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getGenreMovies() -> Observable<[GenreMovieVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "movies-by-genre-action")
                XCTAssertNotNil(response)
                
                let data:GenreMovieResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func deleteGenreMovies() {
        do{
        try self.realm.write {
            realm.delete(realm.objects(GenreMovieVO.self))
            }
        }catch let ex{
            debugPrint(ex.localizedDescription)
        }
        
    }
    
    func saveActors(data: [MovieCastDetailVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getPopularActors() -> Observable<[MovieCastDetailVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "popular-actors")
                XCTAssertNotNil(response)
                
                let data:MovieCastDetailResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func saveShowcaseMovie(data: [MovieShowCaseVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getShowcaseMovies() -> Observable<[MovieShowCaseVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "showcase-movies")
                XCTAssertNotNil(response)
                
                let data:MovieShowCaseResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getMovieCasts() -> Observable<[MovieCastVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "movie-credits")
                XCTAssertNotNil(response)
                
                let data:MovieCreditResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.cast)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getMovieCrews() -> Observable<[MovieCrewVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "movie-credits")
                XCTAssertNotNil(response)
                
                let data:MovieCreditResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.crew)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func saveMovieCredits(cast: [MovieCastVO], crew: [MovieCrewVO]) -> Observable<Bool> {
        XCTAssertNotNil(cast)
        XCTAssertNotNil(crew)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(cast,update: .modified)
                    self.realm.add(crew,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func deleteOldMovieCredits() {
        <#code#>
    }
    
    func saveFavoritedCast(data: MovieCastVO) -> Observable<Bool> {
        <#code#>
    }
    
    func saveFavoritedMovie(data: MovieDetailVO) -> Observable<Bool> {
        <#code#>
    }
    
    
}
