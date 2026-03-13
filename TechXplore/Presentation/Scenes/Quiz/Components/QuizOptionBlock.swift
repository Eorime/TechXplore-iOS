import SwiftUI

struct QuizOptionBlock: View {
    let option: QuizOption
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            Text(option.text)
                .font(.body)
                .foregroundColor(Color("AppWhite"))
                .padding(20)
                .frame(width: 150, height: 133)
                .background(isSelected ? Color("AppSelectedCyan") : option.type.color)
                .cornerRadius(6)
                .shadow(color: option.type.color.opacity(0.1), radius: 8, x: 0, y: 4)
        }
    }
}
