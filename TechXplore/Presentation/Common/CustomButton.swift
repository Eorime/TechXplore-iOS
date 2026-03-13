import SwiftUI

struct CustomButton: View {
    let title: String
    var width: CGFloat? = nil
    let height: CGFloat
    let action: () -> Void
    var isDisabled: Bool = false
    var color: Color = Color("AppCyan")
    var fontWeight: Font.Weight = .regular
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(fontWeight)
                .foregroundColor(Color("AppWhite"))
                .frame(maxWidth: width ?? .infinity, minHeight: height)
                .background(isDisabled ? Color("AppCyan").opacity(0.2) : color)
                .cornerRadius(6)
        }
        .disabled(isDisabled)
    }
}
