import SwiftUI

struct RootView: View {
    @StateObject private var router = AppRouter()
    
    var body: some View {
        Group {
            switch router.state {
            case .auth:
                AuthView()
                    .environmentObject(router)
            case .onboarding:
                OnboardingView()
                    .environmentObject(router)
            case .main:
                MainTabView()
                    .environmentObject(router)
            }
        }
        .onAppear {
            NotificationManager.shared.requestPermission()
        }
    }
}
