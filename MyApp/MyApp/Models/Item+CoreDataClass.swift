import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject, Identifiable {
    // Computed property for sync status enum
    var syncStatusValue: SyncStatus {
        get {
            return SyncStatus(rawValue: Int(syncStatus)) ?? .notSynced
        }
        set {
            syncStatus = Int16(newValue.rawValue)
        }
    }
}

// MARK: - Sync Status Enum
enum SyncStatus: Int {
    case notSynced = 0
    case syncing = 1
    case synced = 2
    case syncFailed = 3
    
    var description: String {
        switch self {
        case .notSynced: return "Not Synced"
        case .syncing: return "Syncing..."
        case .synced: return "Synced"
        case .syncFailed: return "Sync Failed"
        }
    }
}
