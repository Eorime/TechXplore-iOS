import SwiftUI
import Combine

final class AuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let useCase: AuthUseCase
    var onLoginSuccess: ((User) -> Void)?
    
    init(useCase: AuthUseCase) {
        self.useCase = useCase
    }
    
    func login(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                let user = try await useCase.login(email: email, password: password)
                onLoginSuccess?(user)
            } catch {
                errorMessage = "Login failed. Check your credentials."
            }
            isLoading = false
        }
    }
    
    func register(username: String, email: String, password: String) {
        isLoading = true
        errorMessage = nil
        print("Registering: username=\(username), email=\(email), password=\(password)")
        Task { @MainActor in
            do {
                let user = try await useCase.register(username: username, email: email, password: password)
                onLoginSuccess?(user)
            } catch NetworkError.serverError(let code) {
                switch code {
                case 409: errorMessage = "An account with this email already exists."
                case 400: errorMessage = "Please check your details and try again."
                default: errorMessage = "Registration failed. Please try again."
                }
            } catch {
                print("Register error: \(error)")
                print("Full error: \(error)")
                errorMessage = "Registration failed: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    func validate(username: String, email: String, password: String, confirmPassword: String) -> String? {
        if username.count < 3 { return "Username must be at least 3 characters." }
        if username.count > 50 { return "Username cannot exceed 50 characters." }
        if email.isEmpty { return "Email is required." }
        if !email.contains("@") { return "A valid email address is required." }
        if password.count < 8 { return "Password must be at least 8 characters." }
        if !password.contains(where: { $0.isUppercase }) { return "Password must contain at least one uppercase letter." }
        if !password.contains(where: { $0.isLowercase }) { return "Password must contain at least one lowercase letter." }
        if !password.contains(where: { $0.isNumber }) { return "Password must contain at least one number." }
        if password != confirmPassword { return "Passwords don't match." }
        return nil
    }
}
