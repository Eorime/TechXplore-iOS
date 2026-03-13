import SwiftUI

struct QuizData: Codable {
    let questions: [QuizQuestion]
}

struct QuizQuestion: Codable {
    let id: Int
    let text: String
    let options: [QuizOption]
    
    enum CodingKeys: String, CodingKey {
        case id
        case text = "question"
        case options
    }
}
