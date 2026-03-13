import SwiftUI

struct MerchantCard: View {
    let merchant: Merchant
    
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
        VStack(alignment: .leading, spacing: 8) {
            if let type = travelerType {
                Image(type.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 40)
            }
            
            Text(spaced(merchant.username))
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color("AppBlack"))
            
            Text(merchant.description)
                .font(.system(size: 9, weight: .regular))
                .foregroundStyle(Color("AppBlack").opacity(0.6))
                .lineLimit(2)
        }
        .padding(12)
        .frame(width: 150, height: 100)
        .background((travelerType?.color ?? Color("AppCyan")).opacity(0.1))
        .cornerRadius(6)
    }
}
