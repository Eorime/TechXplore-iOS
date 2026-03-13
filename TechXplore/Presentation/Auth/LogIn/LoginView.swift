//
//  LoginView.swift
//  TechXplore
//
//  Created by Eorime on 13.03.26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = DIContainer.shared.makeAuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var goToSignup = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image("logo")
                    .frame(width: 60)
                Text("Hello, traveller!")
                    .font(.system(size: 32, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                    .padding(.bottom, 60)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color("AppCyan"))
                    
                    TextField("", text: $email)
                        .autocapitalization(.none)
                        .padding(8)
                        .foregroundStyle(Color("AppCyan"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("AppCyan"), lineWidth: 2)
                        )
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color("AppCyan"))
                    
                    SecureField("", text: $password)
                        .padding(8)
                        .foregroundStyle(Color("AppCyan"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color("AppCyan"), lineWidth: 2)
                        )
                }
                
                HStack {
                    Text("No account?")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color("AppCyan"))
                    Spacer()
                    Button("Sign up") {
                        goToSignup = true
                    }
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                }
                .padding(.horizontal, 3)
                .padding(.bottom, 100)
                CustomButton(title: "Log In", width: .infinity, height: 45, action: {
                    viewModel.login(email: email, password: password)
                }, fontWeight: .semibold)
                
            }
            .padding(.horizontal, 50)
            .padding(.top, -100)
            .navigationDestination(isPresented: $goToSignup) {
                SignupView()
                    .environmentObject(router)
            }
            .onAppear {
                viewModel.onLoginSuccess = { user in
                    router.userDidLogin(user)
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AppRouter())
}
