import SwiftUI

struct PaymentModalView: View {
    let merchant: Merchant
    @StateObject private var viewModel = DIContainer.shared.makeWalletViewModel()
    @State private var amount: String = ""
    @Binding var isPresented: Bool
    
    var travelerType: TravelerType? {
        merchant.persona.travelerType
    }
    
    func spaced(_ text: String) -> String {
        text.unicodeScalars.reduce("") { result, scalar in
            if CharacterSet.uppercaseLetters.contains(scalar) && !result.isEmpty {
                return result + " " + String(scalar)
            }
            return result + String(scalar)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 12) {
                if let type = travelerType {
                    Image(type.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(spaced(merchant.username))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color("AppCyan"))
                    Text(merchant.description)
                        .font(.system(size: 12))
                        .foregroundStyle(Color("AppBlack").opacity(0.6))
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Amount ($)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                TextField("e.g. 50", text: $amount)
                    .keyboardType(.decimalPad)
                    .foregroundStyle(Color("AppCyan"))
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("AppCyan"), lineWidth: 2))
            }
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundStyle(.red).font(.caption)
            }
            
            if let success = viewModel.successMessage {
                Text(success).foregroundStyle(.green).font(.caption)
            }
            
            CustomButton(
                title: viewModel.isLoading ? "Processing..." : "Pay",
                width: .infinity,
                height: 45,
                action: {
                    guard let amountValue = Double(amount), amountValue > 0 else { return }
                    viewModel.transfer(receiverId: merchant.id, amount: amountValue)
                },
                isDisabled: viewModel.isLoading,
                fontWeight: .semibold
            )
        }
        .padding(30)
        .padding(.top, -100)
    }
}
