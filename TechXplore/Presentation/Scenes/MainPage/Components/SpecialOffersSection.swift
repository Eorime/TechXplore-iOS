//
//  SpecialOffersSection.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


// Features/Home/Views/SpecialOffersSection.swift
import SwiftUI

struct SpecialOffersSection: View {
    let offers: [SpecialOffer]
    let persona: TravelerType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Special Offers")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color("AppCyan"))
            
            ForEach(offers) { offer in
                SpecialOfferCard(offer: offer, persona: persona)
            }
        }
    }
}
