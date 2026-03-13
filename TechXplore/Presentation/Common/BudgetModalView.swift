import SwiftUI

struct BudgetModalView: View {
    @Binding var isPresented: Bool
    @State private var location: String = ""
    @State private var budget: String = ""
    let onApply: (String, Double) -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("Tell us your specifics")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(Color("AppCyan"))
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Location")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                TextField("e.g. Tokyo", text: $location)
                    .autocapitalization(.none)
                    .foregroundStyle(Color("AppCyan"))
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("AppCyan"), lineWidth: 2))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Max Budget ($)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                TextField("e.g. 500", text: $budget)
                    .keyboardType(.decimalPad)
                    .foregroundStyle(Color("AppCyan"))
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("AppCyan"), lineWidth: 2))
            }
            
            CustomButton(title: "Find Offers", width: .infinity, height: 45, action: {
                guard let budgetValue = Double(budget), !location.isEmpty else { return }
                let capped = min(budgetValue, 500)
                onApply(location, capped)
                isPresented = false
            }, fontWeight: .semibold)
        }
        .background(Color("AppWhite"))
        .cornerRadius(8)
        .padding(.horizontal, 20)
        .padding(.top, -30)
    }
}
