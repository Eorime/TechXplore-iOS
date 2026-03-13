import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    var isLast: Bool = false
    
    var travelerType: TravelerType? {
        guard let persona = transaction.receiver.persona else { return nil }
        return TravelerType(rawValue: persona.name.lowercased())
    }
    
    var body: some View {
        HStack(spacing: 12) {
            if let type = travelerType {
                Image(type.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
            } else {
                Circle()
                    .fill(Color("AppCyan").opacity(0.2))
                    .frame(width: 36, height: 36)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.receiver.username)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color("AppBlack"))
                if let persona = transaction.receiver.persona {
                    Text(persona.name)
                        .font(.system(size: 9, weight: .regular))
                        .foregroundStyle(Color("AppBlack").opacity(0.6))
                }
            }
            
            Spacer()
            
            Text("-\(Int(transaction.amount))€")
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color("AppBlack"))
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 4)
        
        if !isLast {
            Divider()
                .background(Color("AppCyan").opacity(0.3))
        }
    }
}
