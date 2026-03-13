//
//  RegisterRequest.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//

struct RegisterRequest: Encodable {
    let username: String
    let email: String
    let password: String
    let role: Int = 1
    let description: String = ""
}

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct AuthResponse: Decodable {
    let token: String
    let user: User
}
