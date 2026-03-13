protocol MerchantRepositoryProtocol {
    func getMerchants(page: Int, pageSize: Int) async throws -> MerchantPageResponse
}

final class MerchantRepository: MerchantRepositoryProtocol {
    private let network = NetworkService.shared
    
    func getMerchants(page: Int, pageSize: Int) async throws -> MerchantPageResponse {
        try await network.get(endpoint: "/api/User/Merchants?page=\(page)&pageSize=\(pageSize)")
    }
}
