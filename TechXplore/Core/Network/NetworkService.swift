import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(Int)
    case unknown
}

final class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://baseurl.com"
    
    private init() {}
    
    func post<T: Decodable, B: Encodable>(endpoint: String, body: B) async throws -> T {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
