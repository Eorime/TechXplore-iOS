final class RecommendationUseCase {
    private let repository: RecommendationRepositoryProtocol
    
    init(repository: RecommendationRepositoryProtocol) {
        self.repository = repository
    }
    
    func getRecommendations(location: String, budget: Double) async throws -> [SpecialOffer] {
        try await repository.getRecommendations(location: location, budget: budget)
    }
}
