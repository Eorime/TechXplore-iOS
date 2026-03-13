import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    @Published var offers: [SpecialOffer] = []
    @Published var isLoadingOffers = false
    @Published var offersError: String?
    @Published var transactions: [TransactionItem] = []
    private let offersKey = "savedOffers"
    
    private let recommendationUseCase: RecommendationUseCase
    
    init(recommendationUseCase: RecommendationUseCase) {
        self.recommendationUseCase = recommendationUseCase
        loadSavedOffers()
    }
    
    private func loadSavedOffers() {
        guard let data = UserDefaults.standard.data(forKey: offersKey),
              let saved = try? JSONDecoder().decode([SpecialOffer].self, from: data) else { return }
        offers = saved
    }
    
    private func saveOffers(_ offers: [SpecialOffer]) {
        guard let data = try? JSONEncoder().encode(offers) else { return }
        UserDefaults.standard.set(data, forKey: offersKey)
    }
    
    func loadRecommendations(location: String, budget: Double) {
        isLoadingOffers = true
        offersError = nil
        offers = []
        Task { @MainActor in
            do {
                offers = try await recommendationUseCase.getRecommendations(location: location, budget: budget)
                saveOffers(offers)
                NotificationManager.shared.handleNewOffers(offers)
            } catch {
                print("Offers error: \(error)")
                offersError = "Failed to load recommendations."
            }
            isLoadingOffers = false
        }
    }
    
    func loadTransactions() {
        Task { @MainActor in
            do {
                let response = try await TransactionUseCase(repository: TransactionRepository()).getSentTransactions(page: 1, pageSize: 4)
                transactions = response.items
            } catch {
                print("Home transactions error: \(error)")
            }
        }
    }
    
    
}
