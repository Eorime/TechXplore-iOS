import SwiftUI

struct TransactionsSection: View {
    let transactions: [Transaction]
    var onSeeMore: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Transactions")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color("AppBlack"))
                .padding(.bottom, 8)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(transactions.enumerated()), id: \.offset) { index, transaction in
                        TransactionRow(transaction: transaction, isLast: index == transactions.count - 1)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .frame(height: 180)
            
            Button {
                onSeeMore?()
            } label: {
                Text("See all")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
        }
    }
}

#Preview {
    TransactionsSection(transactions: [])
        .padding(20)
}
