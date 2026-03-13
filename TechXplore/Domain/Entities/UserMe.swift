struct UserMe: Decodable {
    let id: Int
    let username: String
    let email: String
    let role: String
    let persona: UserMePersona?
    let description: String?
    let wallet: UserWallet?
}

struct UserMePersona: Decodable {
    let id: Int
    let name: String
    let description: String
}

struct UserWallet: Decodable {
    let balance: Double
}
