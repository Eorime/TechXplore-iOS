import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(Int)
    case unknown
}

final class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "http://20.238.20.172:5000"

    private init() {}
    
    func put<B: Encodable>(endpoint: String, body: B) async throws {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = TokenManager.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try JSONEncoder().encode(body)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.unknown }
        guard (200...299).contains(httpResponse.statusCode) else { throw NetworkError.serverError(httpResponse.statusCode) }
    }
    
    func get<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 120
        if let token = TokenManager.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print("Attaching token: \(token)")

        } else {
            print("No token found")

        }
         
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.unknown }
        guard (200...299).contains(httpResponse.statusCode) else { throw NetworkError.serverError(httpResponse.statusCode) }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func post<T: Decodable, B: Encodable>(endpoint: String, body: B) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = TokenManager.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        if let raw = String(data: data, encoding: .utf8) {
            print("Raw response: \(raw)")
        }
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.unknown }
        guard (200...299).contains(httpResponse.statusCode) else { throw NetworkError.serverError(httpResponse.statusCode) }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
