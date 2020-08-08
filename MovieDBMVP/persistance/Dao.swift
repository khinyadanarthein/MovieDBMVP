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
    
    func saveGenreMovies(data:[GenreMovieVO]) -> Observable<Bool>
    func getGenreMovies() -> Observable<[GenreMovieVO]>
    func deleteGenreMovies()
    
    func saveActors(data:[MovieCastDetailVO]) -> Observable<Bool>
    func getPopularActors() -> Observable<[MovieCastDetailVO]>
    
    func saveShowcaseMovie(data:[MovieShowCaseVO]) -> Observable<Bool>
    func getShowcaseMovies() -> Observable<[MovieShowCaseVO]>
    
    //MARK: -Detail
    
    func saveMovieDetail(data : MovieDetailVO) -> Observable<Bool>
    func getMovieDetailById(id: Int) -> MovieDetailVO?
    
    func getMovieCasts() -> Observable<[MovieCastVO]>
    func getMovieCrews() -> Observable<[MovieCrewVO]>
    func saveMovieCredits(cast: [MovieCastVO], crew:[MovieCrewVO]) -> Observable<Bool>
    func deleteOldMovieCredits()
    
    //func saveRatedMovies(data:[RateMovieVO]) -> Observable<Bool>
    func saveFavoritedCast(data:MovieCastVO) -> Observable<Bool>
    func saveFavoritedMovie(data:MovieDetailVO) -> Observable<Bool>
    
}
