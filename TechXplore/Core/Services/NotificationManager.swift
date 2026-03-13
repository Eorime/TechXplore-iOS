import UserNotifications
import SwiftUI
import Combine

final class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    @Published var notifications: [AppNotification] = []
    @Published var hasUnread = false
    
    private let notificationsKey = "savedNotifications"
    private let cheapestCostKey = "cheapestOfferCost"
    
    private init() {
        loadNotifications()
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }
    
    func handleNewOffers(_ offers: [SpecialOffer]) {
        guard let cheapest = offers.min(by: { $0.estimatedCost < $1.estimatedCost }) else { return }
        
        let previousCost = UserDefaults.standard.integer(forKey: cheapestCostKey)
        if previousCost > 0 && cheapest.estimatedCost >= previousCost { return }
        
        UserDefaults.standard.set(cheapest.estimatedCost, forKey: cheapestCostKey)
        
        let notification = AppNotification(
            title: "New Deal: \(cheapest.name)",
            body: "\(cheapest.address) — only \(cheapest.estimatedCost)€"
        )
        
        notifications.insert(notification, at: 0)
        hasUnread = true
        saveNotifications()
        sendPushNotification(title: notification.title, body: notification.body)
    }
    
    func markAsRead() {
        hasUnread = false
    }
    
    private func sendPushNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    private func saveNotifications() {
        guard let data = try? JSONEncoder().encode(notifications) else { return }
        UserDefaults.standard.set(data, forKey: notificationsKey)
    }
    
    private func loadNotifications() {
        guard let data = UserDefaults.standard.data(forKey: notificationsKey),
              let saved = try? JSONDecoder().decode([AppNotification].self, from: data) else { return }
        notifications = saved
        hasUnread = !saved.isEmpty
    }
}
