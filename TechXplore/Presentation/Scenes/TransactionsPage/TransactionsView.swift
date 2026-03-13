import SwiftUI

struct TransactionsView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = DIContainer.shared.makeTransactionsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            PageHeaderView(title: "Transactions", username: nil)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            if viewModel.isLoading && $viewModel.groupedTransactions.isEmpty {
                Spacer()
                ProgressView()
                    .tint(Color("AppCyan"))
                Spacer()
            } else if let error = viewModel.errorMessage {
                Spacer()
                Text(error)
                    .foregroundStyle(Color("AppCyan").opacity(0.6))
                    .font(.system(size: 14))
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(viewModel.groupedTransactions, id: \.0) { date, items in
                            VStack(alignment: .leading, spacing: 0) {
                                Text(date)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(Color("AppCyan"))
                                    .padding(.bottom, 8)
                                
                                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                                    TransactionRow(item: item, isLast: index == items.count - 1)
                                }
                            }
                        }
                        
                        if viewModel.hasNextPage {
                            Button {
                                viewModel.loadMore()
                            } label: {
                                Text("Load more")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color("AppCyan"))
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .padding(.top, 8)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding(.top, 20)
        .onAppear {
            viewModel.loadTransactions()
        }
    }
}

#Preview {
    TransactionsView()
        .environmentObject(AppRouter())
}
