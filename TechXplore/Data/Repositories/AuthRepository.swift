//
//  AuthRepositoryProtocol.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


import Foundation

protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> User
    func register(username: String, email: String, password: String) async throws -> User
}

final class AuthRepository: AuthRepositoryProtocol {
    private let network = NetworkService.shared
    
    func login(email: String, password: String) async throws -> User {
        let body = LoginRequest(email: email, password: password)
        let response: AuthResponse = try await network.post(endpoint: "/api/Auth/login", body: body)
        TokenManager.shared.token = response.token
        return parseUser(from: response.token)
    }

    func register(username: String, email: String, password: String) async throws -> User {
        let body = RegisterRequest(username: username, email: email, password: password)
        print("Sending register request...")
        let _: MessageResponse = try await network.post(endpoint: "/api/Auth/register", body: body)
        print("Register succeeded, now logging in...")
        return try await login(email: email, password: password)
    }
    
    private func parseUser(from token: String) -> User {
        let parts = token.components(separatedBy: ".")
        guard parts.count == 3 else { return User(id: "", email: "", username: "", persona: nil) }
        
        var base64 = parts[1]
        let remainder = base64.count % 4
        if remainder != 0 { base64 += String(repeating: "=", count: 4 - remainder) }
        
        guard let data = Data(base64Encoded: base64),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return User(id: "", email: "", username: "", persona: nil)
        }
        
        let id = json["sub"] as? String ?? ""
        let email = json["email"] as? String ?? ""
        let username = json["name"] as? String ?? ""
        return User(id: id, email: email, username: username, persona: nil)
    }
}
