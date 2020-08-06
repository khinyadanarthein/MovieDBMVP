//
//  MainPresenterImpl.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift
class MainPresenterImpl {
    
    var mView: MainPageView? = nil
    let model : DataModel = DataModelImpl.shared
    let bag:DisposeBag = DisposeBag()
    
    var movieSlides: [MainVideoVO] = []
    var movieVideo : [MovieVideoDetailVO] = []
    var bestMovieList : [BestMovieVO] = []
    var genreList: [GenreVO] = []
    var genreMovieList: [GenreMovieVO] = []
}

extension MainPresenterImpl : MainPresenter {
    
    func attachView(view: MainPageView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
    }
    
    func onUIReady() {
        mView?.showLoading()
        model.getMovieSlidesFromAPI(page: 1, apiKey: API_KEY, sortkey: "popularity.desc")
        model.getMovieSlides()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext:{ data in
            self.mView?.hideLoading()
            print("slide list \(data.count)")
            
            if data.count > 0 {
                let range = 5...19
                var result = data
                result.removeSubrange(range)
                
//                for index in 0...result.count-1 {
//                    self.model.getMovieVideo(id: result[index].id, success: { (data) in
//                        self.mView?.hideLoading()
//                        result[index].key = data.key
//                        
//                    }) { (error) in
//                        self.mView?.hideLoading()
//                        self.mView?.showErrorMessage(err: "Video can't load now.")
//                    }
//                }
                self.movieSlides = result
                self.mView?.showMovieSlides(data: self.movieSlides)
            }
         
        },onError:{ error in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(err: error.localizedDescription)
        }).disposed(by: bag)
        
        
        //MARK: -Get Best Popular list
        model.getBestPopularMoviesFromAPI(page: 1, apiKey: API_KEY)
        model.getBestPopularMovies()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext:{ data in
                
                self.bestMovieList = data
                self.mView?.showBestMovieList(data: data)
                
                },onError:{ error in
                    self.mView?.hideLoading()
                    self.mView?.showErrorMessage(err: error.localizedDescription)
                }).disposed(by: bag)
        
        //MARK: -Get Genre list
        model.getGenreListFromAPI(apiKey: API_KEY)
        model.getGenresList()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext:{ data in
                
                self.genreList = data
                self.mView?.showGenreList(data: data)
                
                },onError:{ error in
                    self.mView?.hideLoading()
                    self.mView?.showErrorMessage(err: error.localizedDescription)
                }).disposed(by: bag)
        
        model.getGenre()
    }
    
    func getMovieVideo(movieId: Int) {
        mView?.showLoading()
        mView?.loadMovieVideo(data: model.getMovieSlidesDetail())
    }
}
