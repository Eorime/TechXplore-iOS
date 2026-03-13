import SwiftUI

struct SpecialOffer: Codable, Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let matchReason: String
    let estimatedCost: Int
    
    enum CodingKeys: String, CodingKey {
        case name, address, matchReason, estimatedCost
    }
}
