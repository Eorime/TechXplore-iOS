import SwiftUI

@Observable
final class QuizViewModel {
    //MARK: Properties
    var currentQuestionIndex = 0
    var quizComplete = false
    var result: TravelerType?
    var answerHistory: [(questionIndex: Int, type: TravelerType)]
    var pendingSelection: TravelerType?
    var currentQuestion: QuizQuestion {
        guard !questions.isEmpty, currentQuestionIndex < questions.count else {
            fatalError("no questions loaded")
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
        self.answerHistory = []
        self.pendingSelection = nil
        self.currentQuestionIndex = 0
        self.quizComplete = false
        self.result = nil
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
