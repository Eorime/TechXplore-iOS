final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    func makeQuizViewModel() -> QuizViewModel {
        QuizViewModel(
            useCase: QuizUseCase(),
            repository: QuizRepository()
        )
    }
    
    func makeAuthViewModel() -> AuthViewModel {
        AuthViewModel(useCase: AuthUseCase(repository: AuthRepository()))
    }
    
    func makeTransactionsViewModel() -> TransactionsViewModel {
        TransactionsViewModel(useCase: TransactionUseCase(repository: TransactionRepository()))
    }
    
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(recommendationUseCase: RecommendationUseCase(repository: RecommendationRepository()))
    }
    
    func makeMerchantsViewModel() -> MerchantsViewModel {
        MerchantsViewModel(repository: MerchantRepository())
    }
    
    func makeWalletViewModel() -> WalletViewModel {
        WalletViewModel(repository: WalletRepository())
    }
}
