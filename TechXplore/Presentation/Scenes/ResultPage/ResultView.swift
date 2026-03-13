import SwiftUI

struct ResultView: View {
    let result: TravelerType
    let onFinish: () -> Void
    
    //movida backidan result da davwere
    var body: some View {
        VStack(spacing: 0) {
            Text("Congrats! You are the...")
                .foregroundStyle(Color(result.color))
                .font(.system(size: 24, weight: .regular))
            
            Spacer().frame(height: 65)
            
            Text(result.name)
                .foregroundStyle(Color(result.color))
                .font(.system(size: 32, weight: .semibold))
            
            Spacer().frame(height: 65)
            
            Image(result.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 180)
            
            Spacer().frame(height: 87)
            
            Text(result.text)
                .foregroundStyle(Color(result.color))
                .font(.system(size: 20, weight: .medium))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            Spacer().frame(height: 87)
            
            CustomButton(title: "Finish", width: 117, height: 35, action: onFinish, color: result.color)
        }
        .padding(.top, -100)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
