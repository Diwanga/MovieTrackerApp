//
//  MovieTrackerAppApp.swift
//  MovieTrackerApp
//
//  Created by user271708 on 5/4/25.
//

import SwiftUI

@main
struct MovieTrackerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
