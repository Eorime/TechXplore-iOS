struct User: Decodable {
    let id: String
    let email: String
    let username: String
    var persona: TravelerType?
}
