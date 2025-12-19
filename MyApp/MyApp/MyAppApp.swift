import SwiftUI

@main
struct MyAppApp: App {
    // Initialize the persistence controller for offline data storage
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
