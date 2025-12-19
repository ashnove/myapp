import XCTest
@testable import MyApp

final class NetworkServiceTests: XCTestCase {
    var networkService: NetworkService!
    
    override func setUpWithError() throws {
        networkService = NetworkService.shared
    }
    
    override func tearDownWithError() throws {
        networkService = nil
    }
    
    func testOfflineMode() throws {
        // Given/When - in offline-first mode
        let isOnline = networkService.isOnline()
        
        // Then
        XCTAssertFalse(isOnline, "App should start in offline mode")
    }
    
    func testNetworkErrorDescriptions() throws {
        // Test error descriptions
        XCTAssertNotNil(NetworkError.offline.errorDescription)
        XCTAssertNotNil(NetworkError.invalidURL.errorDescription)
        XCTAssertNotNil(NetworkError.invalidResponse.errorDescription)
        XCTAssertNotNil(NetworkError.serverError(500).errorDescription)
        XCTAssertNotNil(NetworkError.decodingError.errorDescription)
    }
}
