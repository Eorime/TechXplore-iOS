import SwiftUI

struct QuizView: View {
    @EnvironmentObject var router: AppRouter
    @ObservedObject var viewModel: QuizViewModel
    @State private var showPersonaPicker = false

    var body: some View {
        if let question = viewModel.currentQuestion {
            VStack(spacing: 60) {
                Text(question.text)
                    .font(.system(size: 28, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 34)
                    .foregroundStyle(Color("AppCyan"))
                
                VStack(spacing: 50) {
                    HStack(spacing: 30) {
                        QuizOptionBlock(
                            option: question.options[0],
                            isSelected: viewModel.pendingSelection == question.options[0].type,
                            onTap: { viewModel.pendingSelection = question.options[0].type }
                        )
                        QuizOptionBlock(
                            option: question.options[1],
                            isSelected: viewModel.pendingSelection == question.options[1].type,
                            onTap: { viewModel.pendingSelection = question.options[1].type }
                        )
                    }
                    HStack(spacing: 30) {
                        QuizOptionBlock(
                            option: question.options[2],
                            isSelected: viewModel.pendingSelection == question.options[2].type,
                            onTap: { viewModel.pendingSelection = question.options[2].type }
                        )
                        QuizOptionBlock(
                            option: question.options[3],
                            isSelected: viewModel.pendingSelection == question.options[3].type,
                            onTap: { viewModel.pendingSelection = question.options[3].type }
                        )
                    }
                }
                .padding(.horizontal, 34)
                
                HStack {
                    if viewModel.currentQuestionIndex > 0 {
                           CustomButton(title: "Back", width: 110, height: 45) {
                               viewModel.goBack()
                           }
                           Spacer()
                           CustomButton(
                               title: "Next",
                               width: 110,
                               height: 45,
                               action: { viewModel.goNext() },
                               isDisabled: viewModel.pendingSelection == nil
                           )
                       } else {
                           CustomButton(
                               title: "Next",
                               width: .infinity,
                               height: 45,
                               action: { viewModel.goNext() },
                               isDisabled: viewModel.pendingSelection == nil
                           )
                           .frame(maxWidth: .infinity)
                       }
                }
                .padding(.horizontal, 35)
                
                Text("I'll choose the type")
                    .font(.system(size: 18, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 34)
                    .foregroundStyle(Color("AppCyan"))
                    .onTapGesture {
                        showPersonaPicker = true
                    }
                    .sheet(isPresented: $showPersonaPicker) {
                        PersonaPickerView()
                            .environmentObject(router)
                    }
                //es linkia
            }
            .frame(maxWidth: .infinity)
            .offset(y: -40)
        }
    }
}
