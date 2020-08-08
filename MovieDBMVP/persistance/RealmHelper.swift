//
//  RealmHelper.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

class RealmHelper: Dao {
     
    static let shared:RealmHelper = RealmHelper()
    
    let realm = try! Realm()
    
    private init(){}
    
    //MARK: - Slide video
    func saveSlideVideos(data: [MainVideoVO]) -> Observable<Bool> {
        
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
        
        let allMovies = realm.objects(MainVideoVO.self)
        return Observable.array(from: allMovies)
    }
    
    func saveVideoDetail(data: MovieVideoDetailVO) -> Observable<Bool> {
        
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
    
    func getMovieSlidesDetail() -> [MovieVideoDetailVO] {
        
        let allMovies = realm.objects(MovieVideoDetailVO.self)
        return Array(allMovies)
    }
    
    //MARK: - Best Popular
    func saveBestPopularMovies(data: [BestMovieVO]) -> Observable<Bool> {
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
        
        let allMovies = realm.objects(BestMovieVO.self)
        return Observable.array(from: allMovies)
        
    }
    
    //MARK: - Genre
    func saveGenres(data: [GenreVO]) -> Observable<Bool> {
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
        let genres = realm.objects(GenreVO.self)
        return Observable.array(from: genres)
    }
    
    func saveGenreMovies(data: [GenreMovieVO]) -> Observable<Bool> {
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
        let allMovies = realm.objects(GenreMovieVO.self)
        return Observable.array(from: allMovies)
        
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
    
    //MARK: - Showcase
    func saveShowcaseMovie(data: [MovieShowCaseVO]) -> Observable<Bool> {
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
       let genres = realm.objects(MovieShowCaseVO.self)
        return Observable.array(from: genres)
    }
    
    //MARK: - Actors
    func saveActors(data: [MovieCastDetailVO]) -> Observable<Bool> {
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
       let genres = realm.objects(MovieCastDetailVO.self)
        return Observable.array(from: genres)
    }
    //MARK: - Detail
    func saveMovieDetail(data: MovieDetailVO) -> Observable<Bool> {
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
    
    func getMovieDetailById(id: Int) -> MovieDetailVO? {
        let movie = self.realm.objects(MovieDetailVO.self).filter("id = %@",id).first!
        return movie
    }
    
    func getMovieCasts() -> Observable<[MovieCastVO]> {
        let casts = realm.objects(MovieCastVO.self)
        return Observable.array(from: casts)
    }
    
    func saveMovieCredits(cast: [MovieCastVO], crew:[MovieCrewVO]) -> Observable<Bool> {
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
    
    func getMovieCrews() -> Observable<[MovieCrewVO]> {
        let casts = realm.objects(MovieCrewVO.self)
        return Observable.array(from: casts)
    }
    
    func deleteOldMovieCasts() {
        do{
        try self.realm.write {
            realm.delete(realm.objects(MovieCastVO.self))
            }
        }catch let ex{
            debugPrint(ex.localizedDescription)
        }
    }
    
    func deleteOldMovieCredits() {
        do{
        try self.realm.write {
            realm.delete(realm.objects(MovieCrewVO.self))
            realm.delete(realm.objects(MovieCastVO.self))
            }
        }catch let ex{
            debugPrint(ex.localizedDescription)
        }
    }
    
    func saveFavoritedCast(data: MovieCastVO) -> Observable<Bool> {
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
    
    func saveFavoritedMovie(data: MovieDetailVO) -> Observable<Bool> {
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
    
}
