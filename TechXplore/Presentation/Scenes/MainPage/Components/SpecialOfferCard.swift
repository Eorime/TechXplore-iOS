import SwiftUI

struct SpecialOfferCard: View {
    let offer: SpecialOffer
    let persona: TravelerType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(offer.name)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color("AppBlack"))
                Spacer()
                Text("\(offer.estimatedCost)$")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(persona.color)
            }
            Text(offer.address)
                .font(.system(size: 11, weight: .regular))
                .foregroundStyle(Color("AppBlack").opacity(0.7))
            Text(offer.matchReason)
                .font(.system(size: 9, weight: .regular))
                .foregroundStyle(Color("AppBlack").opacity(0.7))
                .lineLimit(2)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(persona.color).opacity(0.1))
        .cornerRadius(6)
    }
}
