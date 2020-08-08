//
//  DetailView.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 07/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol DetailView {
    
    func showLoading()
    func hideLoading()
    func showErrorMessage(title:String, err:String)
    func showMovieDetail(data: MovieDetailVO)
    func ratedMovie(message : String)
    func addFavoriteMovie(message : String)
    func reloadCastList()
    func reloadCrewList()
    func playVideo(data : MovieVideoDetailVO)
}
