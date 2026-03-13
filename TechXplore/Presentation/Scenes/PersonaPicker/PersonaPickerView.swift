import SwiftUI

struct PersonaPickerView: View {
    @EnvironmentObject var router: AppRouter
    @State private var isLoading = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Who are you?")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(Color("AppCyan"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 34)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(TravelerType.allCases, id: \.self) { type in
                    Button {
                        selectPersona(type)
                    } label: {
                        VStack(spacing: 12) {
                            Image(type.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 90)
                            Text(type.name)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(type.textColor)
                            Text(type.text)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundStyle(type.textColor.opacity(0.7))
                                .multilineTextAlignment(.leading)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .padding(.top, 40)
        .overlay {
            if isLoading {
                Color.black.opacity(0.2).ignoresSafeArea()
                ProgressView().tint(Color("AppCyan"))
            }
        }
    }
    
    private func selectPersona(_ type: TravelerType) {
        isLoading = true
        UserDefaults.standard.removeObject(forKey: "savedOffers")
        Task {
            try? await UserRepository().setPersona(type)
            await MainActor.run {
                isLoading = false
                router.currentUser?.persona = type
                dismiss()
            }
        }
    }
}
