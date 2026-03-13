final class AuthUseCase {
    private let repository: AuthRepositoryProtocol
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    func login(email: String, password: String) async throws -> User {
        try await repository.login(email: email, password: password)
    }
    
    func registerOnly(username: String, email: String, password: String) async throws {
        try await repository.registerOnly(username: username, email: email, password: password)
    }
}
