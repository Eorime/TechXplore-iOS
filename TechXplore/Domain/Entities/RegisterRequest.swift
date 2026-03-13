struct RegisterRequest: Encodable {
    let username: String
    let email: String
    let password: String
    let role: Int = 1
}

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct AuthResponse: Decodable {
    let token: String
}
