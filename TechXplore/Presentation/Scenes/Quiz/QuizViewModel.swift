import SwiftUI
import Combine

final class QuizViewModel: ObservableObject {
    //MARK: Properties
    @Published var currentQuestionIndex = 0
    @Published var quizComplete = false
    @Published var result: TravelerType?
    @Published var answerHistory: [(questionIndex: Int, type: TravelerType)] = []
    @Published var pendingSelection: TravelerType?
    
    var currentQuestion: QuizQuestion? {
        guard !questions.isEmpty, currentQuestionIndex < questions.count else {
            return nil
        }
        return questions[currentQuestionIndex]
    }
    
    private let useCase: QuizUseCase
    private let repository: QuizRepositoryProtocol
    let questions: [QuizQuestion]
    
    //MARK: Inits
    init(useCase: QuizUseCase, repository: QuizRepositoryProtocol) {
        self.useCase = useCase
        self.repository = repository
        self.questions = repository.getQuestions()
    }
    
    //MARK: Methods
    func goNext() {
        guard let selected = pendingSelection else { return }
        useCase.selectAnswer(questionIndex: currentQuestionIndex, type: selected)
        answerHistory = useCase.getAnswerHistory()
        pendingSelection = nil
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            quizComplete = true
            result = useCase.getResult()
        }
    }
    
    func goBack() {
        guard currentQuestionIndex > 0 else { return }
        useCase.goBack()
        answerHistory = useCase.getAnswerHistory()
        pendingSelection = nil
        currentQuestionIndex -= 1
        quizComplete = false
    }
    
    func selectedType(for questionIndex: Int) -> TravelerType? {
        answerHistory.first { $0.questionIndex == questionIndex }?.type
    }
}
