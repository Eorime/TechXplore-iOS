import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    @ObservedObject var notificationManager = NotificationManager.shared
    @State private var selectedTab = 1
    @State private var showNotifications = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TransactionsView()
                .tabItem { Label("", image: "transactions") }
                .tag(0)
            MainView(selectedTab: $selectedTab, showNotifications: $showNotifications)
                .tabItem { Label("", image: "home") }
                .tag(1)
            MerchantsView()
                .tabItem { Label("", image: "shops") }
                .tag(2)
        }
        .tint(Color("AppCyan"))
        .sheet(isPresented: $showNotifications) {
            NotificationsModalView(manager: notificationManager)
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(16)
        }
    }
}
