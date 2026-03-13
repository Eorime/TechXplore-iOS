//
//  AuthUseCase.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//

final class AuthUseCase {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func login(email: String, password: String) async throws -> User {
        try await repository.login(email: email, password: password)
    }
    
    func register(username: String, email: String, password: String) async throws -> User {
        try await repository.register(username: username, email: email, password: password)
    }
}
