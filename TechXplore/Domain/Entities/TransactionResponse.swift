//
//  TransactionResponse.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


// Features/Transactions/Models/Transaction.swift
import Foundation

struct TransactionResponse: Decodable {
    let items: [Transaction]
    let totalCount: Int
    let page: Int
    let pageSize: Int
    let hasPreviousPage: Bool
    let hasNextPage: Bool
}

struct Transaction: Decodable, Identifiable {
    let id = UUID()
    let senderId: Int
    let receiver: TransactionUser
    let amount: Double
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case senderId, receiver, amount, timestamp
    }
}

struct TransactionUser: Decodable {
    let id: Int
    let username: String
    let email: String
    let role: String
    let persona: TransactionPersona?
    let description: String
}

struct TransactionPersona: Decodable {
    let id: Int
    let name: String
    let description: String
}
