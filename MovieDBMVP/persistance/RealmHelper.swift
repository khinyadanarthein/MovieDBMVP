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
}
