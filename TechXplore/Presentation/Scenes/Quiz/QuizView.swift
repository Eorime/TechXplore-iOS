import SwiftUI

struct QuizView: View {
    @State var viewModel: QuizViewModel
    
    var body: some View {
        VStack(spacing: 65) {
            Text(viewModel.currentQuestion.text)
                .font(.system(size: 28, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 34)
                .foregroundStyle(Color("AppCyan"))
            
            VStack(spacing: 50) {
                HStack() {
                    QuizOptionBlock(
                        option: viewModel.currentQuestion.options[0],
                        isSelected: viewModel.pendingSelection == viewModel.currentQuestion.options[0].type,
                        onTap: { viewModel.pendingSelection = viewModel.currentQuestion.options[0].type }
                    )
                    Spacer()
                    QuizOptionBlock(
                        option: viewModel.currentQuestion.options[1],
                        isSelected: viewModel.pendingSelection == viewModel.currentQuestion.options[1].type,
                        onTap: { viewModel.pendingSelection = viewModel.currentQuestion.options[1].type }
                    )
                }
                HStack() {
                    QuizOptionBlock(
                        option: viewModel.currentQuestion.options[2],
                        isSelected: viewModel.pendingSelection == viewModel.currentQuestion.options[2].type,
                        onTap: { viewModel.pendingSelection = viewModel.currentQuestion.options[2].type }
                    )
                    Spacer()
                    QuizOptionBlock(
                        option: viewModel.currentQuestion.options[3],
                        isSelected: viewModel.pendingSelection == viewModel.currentQuestion.options[3].type,
                        onTap: { viewModel.pendingSelection = viewModel.currentQuestion.options[3].type }
                    )
                }
            }
            .padding(.horizontal, 34)
            
                HStack {
                    if viewModel.currentQuestionIndex > 0 {
                        CustomButton(title: "Back", width: 110, height: 45) {
                              viewModel.goBack()
                          }
                      }
                      Spacer()
                      CustomButton(
                          title: "Next",
                          width: viewModel.currentQuestionIndex == 0 ? 200 : 110,
                          height: 45,
                          action: { viewModel.goNext() },
                          isDisabled: viewModel.pendingSelection == nil
                      )
                }
                .padding(.horizontal, 35)
            
            Text("I'll choose the type")
                .font(.system(size: 18, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 34)
                .foregroundStyle(Color("AppCyan"))
            //es linkia
        }
        .frame(maxWidth: .infinity)
        .offset(y: -80)
    }
}

#Preview {
    let vm = DIContainer.shared.makeQuizViewModel()
    print("Questions loaded: \(vm.questions.count)")
    return QuizView(viewModel: vm)
}
