import SwiftUI

struct SignupView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = DIContainer.shared.makeAuthViewModel()
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 35) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Username")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                TextField("", text: $username)
                    .autocapitalization(.none)
                    .foregroundStyle(Color("AppCyan"))
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("AppCyan"), lineWidth: 2))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                TextField("", text: $email)
                    .autocapitalization(.none)
                    .padding(10)
                    .foregroundStyle(Color("AppCyan"))
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("AppCyan"), lineWidth: 2))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                SecureField("", text: $password)
                    .padding(10)
                    .foregroundStyle(Color("AppCyan"))
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("AppCyan"), lineWidth: 2))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm Password")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color("AppCyan"))
                SecureField("", text: $confirmPassword)
                    .padding(10)
                    .foregroundStyle(Color("AppCyan"))
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color("AppCyan"), lineWidth: 2))
            }
            
            if let error = viewModel.errorMessage {
                Text(error).foregroundStyle(.red).font(.caption)
            }
            
            CustomButton(title: "Sign Up", width: .infinity, height: 47, action: {
                if let error = viewModel.validate(username: username, email: email, password: password, confirmPassword: confirmPassword) {
                    viewModel.errorMessage = error
                    return
                }
                viewModel.register(username: username, email: email, password: password)
            }, fontWeight: .semibold)
            
            Spacer()
        }
        .padding(50)
        .padding(.top, -20)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Create account")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(Color("AppCyan"))
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color("AppCyan"))
                }
            }
        }
            .onAppear {
                viewModel.onRegisterSuccess = {
                    dismiss()
            }
        }
    }
}
