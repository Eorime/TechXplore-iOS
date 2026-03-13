import SwiftUI

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
    
    var textColor: Color {
        switch self {
           case .gourmet:    return Color("AppDarkGreen")
           case .nightlifer: return Color("AppBlue")
           case .lifestyle:  return Color("AppDarkPurple")
           case .culture:    return Color("AppDarkYellow")
        }
    }
    
    var icon: String {
        switch self {
        case .gourmet:    return "gourmet"
        case .nightlifer: return "nightlife"
        case .lifestyle:  return "lifestyle"
        case .culture:    return "culture"
        }
    }
    
    var name: String {
        switch self {
        case .gourmet:    return "Gourmet"
        case .nightlifer: return "Nightlifer"
        case .lifestyle:  return "Lifestyler"
        case .culture:    return "Culture Seeker"
        }
    }
    
    static func fromPersonaId(_ id: Int) -> TravelerType? {
        switch id {
        case 1: return .nightlifer
        case 2: return .lifestyle
        case 3: return .culture
        case 4: return .gourmet
        default: return nil
        }
    }
    
    var personaId: Int {
        switch self {
        case .nightlifer: return 1
        case .lifestyle:  return 2
        case .culture:    return 3
        case .gourmet:    return 4
        }
    }
    
    var text: String {
        switch self {
        case .nightlifer: return "You love night clubs, bars, and socializing. What's a better way to indulge in local energy?"
        case .lifestyle:  return "You love to pamper yourself on your trips. Isn't that what vacation is all about?"
        case .culture:    return "Museums, theater, landmarks. Travel should be about getting to know cultures."
        case .gourmet:    return "Your trips revolve around food. Markets, restaurants, local spots, that's where it's at!"
        }
    }
    
    var shortText: String {
        switch self {
        case .nightlifer: return "The Nightlifer - you live for the night scene."
        case .lifestyle:  return "The Lifestyler - you love to pamper yourself."
        case .culture:    return "The Culture Seeker - museums, history, landmarks."
        case .gourmet:    return "The Gourmet - your trips revolve around food."
        }
    }
}
