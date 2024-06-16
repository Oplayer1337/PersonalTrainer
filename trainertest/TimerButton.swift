import SwiftUI

struct TimerButton: View {
    let label: String
    let color: Color
    
    var body: some View {
        Text(label)
            .padding()
            .frame(maxWidth: 240, maxHeight: 80)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(24)
            .padding(.horizontal)
//            .font(.caption2)
            .kerning(6)
            .font(.custom("Khand-Medium",size: 52))
    }
}


#Preview {
    TimerButton(label: "EMOM", color: .purple)
}
