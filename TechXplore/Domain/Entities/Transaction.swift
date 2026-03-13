// Features/Transactions/Models/TransactionItem.swift
import Foundation

struct TransactionItem: Decodable, Identifiable {
    let id = UUID()
    let senderId: Int
    let receiver: TransactionReceiver
    let amount: Double
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case senderId, receiver, amount, timestamp
    }
    
    var date: Date? {
        ISO8601DateFormatter().date(from: timestamp)
    }
    
    var formattedDate: String {
        guard let date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

struct TransactionReceiver: Decodable {
    let id: Int
    let username: String
    let email: String
    let role: String
    let persona: ReceiverPersona?
    let description: String
}

struct ReceiverPersona: Decodable {
    let id: Int
    let name: String
    let description: String
    
    var travelerType: TravelerType? {
        TravelerType.fromPersonaId(id)
    }
}
