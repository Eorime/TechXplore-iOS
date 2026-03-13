import SwiftUI

struct MerchantCarousel: View {
    let title: String
    let merchants: [Merchant]
    let type: TravelerType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(type.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color("AppBlack"))
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(merchants) { merchant in
                        MerchantCard(merchant: merchant)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
