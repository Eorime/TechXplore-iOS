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
        self.state = .auth
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
        UserDefaults.standard.removeObject(forKey: "savedOffers")
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
