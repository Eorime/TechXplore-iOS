// Features/Home/ViewModel/MainViewModel.swift
import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
    @Published var offers: [SpecialOffer] = []
    @Published var isLoadingOffers = false
    @Published var offersError: String?
    
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
}
