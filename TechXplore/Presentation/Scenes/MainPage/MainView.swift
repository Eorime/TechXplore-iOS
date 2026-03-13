import SwiftUI

struct MainView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = DIContainer.shared.makeMainViewModel()
    @State private var showBudgetModal = false
    @Binding var selectedTab: Int

    var persona: TravelerType {
        router.currentUser?.persona ?? .gourmet
    }
    
    var body: some View {
        VStack(spacing: 0) {
            PageHeaderView(title: "Welcome back,", username: router.currentUser?.username, onWalletTap: {
                showBudgetModal = true
            })
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
            
            ScrollView {
                VStack(spacing: 30) {
                    PersonaBannerView(persona: persona, description: persona.shortText)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Special Offers")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color("AppBlack"))
                        
                        if viewModel.isLoadingOffers {
                            ProgressView()
                                .tint(persona.color)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 12)
                        } else if viewModel.offers.isEmpty {
                            Text("Choose location and budget to get offers!")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundStyle(persona.color)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 12)
                                .onTapGesture {
                                    showBudgetModal = true
                                }
                        } else {
                            SpecialOffersSection(offers: viewModel.offers, persona: persona)
                        }
                    }
                    
                    TransactionsSection(transactions: viewModel.transactions, onSeeMore: {
                        selectedTab = 0
                    })
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
        .sheet(isPresented: $showBudgetModal) {
            BudgetModalView(isPresented: $showBudgetModal) { location, budget in
                viewModel.loadRecommendations(location: location, budget: budget)
            }
            .presentationDetents([.medium])
            .presentationCornerRadius(16)
        }
        .onAppear {
            viewModel.loadTransactions()
        }
    }
}
