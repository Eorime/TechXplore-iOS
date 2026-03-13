//
//  PageHeaderView.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//

import SwiftUI

struct PageHeaderView: View {
    let title: String
    let username: String?
    var onWalletTap: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .center) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.trailing, 10)
            
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
                Button {
                        onWalletTap?()
                    } label: {
                        Image("wallet")
                            .font(.system(size: 20))
                            .foregroundStyle(Color("AppCyan"))
                    }
                
                Button {
                    // notifications action
                } label: {
                    ZStack(alignment: .topTrailing) {
                        Image("bell")
                            .font(.system(size: 20))
                            .foregroundStyle(Color("AppCyan"))
                        Circle()
                            .fill(Color.red)
                            .frame(width: 8, height: 8)
                            .offset(x: 2, y: -2)
                    }
                }
            }
        }
        .padding(.top, 10)
    }
}

#Preview {
    VStack(spacing: 20) {
        PageHeaderView(title: "Welcome back,", username: "Anon")
        PageHeaderView(title: "Transactions", username: nil)
    }
    .padding(20)
}
