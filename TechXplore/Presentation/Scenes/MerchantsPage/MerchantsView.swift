import SwiftUI

struct MerchantsView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = DIContainer.shared.makeMerchantsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            PageHeaderView(title: "Merchants", username: nil)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                    .tint(Color("AppCyan"))
                Spacer()
            } else if let error = viewModel.errorMessage {
                Spacer()
                Text(error)
                    .foregroundStyle(Color("AppCyan").opacity(0.6))
                    .font(.system(size: 14))
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 30) {
                        ForEach(TravelerType.allCases, id: \.self) { type in
                            if let merchants = viewModel.groupedMerchants[type], !merchants.isEmpty {
                                MerchantCarousel(
                                    title: type.name,
                                    merchants: merchants,
                                    type: type
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
        .onAppear {
            viewModel.loadMerchants()
        }
    }
}

#Preview {
    MerchantsView()
        .environmentObject(AppRouter())
}
