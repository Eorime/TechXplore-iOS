//
//  AuthRepositoryProtocol.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> User
    func register(username: String, email: String, password: String) async throws -> User
}

final class AuthRepository: AuthRepositoryProtocol {
    private let network = NetworkService.shared
    
    func login(email: String, password: String) async throws -> User {
        let body = LoginRequest(email: email, password: password)
        let response: AuthResponse = try await network.post(endpoint: "/api/Auth/login", body: body)
        return response.user
    }
    
    func register(username: String, email: String, password: String) async throws -> User {
        let body = RegisterRequest(username: username, email: email, password: password)
        let response: AuthResponse = try await network.post(endpoint: "/api/Auth/register", body: body)
        return response.user
    }
}
