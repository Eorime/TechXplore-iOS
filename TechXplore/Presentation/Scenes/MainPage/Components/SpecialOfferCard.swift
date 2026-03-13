//
//  SpecialOfferCard.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//

import SwiftUI

struct SpecialOfferCard: View {
    let offer: SpecialOffer
    let persona: TravelerType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(offer.name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color("AppBlack"))
            Text(offer.address)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color("AppBlack").opacity(0.7))
            Text(offer.matchReason)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color("AppBlack").opacity(0.7))
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(persona.color).opacity(0.1))
        .cornerRadius(12)
    }
}
