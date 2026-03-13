import SwiftUI

struct SpecialOfferCard: View {
    @State private var showDetail = false
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
        .onTapGesture {
            showDetail = true
        }
        .sheet(isPresented: $showDetail) {
            VStack(alignment: .leading, spacing: 16) {
                Text(offer.name)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color("AppBlack"))
                Text(offer.address)
                    .font(.system(size: 14))
                    .foregroundStyle(Color("AppBlack").opacity(0.6))
                Text(offer.matchReason)
                    .font(.system(size: 14))
                    .foregroundStyle(Color("AppBlack").opacity(0.8))
                HStack {
                    Spacer()
                    Text("\(offer.estimatedCost)$")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(persona.color)
                }
                Spacer()
            }
            .padding(30)
            .presentationDetents([.medium])
            .presentationCornerRadius(16)
        }
    }
}
