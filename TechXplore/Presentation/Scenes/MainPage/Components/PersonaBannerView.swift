import SwiftUI

struct PersonaBannerView: View {
    let persona: TravelerType
    let description: String
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Image(persona.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 80)
            Text(description)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(persona.textColor)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color("AppWhite").opacity(0.8))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(persona.color, lineWidth: 0.5)
                )
        }
        .frame(maxWidth: .infinity)
    }
}
