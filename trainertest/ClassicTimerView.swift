import SwiftUI

struct ClassicTimerView: View {
    var body: some View {
        VStack {
            Text("Classic Timer Page")
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ClassicTimerView()
}
