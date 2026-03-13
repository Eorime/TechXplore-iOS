//
//  TokenManager.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


// Core/Auth/TokenManager.swift
final class TokenManager {
    static let shared = TokenManager()
    private init() {}
    
    var token: String?
}
