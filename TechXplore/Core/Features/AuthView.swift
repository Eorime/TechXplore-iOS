//
//  AuthView.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//


import SwiftUI

struct AuthView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login / Signup")
            
            // auth aq, pagebi
            Button("Login (stub)") {
                let mockUser = User(id: "1", email: "test@test.com", persona: nil)
                router.userDidLogin(mockUser)
            }
            Button("Login with persona (stub)") {
                let mockUser = User(id: "2", email: "test@test.com", persona: .gourmet)
                router.userDidLogin(mockUser)
            }
        }
    }
}
