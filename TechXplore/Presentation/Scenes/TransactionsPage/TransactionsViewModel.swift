import SwiftUI
import Combine

final class TransactionsViewModel: ObservableObject {
    @Published var groupedTransactions: [(String, [TransactionItem])] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var hasNextPage = false
    
    private var currentPage = 1
    private let pageSize = 20
    private let useCase: TransactionUseCase
    
    init(useCase: TransactionUseCase) {
        self.useCase = useCase
    }
    
    func loadTransactions() {
        currentPage = 1
        groupedTransactions = []
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                let response = try await useCase.getSentTransactions(page: currentPage, pageSize: pageSize)
                hasNextPage = response.hasNextPage
                appendAndGroup(response.items)
            } catch {
                errorMessage = "Failed to load transactions."
                print("Transaction error: \(error)")
            }
            isLoading = false
        }
    }
    
    func loadMore() {
        guard hasNextPage else { return }
        currentPage += 1
        isLoading = true
        Task { @MainActor in
            do {
                let response = try await useCase.getSentTransactions(page: currentPage, pageSize: pageSize)
                hasNextPage = response.hasNextPage
                appendAndGroup(response.items)
            } catch {
                errorMessage = "Failed to load transactions."
                print("Transaction error: \(error)")
            }
            isLoading = false
        }
    }
    
    private func appendAndGroup(_ items: [TransactionItem]) {
        let sorted = items.sorted {
            ($0.date ?? .distantPast) > ($1.date ?? .distantPast)
        }
        let grouped = Dictionary(grouping: sorted) { $0.formattedDate }
        let newGroups = grouped
            .sorted { lhs, rhs in
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                let d1 = formatter.date(from: lhs.key) ?? .distantPast
                let d2 = formatter.date(from: rhs.key) ?? .distantPast
                return d1 > d2
            }
            .map { ($0.key, $0.value) }
        
        groupedTransactions.append(contentsOf: newGroups)
    }
}
