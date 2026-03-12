import Foundation

protocol QuizRepositoryProtocol {
    func getQuestions() -> [QuizQuestion]
}

class QuizRepository: QuizRepositoryProtocol {
    func getQuestions() -> [QuizQuestion] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(QuizData.self, from: data)
        else {
            return []
        }
        return decoded.questions
    }
}
