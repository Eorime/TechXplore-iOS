//
//  SetPersonaRequest.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


// Features/User/Repository/UserRepository.swift
struct SetPersonaRequest: Encodable {
    let personaId: Int
}

protocol UserRepositoryProtocol {
    func setPersona(_ type: TravelerType) async throws
    func getMe() async throws -> UserMe
}

final class UserRepository: UserRepositoryProtocol {
    private let network = NetworkService.shared
    
    func setPersona(_ type: TravelerType) async throws {
        try await network.put(endpoint: "/api/User/Me/Persona", body: SetPersonaRequest(personaId: type.personaId))
    }
    
    func getMe() async throws -> UserMe {
        try await network.get(endpoint: "/api/User/Me")
    }
}
