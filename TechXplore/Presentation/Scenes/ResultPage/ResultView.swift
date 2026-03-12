import SwiftUI

struct ResultView: View {
    let result: TravelerType
    let onFinish: () -> Void
    
    var body: some View {
        VStack {
            Image(result.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 180)
            Text(result.rawValue)
            CustomButton(title: "Finish", width: 117, height: 35, action: onFinish)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
