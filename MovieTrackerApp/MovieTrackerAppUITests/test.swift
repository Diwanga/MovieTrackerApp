//
//  test.swift
//  MovieTrackerApp
//
//  Created by Diwanga Amasith on 2025-05-06.
//

import XCTest

class MovieTrackerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it's usually best to stop immediately when a failure occurs
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    
    // Test that the Discover tab can be navigated to
    func testDiscoverTabNavigation() {
        // Navigate to the Discover tab
        app.tabBars.buttons["Discover"].tap()
        
        // Verify the Discover tab is displayed
        XCTAssertTrue(app.navigationBars["Discover"].exists)
    }
    
    // Test search functionality
    func testDiscoverSearch() {
        // Navigate to Discover tab
        app.tabBars.buttons["Discover"].tap()
        
        // Type in search box
        let searchField = app.searchFields.firstMatch
        XCTAssertFalse(searchField.exists)
        
        searchField.tap()
        searchField.typeText("Star Wars")
        
        // Tap search button on keyboard
        app.keyboards.buttons["search"].tap()
        
        // Wait briefly for search results
        sleep(2)
        
        // Simply verify the app doesn't crash
        XCTAssertTrue(app.exists)
    }
    
    
    // Test that the Insights tab can be navigated to
    func testInsightsTabNavigation() {
        // Navigate to the Insights tab
        app.tabBars.buttons["Insights"].tap()
        
        // Verify the Insights tab is displayed
        XCTAssertTrue(app.navigationBars["Insights"].exists)
    }
    
    // Test refresh button
    func testInsightsRefreshButton() {
        // Navigate to Insights tab
        app.tabBars.buttons["Insights"].tap()
        
        // Find and tap refresh button (using the system image name "arrow.clockwise")
        let refreshButton = app.navigationBars.buttons.matching(identifier: "Refresh").firstMatch
        XCTAssertTrue(refreshButton.exists)
        
        refreshButton.tap()
        
        // Verify the app doesn't crash
        XCTAssertTrue(app.exists)
    }
    
    // Test presence of stats cards
    func testInsightsStatsCardsPresent() {
        // Navigate to Insights tab
        app.tabBars.buttons["Insights"].tap()
        
        // Verify stat card elements are displayed
        let texts = app.staticTexts
        
        XCTAssertTrue(texts["Movies Watched"].exists)
        XCTAssertTrue(texts["Watch Hours"].exists)
        XCTAssertTrue(texts["Favorite Genre"].exists)
        XCTAssertTrue(texts["Avg Rating"].exists)
    }
}


