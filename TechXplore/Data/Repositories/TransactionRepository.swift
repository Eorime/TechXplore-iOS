protocol TransactionRepositoryProtocol {
    func getSentTransactions(page: Int, pageSize: Int) async throws -> TransactionPageResponse
}

final class TransactionRepository: TransactionRepositoryProtocol {
    private let network = NetworkService.shared
    
    func getSentTransactions(page: Int, pageSize: Int) async throws -> TransactionPageResponse {
        try await network.get(endpoint: "/api/Transaction/Sent?page=\(page)&pageSize=\(pageSize)")
    }
}
