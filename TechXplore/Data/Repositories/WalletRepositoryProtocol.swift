protocol WalletRepositoryProtocol {
    func deposit(amount: Double) async throws
    func transfer(receiverId: Int, amount: Double) async throws
}

final class WalletRepository: WalletRepositoryProtocol {
    private let network = NetworkService.shared
    
    func deposit(amount: Double) async throws {
        let _: MessageResponse = try await network.post(endpoint: "/api/Wallet/deposit", body: DepositRequest(amount: amount))
    }
    
    func transfer(receiverId: Int, amount: Double) async throws {
        let _: MessageResponse = try await network.post(endpoint: "/api/Wallet/transfer", body: TransferRequest(receiverId: receiverId, amount: amount))
    }
}
