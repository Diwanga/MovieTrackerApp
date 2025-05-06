import Foundation
import CoreData
import Combine
@testable import MovieTrackerApp


class MockPlaylistModel {
    var id: UUID
    var name: String
    var isDefault: Bool
    var movies: [MockMovieModel] = []
    
    init(id: UUID = UUID(), name: String, isDefault: Bool = false) {
        self.id = id
        self.name = name
        self.isDefault = isDefault
    }
}

class MockMovieModel {
    var id: String
    var title: String
    var type: String = "movie"
    var runtimeMinutes: Int32 = 120
    var averageRating: Double = 7.5
    var genres: [String] = ["Action", "Drama"]
    var isCompleted: Bool = false
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
}


protocol MovieRepositoryProtocol {
    func getPlaylists() -> [MockPlaylistModel]
    func getPlaylist(withName name: String) -> MockPlaylistModel?
    func createPlaylist(name: String, isDefault: Bool) -> MockPlaylistModel
    func deletePlaylist(_ playlist: MockPlaylistModel)
    func getMovies(inPlaylist playlist: MockPlaylistModel) -> [MockMovieModel]
    func isMovieInPlaylist(_ movieId: String, playlist: MockPlaylistModel) -> Bool
}


class MockMovieRepository: MovieRepositoryProtocol {
    // Test data
    private var playlists: [MockPlaylistModel] = []
    private var movies: [MockMovieModel] = []
    
    // For tracking method calls
    var createPlaylistCalled = false
    var deletePlaylistCalled = false
    var getMoviesCalled = false
    
    init() {
        setupTestData()
    }
    
    private func setupTestData() {
        // Create mock playlists
        let playlist1 = MockPlaylistModel(id: UUID(), name: "Watch List", isDefault: true)
        let playlist2 = MockPlaylistModel(id: UUID(), name: "Completed", isDefault: true)
        let playlist3 = MockPlaylistModel(id: UUID(), name: "Custom Playlist", isDefault: false)
        
        // Create mock movies
        let movie1 = MockMovieModel(id: "tt1234567", title: "Test Movie 1")
        let movie2 = MockMovieModel(id: "tt2345678", title: "Test Movie 2")
        let movie3 = MockMovieModel(id: "tt3456789", title: "Test Movie 3")
        
        // Add movies to playlists
        playlist1.movies = [movie1, movie2]
        playlist2.movies = [movie3]
        
        // Store in repository
        playlists = [playlist1, playlist2, playlist3]
        movies = [movie1, movie2, movie3]
    }
    
    
    func getPlaylists() -> [MockPlaylistModel] {
        return playlists
    }
    
    func getPlaylist(withName name: String) -> MockPlaylistModel? {
        return playlists.first { $0.name == name }
    }
    
    func createPlaylist(name: String, isDefault: Bool = false) -> MockPlaylistModel {
        createPlaylistCalled = true
        let newPlaylist = MockPlaylistModel(id: UUID(), name: name, isDefault: isDefault)
        playlists.append(newPlaylist)
        return newPlaylist
    }
    
    func deletePlaylist(_ playlist: MockPlaylistModel) {
        deletePlaylistCalled = true
        if let index = playlists.firstIndex(where: { $0.id == playlist.id }) {
            playlists.remove(at: index)
        }
    }
    
    func getMovies(inPlaylist playlist: MockPlaylistModel) -> [MockMovieModel] {
        getMoviesCalled = true
        if let mockPlaylist = playlists.first(where: { $0.id == playlist.id }) {
            return mockPlaylist.movies
        }
        return []
    }
    
    func isMovieInPlaylist(_ movieId: String, playlist: MockPlaylistModel) -> Bool {
        if let mockPlaylist = playlists.first(where: { $0.id == playlist.id }) {
            return mockPlaylist.movies.contains { $0.id == movieId }
        }
        return false
    }
}



import XCTest
@testable import MovieTrackerApp

class PersistenceTests: XCTestCase {
    
    var persistenceController: PersistenceController!
    
    override func setUp() {
        super.setUp()
        // Create a fresh in-memory store for each test
        persistenceController = PersistenceController(inMemory: true)
    }
    
    override func tearDown() {
        persistenceController = nil
        super.tearDown()
    }
    
    // Test that the controller can be initialized
    func testInitialization() {
        XCTAssertNotNil(persistenceController)
        XCTAssertNotNil(persistenceController.container)
        XCTAssertEqual(persistenceController.container.name, "MovieTrackerApp")
    }
    
    func testSaveMethod() {
        // Just verify that calling save() doesn't throw an exception
        XCTAssertNoThrow(persistenceController.save())
    }
    
}
