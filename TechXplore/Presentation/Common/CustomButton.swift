import SwiftUI

// eqneba gadacemuli width, height, fontis zoma, feri, border radiusi
struct CustomButton: View {
    let title: String
    let width: CGFloat
    let height: CGFloat
    let action: () -> Void
    var isDisabled: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(Color("AppWhite"))
                .frame(width: width, height: height)
                .background(isDisabled ? Color.gray.opacity(0.4) : Color("AppCyan"))
                .cornerRadius(6)
        }
        .disabled(isDisabled)
    }
}
