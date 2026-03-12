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

enum TravelerType: String, Codable, CaseIterable {
    case gourmet, nightlifer, lifestyle, culture
    
    var color: Color {
        switch self {
           case .gourmet:    return Color("AppGreen")
           case .nightlifer: return Color("AppBlue")
           case .lifestyle:  return Color("AppPurple")
           case .culture:    return Color("AppYellow")
        }
    }
}
