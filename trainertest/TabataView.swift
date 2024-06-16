import SwiftUI

struct TabataView: View {
    var body: some View {
        VStack {
            Text("Tabata Timer Page")
                .font(.title)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}


#Preview {
    TabataView()
}
