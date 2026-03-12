class QuizUseCase {
    private var scores: [TravelerType: Int] = [
        .gourmet: 0, .nightlifer: 0, .lifestyle: 0, .culture: 0
    ]
    
    private var answerHistory: [(questionIndex: Int, type: TravelerType)] = []
    
    func selectAnswer(questionIndex: Int, type: TravelerType) {
        answerHistory.append((questionIndex: questionIndex, type: type))
        scores[type, default: 0] += 1
    }
    
    func goBack() -> TravelerType? {
        guard let last = answerHistory.last else { return nil }
        scores[last.type, default: 0] -= 1
        answerHistory.removeLast()
        return last.type
    }
    
    func getResult() -> TravelerType {
        let ordered: [TravelerType] = [.gourmet, .nightlifer, .lifestyle, .culture]
        let maxScore = scores.values.max() ?? 0
        return ordered.first { scores[$0] == maxScore} ?? .gourmet
    }
    
    func getAnswerHistory() -> [(questionIndex: Int, type: TravelerType)] {
        return answerHistory
    }
}
