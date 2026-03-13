import Foundation

struct Merchant: Decodable, Identifiable {
    let id: Int
    let username: String
    let email: String
    let role: String
    let persona: MerchantPersona
    let description: String
}

struct MerchantPersona: Decodable {
    let id: Int
    let name: String
    let description: String
    
    var travelerType: TravelerType? {
        TravelerType.fromPersonaId(id)
    }
}

struct MerchantPageResponse: Decodable {
    let items: [Merchant]
    let totalCount: Int
    let page: Int
    let pageSize: Int
    let hasPreviousPage: Bool
    let hasNextPage: Bool
}
