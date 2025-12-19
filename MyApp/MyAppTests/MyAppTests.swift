import XCTest
import CoreData
@testable import MyApp

final class MyAppTests: XCTestCase {
    var persistenceController: PersistenceController!
    var viewContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        persistenceController = PersistenceController(inMemory: true)
        viewContext = persistenceController.container.viewContext
    }
    
    override func tearDownWithError() throws {
        persistenceController = nil
        viewContext = nil
    }
    
    func testItemCreation() throws {
        // Given
        let item = Item(context: viewContext)
        item.id = UUID()
        item.title = "Test Item"
        item.content = "Test Content"
        item.timestamp = Date()
        
        // When
        try viewContext.save()
        
        // Then
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let results = try viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.title, "Test Item")
        XCTAssertEqual(results.first?.content, "Test Content")
    }
    
    func testItemDeletion() throws {
        // Given
        let item = Item(context: viewContext)
        item.id = UUID()
        item.title = "Test Item"
        try viewContext.save()
        
        // When
        viewContext.delete(item)
        try viewContext.save()
        
        // Then
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let results = try viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(results.count, 0)
    }
    
    func testItemUpdate() throws {
        // Given
        let item = Item(context: viewContext)
        item.id = UUID()
        item.title = "Original Title"
        try viewContext.save()
        
        // When
        item.title = "Updated Title"
        try viewContext.save()
        
        // Then
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let results = try viewContext.fetch(fetchRequest)
        
        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.title, "Updated Title")
    }
    
    func testSyncStatus() throws {
        // Given
        let item = Item(context: viewContext)
        item.id = UUID()
        item.syncStatusValue = .notSynced
        
        // When
        try viewContext.save()
        
        // Then
        XCTAssertEqual(item.syncStatusValue, .notSynced)
        
        // When changed
        item.syncStatusValue = .synced
        try viewContext.save()
        
        // Then
        XCTAssertEqual(item.syncStatusValue, .synced)
    }
}
