import Foundation
import os.log

/// Centralized logging utility
struct Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.myapp.MyApp"
    
    enum Category: String {
        case general = "General"
        case network = "Network"
        case persistence = "Persistence"
        case sync = "Sync"
        case ui = "UI"
    }
    
    private let osLog: OSLog
    
    init(category: Category) {
        self.osLog = OSLog(subsystem: Logger.subsystem, category: category.rawValue)
    }
    
    func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        guard AppConfig.Debug.enableLogging else { return }
        let fileName = (file as NSString).lastPathComponent
        os_log(.debug, log: osLog, "[%{public}@:%d] %{public}@", fileName, line, message)
    }
    
    func info(_ message: String) {
        guard AppConfig.Debug.enableLogging else { return }
        os_log(.info, log: osLog, "%{public}@", message)
    }
    
    func warning(_ message: String) {
        os_log(.default, log: osLog, "⚠️ %{public}@", message)
    }
    
    func error(_ message: String, error: Error? = nil) {
        if let error = error {
            os_log(.error, log: osLog, "❌ %{public}@: %{public}@", message, error.localizedDescription)
        } else {
            os_log(.error, log: osLog, "❌ %{public}@", message)
        }
    }
}

// MARK: - Convenience Loggers

extension Logger {
    static let general = Logger(category: .general)
    static let network = Logger(category: .network)
    static let persistence = Logger(category: .persistence)
    static let sync = Logger(category: .sync)
    static let ui = Logger(category: .ui)
}
