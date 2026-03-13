//
//  TravelerType.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//
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
}
