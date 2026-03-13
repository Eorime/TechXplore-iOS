import SwiftUI
import Combine

struct RootView: View {
    @StateObject private var router = AppRouter()
    
    var body: some View {
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
}
