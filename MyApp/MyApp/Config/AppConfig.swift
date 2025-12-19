import Foundation

/// Central configuration for the app
struct AppConfig {
    // MARK: - App Information
    static let appName = "MyApp"
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    static let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    
    // MARK: - Environment
    enum Environment {
        case development
        case staging
        case production
        
        static var current: Environment {
            #if DEBUG
            return .development
            #else
            return .production
            #endif
        }
    }
    
    // MARK: - Feature Flags
    struct Features {
        static let offlineMode = true
        static let enableSync = false // Will be enabled when backend is ready
        static let enableAnalytics = false
        static let enablePushNotifications = false
    }
    
    // MARK: - API Configuration
    struct API {
        static var baseURL: String {
            switch Environment.current {
            case .development:
                return "https://dev-api.example.com"
            case .staging:
                return "https://staging-api.example.com"
            case .production:
                return "https://api.example.com"
            }
        }
        
        static let timeout: TimeInterval = 30
        static let maxRetries = 3
    }
    
    // MARK: - Storage Configuration
    struct Storage {
        static let enableCloudSync = false // iCloud sync (future feature)
        static let maxLocalStorageSize: Int64 = 100 * 1024 * 1024 // 100 MB
    }
    
    // MARK: - Debug Settings
    struct Debug {
        static let enableLogging = Environment.current == .development
        static let showNetworkLogs = Environment.current == .development
    }
}
