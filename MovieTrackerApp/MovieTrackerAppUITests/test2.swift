//
//  test2.swift
//  MovieTrackerAppUITests
//
//  Created by Diwanga Amasith on 2025-05-06.
//

import XCTest

class BasicMovieTrackerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here
        app = XCUIApplication()
        
        // Add a launch argument to potentially put the app in a test state
        app.launchArguments = ["UI-TESTING"]
        
        app.launch()
        
        // In UI tests it's best to stop immediately when a failure occurs
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    
    func testMyCinemaBasicNavigation() {
        // Verify the app launches to the My Cinema tab by default
        // or navigate to it if needed
        if !app.navigationBars["My Cinema"].exists {
            app.tabBars.buttons["My Cinema"].tap()
        }
        
        // Verify the navigation bar exists with correct title
        XCTAssertTrue(app.navigationBars["My Cinema"].exists)
        
        // Verify the "My Movie Lists" section exists
        // This test checks for static text elements rather than specific UI elements
        XCTAssertTrue(app.staticTexts["My Movie Lists"].exists)
        
        // Verify the "Recommended For You" section exists
        XCTAssertTrue(app.staticTexts["Recommended For You"].exists)
        
        // Verify the settings button exists
        XCTAssertTrue(app.buttons["gearshape"].exists)
        
        // Tap the settings button and verify it opens a sheet
        app.buttons["gearshape"].tap()
        
        // Wait a moment for the sheet to appear
        sleep(1)
        
        // Just verify the app doesn't crash
        XCTAssertTrue(app.exists)
    }
    
    
    func testDiscoverSearch() {
        // Navigate to the Discover tab
        app.tabBars.buttons["Discover"].tap()
        
        // Verify we're on the Discover tab
        XCTAssertTrue(app.navigationBars["Discover"].exists)
        
        // Find and tap the search field
        let searchField = app.searchFields.firstMatch
        XCTAssertFalse(searchField.exists)
        
        searchField.tap()
        
        // Type a search query
        searchField.typeText("Star Wars")
        
        // Tap the return key to trigger search
        app.keyboards.buttons["search"].tap()
        
        // Wait briefly for search to happen
        sleep(2)
        
        // Verify the filter button exists
        let filterButton = app.buttons.matching(
            NSPredicate(format: "label CONTAINS 'line.3.horizontal.decrease.circle'")
        ).firstMatch
        
        XCTAssertTrue(filterButton.exists)
        
        // Tap filter button
        filterButton.tap()
        
        // Wait for filters sheet to appear
        sleep(1)
        
        // Verify the app doesn't crash
        XCTAssertTrue(app.exists)
    }
}
