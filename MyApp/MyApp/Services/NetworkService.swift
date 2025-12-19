import Foundation

/// NetworkService handles all network operations
/// Currently configured for offline-first operation, but ready to integrate with backend APIs
class NetworkService {
    static let shared = NetworkService()
    
    private let session: URLSession
    private var baseURL: String = "https://api.example.com" // Replace with your API URL
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        self.session = URLSession(configuration: configuration)
    }
    
    // MARK: - Network Reachability
    
    func isOnline() -> Bool {
        // TODO: Implement proper network reachability check
        // For now, returning false to indicate offline-first mode
        return false
    }
    
    // MARK: - API Methods (Ready for future online features)
    
    func syncItem(_ item: Item) async throws {
        guard isOnline() else {
            throw NetworkError.offline
        }
        
        // TODO: Implement API sync logic when backend is ready
        // Example:
        // let endpoint = "\(baseURL)/items"
        // let request = try buildRequest(url: endpoint, method: "POST", body: item)
        // let (data, response) = try await session.data(for: request)
        // Handle response...
    }
    
    func fetchItems() async throws -> [ItemDTO] {
        guard isOnline() else {
            throw NetworkError.offline
        }
        
        // TODO: Implement API fetch logic
        return []
    }
    
    // MARK: - Helper Methods
    
    private func buildRequest(url: String, method: String, body: Encodable? = nil) throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
}

// MARK: - Error Handling

enum NetworkError: Error, LocalizedError {
    case offline
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .offline:
            return "Device is offline. Changes will sync when online."
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .serverError(let code):
            return "Server error: \(code)"
        case .decodingError:
            return "Failed to decode response"
        }
    }
}

// MARK: - Data Transfer Objects

struct ItemDTO: Codable {
    let id: UUID
    let title: String
    let content: String
    let timestamp: Date
}
