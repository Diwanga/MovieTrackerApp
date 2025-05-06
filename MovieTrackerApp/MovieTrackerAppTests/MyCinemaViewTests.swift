//
//  ViewModelWithMockTests.swift
//  MovieTrackerApp
//
//  Created by Diwanga Amasith on 2025-05-06.
//

import XCTest
@testable import MovieTrackerApp

class MyCinemaViewTests: XCTestCase {
    
    var mockRepository: MockMovieRepository!
    var viewModel: TestViewModel!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMovieRepository()
        viewModel = TestViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testLoadPlaylistsFromRepository() {
        // Load playlists
        viewModel.loadPlaylists()
        
        // Verify playlists were loaded from repository
        XCTAssertEqual(viewModel.playlists.count, 3, "Should load all playlists from repository")
        XCTAssertTrue(viewModel.playlists.contains { $0.name == "Watch List" }, "Watch List playlist should exist")
        XCTAssertTrue(viewModel.playlists.contains { $0.name == "Completed" }, "Completed playlist should exist")
        XCTAssertTrue(viewModel.playlists.contains { $0.name == "Custom Playlist" }, "Custom Playlist should exist")
    }
    
    func testSelectPlaylistLoadsMovies() {
        // Load playlists first
        viewModel.loadPlaylists()
        
        // Select the Watch List playlist
        if let watchList = viewModel.playlists.first(where: { $0.name == "Watch List" }) {
            viewModel.selectPlaylist(watchList)
            
            // Verify selected playlist
            XCTAssertEqual(viewModel.selectedPlaylist?.name, "Watch List", "Watch List should be selected")
            
            // Verify movies were loaded for that playlist
            XCTAssertEqual(viewModel.moviesInSelectedPlaylist.count, 2, "Watch List should have 2 movies")
            XCTAssertTrue(viewModel.moviesInSelectedPlaylist.contains { $0.title == "Test Movie 1" }, "Movie 1 should be in list")
            XCTAssertTrue(viewModel.moviesInSelectedPlaylist.contains { $0.title == "Test Movie 2" }, "Movie 2 should be in list")
            
            // Verify repository method was called
            XCTAssertTrue(mockRepository.getMoviesCalled, "Repository's getMovies method should be called")
        } else {
            XCTFail("Watch List playlist not found")
        }
    }
    
    func testCreatePlaylist() {
        // Initial count
        viewModel.loadPlaylists()
        let initialCount = viewModel.playlists.count
        
        // Create a new playlist
        viewModel.createPlaylist(name: "New Test Playlist")
        
        // Verify playlist was created
        XCTAssertEqual(viewModel.playlists.count, initialCount + 1, "Playlist count should increase by 1")
        XCTAssertTrue(viewModel.playlists.contains { $0.name == "New Test Playlist" }, "New playlist should exist")
        
        // Verify repository method was called
        XCTAssertTrue(mockRepository.createPlaylistCalled, "Repository's createPlaylist method should be called")
    }
    
    func testDeletePlaylist() {
        // Load playlists
        viewModel.loadPlaylists()
        let initialCount = viewModel.playlists.count
        
        // Find a non-default playlist to delete
        guard let playlistToDelete = viewModel.playlists.first(where: { $0.name == "Custom Playlist" }) else {
            XCTFail("Custom Playlist not found")
            return
        }
        
        // Delete the playlist
        viewModel.deletePlaylist(playlistToDelete)
        
        // Verify playlist was deleted
        XCTAssertEqual(viewModel.playlists.count, initialCount - 1, "Playlist count should decrease by 1")
        XCTAssertFalse(viewModel.playlists.contains { $0.name == "Custom Playlist" }, "Deleted playlist should not exist")
        
        // Verify repository method was called
        XCTAssertTrue(mockRepository.deletePlaylistCalled, "Repository's deletePlaylist method should be called")
    }
}

class TestViewModel {
    private let repository: MovieRepositoryProtocol
    
    var playlists: [MockPlaylistModel] = []
    var selectedPlaylist: MockPlaylistModel?
    var moviesInSelectedPlaylist: [MockMovieModel] = []
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadPlaylists() {
        playlists = repository.getPlaylists()
    }
    
    func selectPlaylist(_ playlist: MockPlaylistModel) {
        selectedPlaylist = playlist
        loadMoviesInSelectedPlaylist()
    }
    
    func loadMoviesInSelectedPlaylist() {
        guard let playlist = selectedPlaylist else {
            moviesInSelectedPlaylist = []
            return
        }
        
        moviesInSelectedPlaylist = repository.getMovies(inPlaylist: playlist)
    }
    
    func createPlaylist(name: String) {
        let newPlaylist = repository.createPlaylist(name: name, isDefault: false)
        playlists.append(newPlaylist)
    }
    
    func deletePlaylist(_ playlist: MockPlaylistModel) {
        repository.deletePlaylist(playlist)
        playlists.removeAll { $0.id == playlist.id }
        
        if selectedPlaylist?.id == playlist.id {
            selectedPlaylist = nil
            moviesInSelectedPlaylist = []
        }
    }
}
