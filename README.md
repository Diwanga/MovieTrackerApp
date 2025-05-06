# Movie Tracker App

A comprehensive movie tracking application for iOS and iPadOS, built with SwiftUI and Core Data. This app allows users to track their watched movies, create custom playlists, discover new films, and view insights about their watching habits.

## Features

### My Cinema
- Personal movie collection management
- Create custom playlists
- Mark movies as watched
- View auto-suggested similar films based on watching history

### Discover
- Search IMDb database for movies
- Filter by name, genre, and rating
- Add movies to watchlist or custom playlists

### Insights
- Visualize viewing habit analytics
- Track total watched movies and hours
- See favorite genres and average ratings
- View genre distribution charts

## Technical Overview

### Architecture
- **MVVM Pattern**: Clear separation of UI (Views), business logic (ViewModels), and data (Models)
- **Repository Pattern**: Abstraction layer for data operations
- **Protocol-Oriented Programming**: Interfaces for dependency injection and testing

### Technologies
- **SwiftUI**: Modern declarative UI framework
- **Core Data**: Persistent storage for movie information and user data
- **Combine**: Reactive programming for handling asynchronous events
- **RapidAPI IMDb API**: External data source for movie information

### Core Data Model
- **Movie**: Stores movie details from the API
- **Playlist**: Represents user-created collections and default lists (Completed/Watchlist)
- **UserStats**: Tracks user viewing statistics

## Setup Instructions

### Prerequisites
- Xcode 14.0+
- iOS 16.0+
- RapidAPI Account with IMDb API subscription

### Installation Steps

1. Clone the repository in Final version Branch
```bash
git clone https://github.com/Diwanga/movie-tracker.git
cd movie-tracker
```

2. Open the project in Xcode
```bash
open MovieTracker.xcodeproj
```

3. Set up your RapidAPI Key
   - Create a configuration file called `APIConfig.swift` in the Network folder
   - Add your RapidAPI key as follows:
   ```swift
   struct APIConfig {
       static let rapidAPIKey = "YOUR_RAPIDAPI_KEY"
       static let rapidAPIHost = "imdb236.p.rapidapi.com"
   }
   ```

4. Build and run the app on your device or simulator

## Usage

### Adding Movies to Your Collection
1. Go to the "Discover" tab
2. Search for movies by title, genre, or rating
3. Tap on a movie to see details
4. Add to watchlist or mark as completed

### Creating Custom Playlists
1. Go to the "My Cinema" tab
2. Tap the "+" button next to your playlists
3. Enter a name for your new playlist
4. Add movies to your playlist from the movie detail view

### Viewing Insights
1. Go to the "Insights" tab
2. View statistics about your watched movies
3. See your genre distribution

## License
This project is part of an MSc program and is intended for educational purposes.

## Acknowledgements
- [RapidAPI IMDb API](https://rapidapi.com/imdb-api/api/imdb-api) for providing movie data
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) for the modern UI framework
