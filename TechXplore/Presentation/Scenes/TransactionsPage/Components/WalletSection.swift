import SwiftUI

struct WalletSection: View {
    @StateObject private var viewModel = DIContainer.shared.makeWalletViewModel()
    @State private var amount: String = ""
    @State private var balance: Double? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Wallet")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color("AppBlack"))
            
            if let balance {
                Text("Balance: \(Int(balance))$")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color("AppCyan"))
            }
            
            HStack(spacing: 8) {
                TextField("Amount ($)", text: $amount)
                    .keyboardType(.decimalPad)
                    .foregroundStyle(Color("AppCyan"))
                    .font(.system(size: 13))
                    .padding(6)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("AppCyan"), lineWidth: 1))
                
                CustomButton(title: "Deposit", width: 80, height: 32, action: {
                    guard let amountValue = Double(amount), amountValue > 0 else { return }
                    viewModel.deposit(amount: amountValue)
                    amount = ""
                    Task {
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        if let me = try? await UserRepository().getMe() {
                            balance = me.wallet?.balance
                        }
                    }
                }, fontWeight: .semibold)
            }
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundStyle(.red).font(.caption)
            }
            if let success = viewModel.successMessage {
                Text(success).foregroundStyle(.green).font(.caption)
            }
        }
        .onAppear {
            Task {
                if let me = try? await UserRepository().getMe() {
                    balance = me.wallet?.balance
                }
            }
        }
    }
}
