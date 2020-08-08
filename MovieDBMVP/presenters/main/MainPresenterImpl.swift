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
    var slidemMovieVideo : [Int:MovieVideoDetailVO] = [:]
    var showcaseVideo : [Int:MovieVideoDetailVO] = [:]
    var bestMovieList : [BestMovieVO] = []
    var genreList: [GenreVO] = []
    var genreMovieList: [GenreMovieVO] = []
    var actorList: [MovieCastDetailVO] = []
    var showcaseList: [MovieShowCaseVO] = []
    var selectedGenre: Int = 0
    var updatedSlideIndex : Int = 0
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
                if data.count > 0 {
                    self.selectedGenre = data[0].id
                    self.getMovieByGenreId(genreId: data[0].id)
                }
                
                },onError:{ error in
                    self.mView?.hideLoading()
                    self.mView?.showErrorMessage(err: error.localizedDescription)
                }).disposed(by: bag)
        
        //model.getGenre()
        
        model.getActorListFromAPI(page: 1, apiKey: API_KEY)
        model.getActorList()
        .observeOn(MainScheduler.asyncInstance)
        .subscribe(onNext:{ data in
            
            self.actorList = data
            self.mView?.showActorList(data: data)
            
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
        
        
        let currentDate = CommonUtils.shared.getCurrentDate()
        print("current date \(currentDate)")
        model.getShowcaseListFromAPI(page: 1, date: currentDate, apiKey: API_KEY)
        model.getShowcaseList()
        .observeOn(MainScheduler.asyncInstance)
        .subscribe(onNext:{ data in
            
            self.showcaseList = data
            self.mView?.showShowCaseList()
            
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
    }
    
    func getMovieVideo(movieId: Int, index: Int, section : Int) {
        mView?.showLoading()
        model.getMovieVideo(id: movieId, success: { (videoData) in
            
            self.mView?.hideLoading()
            switch section {
            case HomeSection.PagingVideo.rawValue :
                self.updatedSlideIndex = index
                self.slidemMovieVideo.updateValue(videoData, forKey: movieId)
                self.mView?.loadSlideVideo(data: videoData, index: index)
                
            case HomeSection.Showcase.rawValue :
                self.showcaseVideo.updateValue(videoData, forKey: movieId)
                self.mView?.loadShowcaseVideo(data: videoData, index: index)
                
            default:
                break
            }
            
        }) { (error) in
            debugPrint(error)
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(err: error)
        }
        
    }
    
    func getMovieByGenreId(genreId: Int) {
        mView?.showLoading()
        self.model.getGenreMovieListFromAPI(page: 1, genreId: genreId, apiKey: API_KEY)
        self.model.getGenresMovieList()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext:{ movie in
                
                self.mView?.hideLoading()
                self.genreMovieList = movie
                self.selectedGenre = genreId
                self.mView?.showGenreList()
            
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: self.bag)
        
    }
    
    func onTapMovie(movieId: Int) {
        model.getMovieDetail(id: movieId, apiKey: API_KEY, success: { (data) in
            self.mView?.navigateToMovieDetail(movie: data)
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(err: error)
            
        }
    }
}
