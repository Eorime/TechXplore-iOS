import SwiftUI
import Combine

enum AppState {
    case auth
    case onboarding
    case main
}

final class AppRouter: ObservableObject {
    @Published var state: AppState
    @Published var currentUser: User?
    
    init() {
        // On launch: no user → go to auth
        // replace es logic with real session checking later
        self.state = .main
    }
    
    func userDidLogin(_ user: User) {
        currentUser = user
        if user.persona == nil {
            state = .onboarding
        } else {
            state = .main
        }
    }
    
    func onboardingDidComplete(persona: TravelerType) {
        currentUser?.persona = persona
        state = .main
    }
    
    func logout() {
        currentUser = nil
        state = .auth
    }
}
