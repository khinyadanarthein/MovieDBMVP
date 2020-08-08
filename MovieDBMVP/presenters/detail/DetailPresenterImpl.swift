//
//  DetailPresenterImpl.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 08/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

class DetailPresenterImpl {
    
    
    var movieDetail = MovieDetailVO()
    var movieCastList: [MovieCastVO] = []
    var movieCrewList: [MovieCrewVO] = []
    
    let bag:DisposeBag = DisposeBag()
    var mView: DetailView? = nil
    let model : DataModel = DataModelImpl.shared
}

extension DetailPresenterImpl : DetailPresenter {
    
    func onUIReady(movieId : Int) {
        mView?.showLoading()
//       
//        model.getMovieCreditsFromAPI(movieId: movieId, apiKey: API_KEY)
//        model.getMovieCasts()
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext:{ data in
//                self.mView?.hideLoading()
//                self.movieCastList = data
//                self.mView?.reloadCastList()
//                
//            },onError:{ error in
//                self.mView?.hideLoading()
//                self.mView?.showErrorMessage(title: "Loding Error",err: error.localizedDescription)
//            }).disposed(by: bag)
//        
//        model.getMovieCrews()
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext:{ data in
//                self.mView?.hideLoading()
//                self.movieCrewList = data
//                self.mView?.reloadCrewList()
//                
//            },onError:{ error in
//                self.mView?.hideLoading()
//                self.mView?.showErrorMessage(title: "Loding Error",err: error.localizedDescription)
//            }).disposed(by: bag)
//        
        model.getMovieCredits(id: movieId, apiKey: API_KEY, success: { (data) in
            self.mView?.hideLoading()
            self.movieCastList = data.cast
            self.mView?.reloadCastList()
            self.movieCrewList = data.crew
            self.mView?.reloadCrewList()
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(title: "Loding Error",err: error)
        }
    }
    
    func getMovieVideo(movieId: Int) {
        mView?.showLoading()
        model.getMovieVideo(id: movieId, success: { (data) in
            self.mView?.hideLoading()
            self.mView?.playVideo(data: data)
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(title: "Loading", err: "Video can't load now.")
        }
    }
    func rateMovie(movieId: Int) {
        
    }
    
    func addFavMovie(movieId: Int) {
        
    }
    
//
//    func rateMovie(movieId : Int) {
//        mView?.showLoading()
//        model.addMovieToRatedList(id: movieId, sessionId: UserDefaultUtil.shared.retrieveSessionID(), success: { (message) in
//            self.mView?.hideLoading()
//            self.mView?.ratedMovie(message: message)
//
//        }) { (error) in
//            self.mView?.hideLoading()
//            self.mView?.showErrorMessage(title: "Rating", err: error)
//        }
//    }
//
//    func addWatchMovie(movieId :Int) {
//        mView?.showLoading()
//        model.addMovieToWatchedList(userId: UserDefaultUtil.shared.retrieveUserId(), movieId: movieId, sessionId: UserDefaultUtil.shared.retrieveSessionID(), success: { (message) in
//            self.mView?.hideLoading()
//            self.mView?.addWatchedMovie(message: "Add Watch List")
//
//        }) { (error) in
//            self.mView?.hideLoading()
//            self.mView?.showErrorMessage(title: "Add Watch",err: error)
//        }
//    }
//
    func attachView(view: DetailView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
        //model.deleteSimilarMovie()
    }
    
    
}

