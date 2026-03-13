protocol RecommendationRepositoryProtocol {
    func getRecommendations(location: String, budget: Double) async throws -> [SpecialOffer]
}

final class RecommendationRepository: RecommendationRepositoryProtocol {
    private let network = NetworkService.shared
    
    func getRecommendations(location: String, budget: Double) async throws -> [SpecialOffer] {
        try await network.get(endpoint: "/api/Recommendation?location=\(location)&budget=\(budget)")
    }
}
