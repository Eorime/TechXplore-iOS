import SwiftUI

struct TransactionRow: View {
    let item: TransactionItem
    var isLast: Bool = false
    
    var travelerType: TravelerType? {
        item.receiver.persona?.travelerType
    }
    
    var body: some View {
        HStack(spacing: 12) {
            if let type = travelerType {
                Image(type.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                    .padding(.trailing, 8)
            } else {
                Circle()
                    .fill(Color("AppCyan").opacity(0.15))
                    .frame(width: 36, height: 36)
                    .padding(.trailing, 8)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.receiver.username)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color("AppBlack"))
                if let type = travelerType {
                    Text(type.name)
                        .font(.system(size: 9, weight: .regular))
                        .foregroundStyle(Color("AppBlack").opacity(0.6))
                }
            }
            
            Spacer()
            
            Text("-\(Int(item.amount))$")
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color("AppBlack"))
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        
        if !isLast {
            Divider()
                .background(Color("AppCyan").opacity(0.3))
        }
    }
}
