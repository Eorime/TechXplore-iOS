//
//  SpecialOfferCard.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


// Features/Home/Views/SpecialOfferCard.swift
import SwiftUI

struct SpecialOfferCard: View {
    let offer: SpecialOffer
    let persona: TravelerType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(offer.name)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color("AppCyan"))
            Text(offer.address)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color("AppCyan").opacity(0.7))
            Text(offer.matchReason)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color("AppCyan").opacity(0.7))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(persona.color).opacity(0.2))
        .cornerRadius(12)
    }
}
