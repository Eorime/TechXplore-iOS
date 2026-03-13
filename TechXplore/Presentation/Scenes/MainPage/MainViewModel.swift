import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    @Published var offers: [SpecialOffer] = []
    @Published var isLoadingOffers = false
    @Published var offersError: String?
    @Published var transactions: [TransactionItem] = []
    
    private let offersKey = "savedOffers"
    private let locationKey = "savedLocation"
    private let budgetKey = "savedBudget"
    
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
    
    func clearOffers() {
        offers = []
        UserDefaults.standard.removeObject(forKey: offersKey)
    }
    
    func loadRecommendations(location: String, budget: Double) {
        UserDefaults.standard.set(location, forKey: locationKey)
        UserDefaults.standard.set(budget, forKey: budgetKey)
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
    
    func refreshIfNeeded() {
        guard offers.isEmpty,
              let location = UserDefaults.standard.string(forKey: locationKey),
              UserDefaults.standard.double(forKey: budgetKey) > 0 else { return }
        let budget = UserDefaults.standard.double(forKey: budgetKey)
        loadRecommendations(location: location, budget: budget)
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
