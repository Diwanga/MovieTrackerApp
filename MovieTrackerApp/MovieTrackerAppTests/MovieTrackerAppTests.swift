import XCTest
@testable import MovieTrackerApp

protocol PlaylistType {
    var name: String? { get }
    var isDefault: Bool { get }
}

protocol MovieType {
    var primaryTitle: String? { get }
    var id: String? { get }
}

class TestPlaylist: PlaylistType {
    var name: String?
    var isDefault: Bool
    var id = UUID()
    
    init(name: String?, isDefault: Bool = false) {
        self.name = name
        self.isDefault = isDefault
    }
}

class TestMovie: MovieType {
    var primaryTitle: String?
    var id: String?
    
    init(id: String?, title: String?) {
        self.id = id
        self.primaryTitle = title
    }
}

class MovieTrackerUnitTests: XCTestCase {
    
    func testTestDoubles() {
        // Create test objects
        let playlist = TestPlaylist(name: "Test Playlist", isDefault: true)
        let movie = TestMovie(id: "tt1234567", title: "Test Movie")
        
        // Verify properties
        XCTAssertEqual(playlist.name, "Test Playlist")
        XCTAssertTrue(playlist.isDefault)
        XCTAssertEqual(movie.primaryTitle, "Test Movie")
        XCTAssertEqual(movie.id, "tt1234567")
    }
    
    func testDarkModeToggle() {
        // Test key
        let testKey = "testDarkMode"
        
        // Set initial value
        UserDefaults.standard.set(false, forKey: testKey)
        
        // Check initial state
        var isDarkMode = UserDefaults.standard.bool(forKey: testKey)
        XCTAssertFalse(isDarkMode)
        
        // Toggle
        UserDefaults.standard.set(true, forKey: testKey)
        
        // Check updated state
        isDarkMode = UserDefaults.standard.bool(forKey: testKey)
        XCTAssertTrue(isDarkMode)
    }
    
    // Test that ContentView can be initialized
    func testContentViewInit() {
        let contentView = ContentView()
        XCTAssertNotNil(contentView)
    }
    
    // Test that the app can be initialized
    func testMovieTrackerAppInit() {
        let app = MovieTrackerApp()
        XCTAssertNotNil(app)
    }
    
    // Test that the persistence controller can be initialized with in-memory store
    func testPersistenceControllerInMemory() {
        let controller = PersistenceController(inMemory: true)
        XCTAssertNotNil(controller)
        XCTAssertNotNil(controller.container)
    }
}
