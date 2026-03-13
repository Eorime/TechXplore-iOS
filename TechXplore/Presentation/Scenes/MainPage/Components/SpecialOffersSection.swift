import SwiftUI

struct SpecialOffersSection: View {
    let offers: [SpecialOffer]
    let persona: TravelerType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(offers) { offer in
                        SpecialOfferCard(offer: offer, persona: persona)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .frame(height: 240)
        }
    }
}
