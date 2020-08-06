//
//  Dao.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

protocol Dao {
    func saveSlideVideos(data:[MainVideoVO]) -> Observable<Bool>
    func getMovieSlides() -> Observable<[MainVideoVO]>
    func saveVideoDetail(data: MovieVideoDetailVO) -> Observable<Bool>
    func getMovieSlidesDetail() -> [MovieVideoDetailVO]
    
    func saveBestPopularMovies(data:[BestMovieVO]) -> Observable<Bool>
    func getPopularMovies() -> Observable<[BestMovieVO]>
    
    func saveGenres(data:[GenreVO]) -> Observable<Bool>
    func getGenres() -> Observable<[GenreVO]>
    
//    func saveSlideVideosDetail(data:MovieVideoDetailVO) -> Observable<Bool>
//    func getMovieSlidesDetail() -> Observable<[MovieVideoDetailVO]>
}
