//
//  discoveryTests.swift
//  MovieTrackerApp
//
//  Created by Diwanga Amasith on 2025-05-06.
//

import XCTest
@testable import MovieTrackerApp

class DiscoverViewModelTests: XCTestCase {
    
    // Test 1: Verify that clearSearch resets all search parameters
    func testClearSearch() {
        // 1. Set up test data
        let viewModel = DiscoverViewModel()
        
        // 2. Set some search parameters
        viewModel.searchText = "Test Movie"
        viewModel.selectedGenre = "Action"
        viewModel.minRating = 7.5
        viewModel.yearFrom = 2020
        
        // 3. Call the method to test
        viewModel.clearSearch()
        
        // 4. Verify the results
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertNil(viewModel.selectedGenre)
        XCTAssertEqual(viewModel.minRating, 0.0)
        XCTAssertNil(viewModel.yearFrom)
    }
    
    // Test 2: Verify that the view model initializes with available genres
    func testAvailableGenresNotEmpty() {
        // 1. Create the view model
        let viewModel = DiscoverViewModel()
        
        // 2. Verify that available genres are not empty
        XCTAssertFalse(viewModel.availableGenres.isEmpty)
        
        // 3. Verify that some expected genres are included
        XCTAssertTrue(viewModel.availableGenres.contains("Action"))
        XCTAssertTrue(viewModel.availableGenres.contains("Comedy"))
        XCTAssertTrue(viewModel.availableGenres.contains("Drama"))
    }
}
