import SwiftUI

struct EMOMView: View {
    @State private var sets: Int = 8
        @State private var minutes: Int = 1
        @State private var seconds: Int = 30

        var body: some View {
            NavigationView {
                VStack(alignment: .center, spacing: 40) {
                    Text("EMOM")
                        .font(.largeTitle)
                        .foregroundColor(.purple)
                        .padding(.bottom, 20)

                    HStack {
                        VStack {
                            TextField("Sets", value: $sets, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .frame(width: 50, height: 50)
                                .background(Color.purple.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                            Text("Sets")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack {
                            HStack {
                                TextField("Min", value: $minutes, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .frame(width: 50, height: 50)
                                    .background(Color.purple.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .multilineTextAlignment(.center)
                                Text(":")
                                    .foregroundColor(.white)
                                    .font(.title)
                                TextField("Sec", value: $seconds, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .frame(width: 50, height: 50)
                                    .background(Color.purple.opacity(0.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .multilineTextAlignment(.center)
                            }
                            Text("Work")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()

                    NavigationLink(destination: EMOMTimerView(lapTime: minutes * 60 + seconds, totalLaps: sets)) {
                        Text("Start")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    Spacer()
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
        }
}

#Preview {
    EMOMView()
}
