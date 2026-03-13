// Features/Home/ViewModel/MainViewModel.swift
import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    @Published var offers: [SpecialOffer] = []
    @Published var isLoadingOffers = false
    @Published var offersError: String?
    @Published var transactions: [TransactionItem] = []
    
    private let recommendationUseCase: RecommendationUseCase
    
    init(recommendationUseCase: RecommendationUseCase) {
        self.recommendationUseCase = recommendationUseCase
    }
    
    func loadRecommendations(location: String, budget: Double) {
        isLoadingOffers = true
        offersError = nil
        Task { @MainActor in
            do {
                offers = try await recommendationUseCase.getRecommendations(location: location, budget: budget)
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
