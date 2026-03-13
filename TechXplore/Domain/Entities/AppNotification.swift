import SwiftUI

struct AppNotification: Identifiable, Codable {
    let id: UUID
    let title: String
    let body: String
    let timestamp: Date
    
    init(title: String, body: String) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.timestamp = Date()
    }
}
