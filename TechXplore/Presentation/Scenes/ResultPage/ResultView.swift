import SwiftUI

struct ResultView: View {
    let result: TravelerType
    let onFinish: () -> Void
    
    //movida backidan result da davwere
    var body: some View {
        VStack {
            Text("Congrats! You are the...")
                .foregroundStyle(Color(result.color))
            Text(result.name)
                .foregroundStyle(Color(result.color))
            
            Image(result.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 180)
            CustomButton(title: "Finish", width: 117, height: 35, action: onFinish, color: result.color)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
