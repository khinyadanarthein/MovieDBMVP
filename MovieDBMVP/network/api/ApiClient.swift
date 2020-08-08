//
//  ApiClient.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 04/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Mocker

class ApiClient: BaseApiClient {
    
    static let shared:ApiClient = ApiClient()
    
    private override init() {}
    
}


extension ApiClient : Api {
    func getSlideVideos(page: Int, apiKey: String, sortkey : String) -> Observable<MainVideoResponse> {
        let url = API_DISCOVER_MOVIE
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [
            PARAM_API_KEY: apiKey
            , PARAM_LANG: PARAM_LANGUAGE
            , PARAM_SORT_BY : "popularity.desc"
            , PARAM_INCLUDE_VIDEO : true
            , PARAM_PAGE: page]
        , value:MainVideoResponse.self )
    }
    
    func getPopularMovies(page: Int, apiKey: String) -> Observable<BestMovieResponse> {
        let url = API_GET_MOVIE + API_GET_TRENDING_MOVIES
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [
            PARAM_API_KEY: apiKey
            , PARAM_LANG: PARAM_LANGUAGE
            , PARAM_PAGE: page]
        , value:BestMovieResponse.self)
    }
    
    func getGenreTypes(apiKey: String) -> Observable<GenreResponse> {
        let url = API_GET_GENRES
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [
            PARAM_API_KEY: apiKey
            , PARAM_LANG: PARAM_LANGUAGE]
        , value:GenreResponse.self)
    }
    
    func getMoviesByGenre(page : Int, genreId: Int, apiKey: String) -> Observable<GenreMovieResponse> {
        let url = API_DISCOVER_MOVIE
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [
            PARAM_API_KEY: apiKey
            , PARAM_LANG: PARAM_LANGUAGE
            , PARAM_SORT_BY : "popularity.desc"
            , PARAM_INCLUDE_VIDEO : true
            , PARAM_PAGE: page
            , PARAM_VOTE_VALUE : 8
            , PARAM_GENRE : genreId]
        , value:GenreMovieResponse.self )
    }
    
    func getShowCaseVideos(page: Int, date: String, apiKey: String) -> Observable<MovieShowCaseResponse> {
        let url = API_DISCOVER_MOVIE
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [
            PARAM_API_KEY: apiKey
            , PARAM_LANG: PARAM_LANGUAGE
            , PARAM_SORT_BY : "primary_release_date.asc"
            , PARAM_INCLUDE_VIDEO : true
            , PARAM_PAGE: page
            , PARAM_RELEASE_DATE : date
            , PARAM_OR_LANGUAGE: "en"
            , PARAM_GENRE : 12]
        , value:MovieShowCaseResponse.self )
    }
    
    func getMovieVideo(id : Int, success: @escaping (MovieVideoDetailVO) -> Void, fail: @escaping (String) -> Void) {
        let url = API_GET_MOVIE + "\(id)" + API_GET_MOVIE_VIDEO
        print("request url \(url)")
        let params = [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE]
        
        self.requestApiWithoutObservable(url: url, method: .get, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(MovieVideoResponse.self, from: response)
            
            success((data.results?.first!)!)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getGenre(id : Int, success: @escaping (GenreResponse) -> Void, fail: @escaping (String) -> Void) {
        let url = API_GET_GENRES
        let params = [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE]
        
        self.requestApiWithoutObservable(url: url, method: .get, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(GenreResponse.self, from: response)
            print("response data \(data.genres.count)")
            //success(data)
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: response, options : .allowFragments) as? [Dictionary<String,Any>]
                {
                   print(jsonArray) // use the json here
                } else {
                    print("bad json")
                }
            } catch let error as NSError {
                print(error)
            }
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getPopularActors(page: Int, apiKey: String) -> Observable<MovieCastDetailResponse> {
        let url = APU_GET_POPULAR_CAST
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [
            PARAM_API_KEY: apiKey
            , PARAM_LANG: PARAM_LANGUAGE
            , PARAM_PAGE: page]
        , value:MovieCastDetailResponse.self )
    }
    
    //MARK: -Detail
    func getMovieDetail(id: Int, apiKey : String, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        let url = API_GET_MOVIE + "\(id)"
        let params = [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE]
        
        self.requestApiWithoutObservable(url: url, method: .get, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(MovieDetailVO.self, from: response)
            
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getMovieCredits(movieId: Int, apiKey : String) -> Observable<MovieCreditResponse> {
        let url = API_GET_MOVIE + "\(movieId)/" + API_GET_MOVIE_CREDITS
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: apiKey]
        , value:MovieCreditResponse.self )
    }
    
    func getMovieCreditsAll(id: Int, apiKey: String, success: @escaping (MovieCreditResponse) -> Void, fail: @escaping (String) -> Void) {
        
        let url = API_GET_MOVIE + "\(id)/" + API_GET_MOVIE_CREDITS
        let params = [PARAM_API_KEY: apiKey]
        
        self.requestApiWithoutObservable(url: url, method: .get, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(MovieCreditResponse.self, from: response)
            
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
}
