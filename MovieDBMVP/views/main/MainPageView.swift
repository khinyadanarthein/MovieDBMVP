//
//  MainPageView.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
protocol MainPageView{
    func showLoading()
    func hideLoading()
    func showErrorMessage(err:String)
    func loadingCollectionData()
    
    func showMovieSlides(data:[MainVideoVO])
    func loadMovieVideo(data : [MovieVideoDetailVO])
    
    func showBestMovieList(data:[BestMovieVO])
    func showGenreList(data:[GenreVO])
}
