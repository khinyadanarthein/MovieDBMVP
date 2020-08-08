//
//  NetworkApiUnitTests.swift
//  MovieDBMVPTests
//
//  Created by Khin Yadanar Thein on 08/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieDBMVP
@testable import Mocker
@testable import Alamofire
@testable import RxSwift

class NetworkApiUnitTests: XCTestCase {
    
    let bag:DisposeBag = DisposeBag()
 
    func test_request_observable_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie-credits")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/338952/credits?api_key=cc61c73fdd787cda0cdf930eb5b2528b")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let searchUpcomingMovieExpectation = expectation(description: "upcoming movie list")
        
        ApiClient.shared.setNetworkClient(session: sessionManager)
        
        ApiClient.shared.getMovieCredits(movieId: 338952 ,apiKey: API_KEY)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.crew.count, 36)
                searchUpcomingMovieExpectation.fulfill()
            },onError:{ error in
                XCTAssertNotNil(error)
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_request_observable_failed_403() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie-credits")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/338952/credits?api_key=cc61c73fdd787cda0cdf930eb5b2528b")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let searchUpcomingMovieExpectation = expectation(description: " movie credits")
        
        ApiClient.shared.setNetworkClient(session: sessionManager)
        
        ApiClient.shared.getMovieCredits(movieId: 338952 ,apiKey: API_KEY)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.crew.count, 36)
                
            },onError:{ error in
                print("test error \(error.localizedDescription)")
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (Invalid Token error 403.)")
                searchUpcomingMovieExpectation.fulfill()
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_request_observable_failed_500() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie-credits")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/338952/credits?api_key=cc61c73fdd787cda0cdf930eb5b2528b")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 500, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let searchUpcomingMovieExpectation = expectation(description: " movie credits")
        
        ApiClient.shared.setNetworkClient(session: sessionManager)
        
        ApiClient.shared.getMovieCredits(movieId: 338952 ,apiKey: API_KEY)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.crew.count, 36)
                
            },onError:{ error in
                print("test error \(error.localizedDescription)")
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. ( error 500.)")
                searchUpcomingMovieExpectation.fulfill()
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_request_api_closure_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie_detail_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie detail")
        
        ApiClient.shared.setNetworkClient(session: sessionManager)
        ApiClient.shared.getMovieDetail(id: 547016, apiKey: API_KEY, success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNotNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_movie_detail_failed_403() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie_detail_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie detail")
        
        ApiClient.shared.setNetworkClient(session: sessionManager)
        ApiClient.shared.getMovieDetail(id: 547016,apiKey: API_KEY, success: { (data) in
            XCTAssertNotNil(data)
            print("test data \(data.id)")
        }) { (error) in
             XCTAssertNotNil(error)
             XCTAssertEqual(error, "Invalid Token")
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_movie_detail_failed_500() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie_detail_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 500, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie detail")
        
        ApiClient.shared.setNetworkClient(session: sessionManager)
        ApiClient.shared.getMovieDetail(id: 547016,apiKey: API_KEY, success: { (data) in
            XCTAssertNotNil(data)
            print("test data \(data.id)")
        }) { (error) in
             XCTAssertNotNil(error)
             XCTAssertEqual(error, "Input Error")
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
}
