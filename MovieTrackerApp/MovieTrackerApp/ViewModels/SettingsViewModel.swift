import Foundation
import Combine
import SwiftUI
import CoreData


class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    func toggleDarkMode() {
        isDarkMode.toggle()
    }
}
