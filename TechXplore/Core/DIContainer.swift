final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    func makeQuizViewModel() -> QuizViewModel {
        QuizViewModel(
            useCase: QuizUseCase(),
            repository: QuizRepository()
        )
    }
}
