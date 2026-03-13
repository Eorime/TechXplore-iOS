import SwiftUI

struct PageHeaderView: View {
    let title: String
    let username: String?
    var onWalletTap: (() -> Void)? = nil
    var onBellTap: (() -> Void)? = nil
    var hasUnread: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                if let username {
                    Text(title)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color("AppCyan"))
                    Text(username)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color("AppCyan"))
                } else {
                    Text(title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color("AppCyan"))
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button { onWalletTap?() } label: {
                    Image("wallet")
                        .foregroundStyle(Color("AppCyan"))
                }
                .opacity(onWalletTap != nil ? 1 : 0)
                
                Button { onBellTap?() } label: {
                    ZStack(alignment: .topTrailing) {
                        Image("bell")
                            .foregroundStyle(Color("AppCyan"))
                        if hasUnread {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 8)
                                .offset(x: 2, y: -2)
                        }
                    }
                }
            }
        }
    }
}
