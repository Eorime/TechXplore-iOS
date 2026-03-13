final class TransactionUseCase {
    private let repository: TransactionRepositoryProtocol
    
    init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }
    
    func getSentTransactions(page: Int = 1, pageSize: Int = 20) async throws -> TransactionPageResponse {
        try await repository.getSentTransactions(page: page, pageSize: pageSize)
    }
}
