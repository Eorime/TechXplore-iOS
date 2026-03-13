import SwiftUI
import Combine

final class WalletViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    
    private let repository: WalletRepositoryProtocol
    
    init(repository: WalletRepositoryProtocol) {
        self.repository = repository
    }
    
    func deposit(amount: Double) {
        isLoading = true
        errorMessage = nil
        successMessage = nil
        Task { @MainActor in
            do {
                try await repository.deposit(amount: amount)
                successMessage = "Deposit successful!"
            } catch {
                errorMessage = "Deposit failed. Try again."
            }
            isLoading = false
        }
    }
    
    func transfer(receiverId: Int, amount: Double) {
        isLoading = true
        errorMessage = nil
        successMessage = nil
        Task { @MainActor in
            do {
                try await repository.transfer(receiverId: receiverId, amount: amount)
                successMessage = "Payment successful!"
            } catch {
                errorMessage = "Payment failed. Try again."
            }
            isLoading = false
        }
    }
}
