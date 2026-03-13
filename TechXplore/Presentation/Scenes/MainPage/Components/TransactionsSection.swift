import SwiftUI

struct TransactionsSection: View {
    let transactions: [TransactionItem]
    var onSeeMore: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Transactions")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color("AppBlack"))
                .padding(.bottom, 8)
            
            if transactions.isEmpty {
                Text("No transactions as of now.")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color("AppCyan"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 12)
            } else {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(transactions.enumerated()), id: \.offset) { index, transaction in
                            TransactionRow(item: transaction, isLast: index == transactions.count - 1)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(maxHeight: 180)
                
                Button {
                    onSeeMore?()
                } label: {
                    Text("See all")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color("AppCyan"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.bottom, 20)
                .padding(.top, 20)
                .padding(.horizontal, 4)
            }
        }
    }
}

#Preview {
    TransactionsSection(transactions: [])
        .padding(20)
}
