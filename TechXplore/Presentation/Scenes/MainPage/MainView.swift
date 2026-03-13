import SwiftUI

struct MainView: View {
    @EnvironmentObject var router: AppRouter
    var persona: TravelerType {
        router.currentUser?.persona ?? .gourmet
    }
    
   
    //if offers empty persona ferit "Choose location and budget to get offers!"
    //if transactions empty "No transactions as of now." cyanit
    
    var body: some View {
        VStack(spacing: 0) {
            PageHeaderView(title: "Welcome back,", username: router.currentUser?.username)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            ScrollView {
                VStack(spacing: 30) {
                    PersonaBannerView(
                        persona: persona,
                        description: persona.shortText
                    )
                    SpecialOffersSection(offers: offers, persona: persona)
                    TransactionsSection(transactions: transactions, onSeeMore: {})
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(AppRouter())
}
