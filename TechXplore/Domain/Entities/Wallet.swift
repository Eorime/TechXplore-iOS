struct DepositRequest: Encodable {
    let amount: Double
}

struct TransferRequest: Encodable {
    let receiverId: Int
    let amount: Double
}

struct WalletResponse: Decodable {
    let balance: Double
}
