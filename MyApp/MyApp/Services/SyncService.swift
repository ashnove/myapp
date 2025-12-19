import Foundation
import CoreData

/// SyncService manages synchronization between local storage and remote server
/// Implements offline-first pattern with background sync capabilities
class SyncService {
    static let shared = SyncService()
    
    private let networkService = NetworkService.shared
    private let persistenceController = PersistenceController.shared
    
    private init() {}
    
    // MARK: - Sync Operations
    
    /// Syncs all unsynced items with the server
    func syncAllItems() async {
        guard networkService.isOnline() else {
            print("Device offline - sync will retry when online")
            return
        }
        
        let context = persistenceController.newBackgroundContext()
        
        await context.perform {
            let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "syncStatus != %d", SyncStatus.synced.rawValue)
            
            do {
                let unsyncedItems = try context.fetch(fetchRequest)
                print("Found \(unsyncedItems.count) items to sync")
                
                for item in unsyncedItems {
                    await self.syncItem(item, in: context)
                }
            } catch {
                print("Error fetching unsynced items: \(error)")
            }
        }
    }
    
    /// Syncs a single item
    private func syncItem(_ item: Item, in context: NSManagedObjectContext) async {
        item.syncStatusValue = .syncing
        
        do {
            try context.save()
            
            // TODO: Implement actual API call when backend is ready
            // try await networkService.syncItem(item)
            
            // For now, just mark as synced after a delay (simulating network call)
            // await Task.sleep(nanoseconds: 1_000_000_000)
            
            item.syncStatusValue = .synced
            item.lastSyncedAt = Date()
            try context.save()
            
        } catch {
            print("Error syncing item: \(error)")
            item.syncStatusValue = .syncFailed
            try? context.save()
        }
    }
    
    // MARK: - Background Sync
    
    /// Starts periodic background sync
    func startBackgroundSync() {
        // TODO: Implement background sync using BGTaskScheduler
        // This will sync data periodically when the app is in the background
        print("Background sync ready to be configured")
    }
}
