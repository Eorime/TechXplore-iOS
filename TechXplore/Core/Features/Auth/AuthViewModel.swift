//
//  AuthViewModel.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


// Features/Auth/ViewModel/AuthViewModel.swift
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
        Task { @MainActor in
            do {
                let user = try await useCase.register(username: username, email: email, password: password)
                onLoginSuccess?(user)
            } catch {
                errorMessage = "Registration failed. Try again."
            }
            isLoading = false
        }
    }
}
