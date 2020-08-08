//
//  MovieDBMVPUITests.swift
//  MovieDBMVPUITests
//
//  Created by Khin Yadanar Thein on 29/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest

class MovieDBMVPUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    func test_tab_bar_button_navigate_success() {
        app.launch()
    }
    
    func test_slide_video_swipe_check_index() {
        
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews
        let slide = collectionViewsQuery/*@START_MENU_TOKEN@*/.cells.collectionViews.cells/*[[".scrollViews.cells.collectionViews",".scrollViews.cells",".cells",".cells.collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.children(matching: .other).element.children(matching: .other).element
        sleep(2)
        slide.tap()
        slide.swipeLeft()
    
    }
//
//    func test_video_play() {
//
//        let app = XCUIApplication()
//       app.launch()
//        app.collectionViews/*@START_MENU_TOKEN@*/.cells.collectionViews.cells/*[[".scrollViews.cells.collectionViews",".scrollViews.cells",".cells",".cells.collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.buttons["play.fill"].tap()
//        sleep(2)
//        app.children(matching: .window).element(boundBy: 1).children(matching: .other).element.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["Play/Pause"]/*[[".buttons[\"Pause\"]",".buttons[\"Play\/Pause\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//    }
    
    func test_best_movie_click_route_to_detail() {
        
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 3 pages").children(matching: .scrollView).element(boundBy: 1).children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        close_detail_page_success()
    }

    /**
         close detail screen success
    */
    func close_detail_page_success() {
        sleep(2)
        XCTAssertNotNil(app.images["closeDetailBtn"])
        app/*@START_MENU_TOKEN@*/.images["closeDetailBtn"]/*[[".scrollViews",".images[\"lessthan.circle\"]",".images[\"closeDetailBtn\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(2)
    }
    
    func test_genre_title_click() {
        
        let app = XCUIApplication()
        app.launch()
        let bestPopularFilmsAndSerialsStaticText = app.collectionViews.staticTexts["BEST POPULAR FILMS AND SERIALS"]
        bestPopularFilmsAndSerialsStaticText/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bestPopularFilmsAndSerialsStaticText.swipeUp()
        app.collectionViews/*@START_MENU_TOKEN@*/.cells.collectionViews.cells/*[[".scrollViews.cells.collectionViews",".scrollViews.cells",".cells",".cells.collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.staticTexts["Adventure"].tap()
        
    }
    
    func test_genre_movie_click() {
        XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.cells.staticTexts["Check Movie Show Time"].swipeRight()/*[[".scrollViews.cells.staticTexts[\"Check Movie Show Time\"]",".swipeUp()",".swipeRight()",".cells.staticTexts[\"Check Movie Show Time\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
               
    }
    
    
    func test_detail_movie_trailer() {
        
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.containing(.other, identifier:"Vertical scroll bar, 3 pages").children(matching: .scrollView).element(boundBy: 1).children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        
        
        app.scrollViews.otherElements.buttons[" PLAY TRAILER"].tap()
        XCTAssertNotNil(app.children(matching: .window).element(boundBy: 1).children(matching: .other).element)
        //close_detail_page_success()
    }
}
