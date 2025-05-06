//
//  ContentView.swift
//  MovieTrackerApp
//
//  Created by Diwanga Amasith on 2025-05-03.
//


import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") public var isDarkMode = false
    @StateObject public var myCinemaViewModel = MyCinemaViewModel()
    @StateObject public var discoverViewModel = DiscoverViewModel()
    @StateObject public var insightsViewModel = InsightsViewModel()
    
    var body: some View {
        TabView {
            MyCinemaView(viewModel: myCinemaViewModel)
                .tabItem {
                    Label("My Cinema", systemImage: "film")
                }
            
            DiscoverView(viewModel: discoverViewModel)
                .tabItem {
                    Label("Discover", systemImage: "magnifyingglass")
                }
            
            InsightsView(viewModel: insightsViewModel)
                .tabItem {
                    Label("Insights", systemImage: "chart.bar")
                }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)

    }
}
