import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = DIContainer.shared.makeQuizViewModel()
    
    var body: some View {
        QuizView(viewModel: viewModel)
            .padding(.horizontal, 30)
            .fullScreenCover(isPresented: $viewModel.quizComplete) {
                ResultView(result: viewModel.result ?? .gourmet) {
                    viewModel.quizComplete = false
                    viewModel.currentQuestionIndex = 0
                }
            }
    }
}

#Preview {
    MainView()
}
