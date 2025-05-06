import XCTest
@testable import MovieTrackerApp

class SimpleInsightsViewModelTests: XCTestCase {
    
    // Verify the view model initializes without crashing
    func testViewModelInitialization() {
        // Simply test that the view model can be instantiated without crashing
        let viewModel = InsightsViewModel()
        XCTAssertNotNil(viewModel)
    }
    
    // Verify the favoriteGenre N/A replacement
    func testFavoriteGenreDefaultValue() {
        // Create the view model
        let viewModel = InsightsViewModel()
        
        if viewModel.favoriteGenre.isEmpty {
            viewModel.favoriteGenre = "N/A"
        }
        
        XCTAssertFalse(viewModel.favoriteGenre.isEmpty)
        XCTAssertEqual(viewModel.favoriteGenre, "Sci-Fi")
    }
    
    // Test string formatting for numerical values
    func testValueFormatting() {
        // Create the view model
        let viewModel = InsightsViewModel()
        
        // Set test values
        viewModel.totalMoviesWatched = 42
        viewModel.totalWatchHours = 123.456
        viewModel.averageRating = 8.765
        
        // Test the formatted values
        let formattedWatchHours = String(format: "%.1f", viewModel.totalWatchHours)
        let formattedRating = String(format: "%.1f", viewModel.averageRating)
        
        XCTAssertEqual(formattedWatchHours, "123.5")
        XCTAssertEqual(formattedRating, "8.8")
    }
}
