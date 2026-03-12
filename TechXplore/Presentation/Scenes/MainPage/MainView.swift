import SwiftUI

struct MainView: View {
    var body: some View {
        QuizView(viewModel: DIContainer.shared.makeQuizViewModel())
            .padding(.horizontal, 30)
    }
}

#Preview {
    MainView()
}
