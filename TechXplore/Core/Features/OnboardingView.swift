import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = DIContainer.shared.makeQuizViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.currentQuestion != nil {
                QuizView(viewModel: viewModel)
                    .padding(.horizontal, 30)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .fullScreenCover(isPresented: $viewModel.quizComplete) {
            ResultView(result: viewModel.result ?? .gourmet) {
                viewModel.quizComplete = false
                router.onboardingDidComplete(persona: viewModel.result ?? .gourmet)
            }
            .environmentObject(router)
        }
    }
}
