//
//  SpecialOffer.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//
import SwiftUI

// Features/Home/Models/SpecialOffer.swift
struct SpecialOffer: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let matchReason: String
    
    enum CodingKeys: String, CodingKey {
        case name, address, matchReason
    }
}
