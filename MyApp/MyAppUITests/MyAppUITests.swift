import XCTest

final class MyAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testAddItem() throws {
        // Given - app is launched
        
        // When - tap the add button
        app.navigationBars["My App"].buttons["Add Item"].tap()
        
        // Then - verify a new item appears
        let list = app.collectionViews.firstMatch
        XCTAssertTrue(list.cells.count > 0, "Should have at least one item after adding")
    }
    
    func testNavigateToItemDetail() throws {
        // Given - add an item first
        app.navigationBars["My App"].buttons["Add Item"].tap()
        
        // When - tap on the item
        let firstCell = app.collectionViews.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 2))
        firstCell.tap()
        
        // Then - verify detail view appears
        XCTAssertTrue(app.navigationBars["Item Details"].exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(iOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
