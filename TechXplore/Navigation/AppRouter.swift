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
        self.state = .auth
        self.currentUser = User(id: "1", email: "test@test.com", username: "Anon", persona: .gourmet)
    }
    
    func userDidLogin(_ user: User) {
        currentUser = user
        Task { @MainActor in
            do {
                let me = try await UserRepository().getMe()
                if let persona = me.persona {
                    currentUser?.persona = TravelerType.fromPersonaId(persona.id)
                    currentUser?.personaDescription = persona.description
                }
                state = currentUser?.persona == nil ? .onboarding : .main
            } catch {
                state = .onboarding
            }
        }
    }
    
    func onboardingDidComplete(persona: TravelerType) {
        currentUser?.persona = persona
        Task {
            try? await UserRepository().setPersona(persona)
        }
        state = .main
    }
    
    func logout() {
        currentUser = nil
        state = .auth
    }
}
