import SwiftUI

struct MainView: View {
    @EnvironmentObject var router: AppRouter
    let persona: TravelerType = .gourmet
    let transactions: [Transaction] = [
        Transaction(senderId: 1, receiver: TransactionUser(id: 1, username: "Belvedere", email: "", role: "", persona: TransactionPersona(id: 1, name: "culture", description: ""), description: ""), amount: 30, timestamp: ""),
        Transaction(senderId: 1, receiver: TransactionUser(id: 2, username: "Bauernbrau", email: "", role: "", persona: TransactionPersona(id: 2, name: "gourmet", description: ""), description: ""), amount: 45, timestamp: ""),
        Transaction(senderId: 1, receiver: TransactionUser(id: 3, username: "U4 Vienna", email: "", role: "", persona: TransactionPersona(id: 3, name: "nightlifer", description: ""), description: ""), amount: 220, timestamp: ""),
        Transaction(senderId: 1, receiver: TransactionUser(id: 3, username: "U4 Vienna", email: "", role: "", persona: TransactionPersona(id: 3, name: "nightlifer", description: ""), description: ""), amount: 220, timestamp: "")
    ]
    let offers: [SpecialOffer] = [
        SpecialOffer(name: "Bauernbrau", address: "Vienna, Austria", matchReason: "Great food scene"),
        SpecialOffer(name: "Belvedere", address: "Vienna, Austria", matchReason: "Cultural hotspot"),
        SpecialOffer(name: "Wien Mitte", address: "Vienna, Austria", matchReason: "Lifestyle hub")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            PageHeaderView(title: "Welcome back,", username: router.currentUser?.username)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            ScrollView {
                VStack(spacing: 30) {
                    PersonaBannerView(
                        persona: persona,
                        description: "The Gourmet - your trips revolve around food."
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
