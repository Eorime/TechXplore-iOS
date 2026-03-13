import SwiftUI

struct AuthView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        LoginView()
            .environmentObject(router)
    }
}
