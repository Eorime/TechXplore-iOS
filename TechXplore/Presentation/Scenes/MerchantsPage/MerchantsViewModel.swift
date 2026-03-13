import SwiftUI
import Combine

final class MerchantsViewModel: ObservableObject {
    @Published var groupedMerchants: [TravelerType: [Merchant]] = [:]
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: MerchantRepositoryProtocol
    
    init(repository: MerchantRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadMerchants() {
        isLoading = true
        Task { @MainActor in
            do {
                let response = try await repository.getMerchants(page: 1, pageSize: 50)
                groupedMerchants = Dictionary(grouping: response.items) {
                    $0.persona.travelerType ?? .gourmet
                }
            } catch {
                print("Merchants error: \(error)")
                errorMessage = "Failed to load merchants."
            }
            isLoading = false
        }
    }
}
