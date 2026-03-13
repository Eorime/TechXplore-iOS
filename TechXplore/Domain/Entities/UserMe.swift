//
//  UserMe.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


// Features/User/Models/UserMe.swift
struct UserMe: Decodable {
    let id: Int
    let username: String
    let email: String
    let role: String
    let persona: UserMePersona?
    let description: String?
}

struct UserMePersona: Decodable {
    let id: Int
    let name: String
    let description: String
}
