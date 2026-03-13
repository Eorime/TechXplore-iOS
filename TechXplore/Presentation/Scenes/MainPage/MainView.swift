import SwiftUI

import SwiftUI

struct MainView: View {
    @EnvironmentObject var router: AppRouter
    let persona: TravelerType = .gourmet
    let offers: [SpecialOffer] = [
        SpecialOffer(name: "Bauernbrau", address: "Vienna, Austria", matchReason: "Great food scene"),
        SpecialOffer(name: "Belvedere", address: "Vienna, Austria", matchReason: "Cultural hotspot"),
        SpecialOffer(name: "Wien Mitte", address: "Vienna, Austria", matchReason: "Lifestyle hub")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                PageHeaderView(title: "Welcome back,", username: router.currentUser?.username)
                SpecialOffersSection(offers: offers, persona: persona)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    MainView()
        .environmentObject(AppRouter())
}
