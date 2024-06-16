import SwiftUI

struct TimerSettingsView: View {
    @EnvironmentObject var timerController: TimerController
    @State private var selectedTimerType: TimerType = .tabata
    @State private var laps: Int = 10
    @State private var workTime: Double = 60
    @State private var restTime: Double = 20
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(height: 40)
                Text("SETTINGS")
                    .font(.custom("Khand-Regular", size: 44))
                    .kerning(4)
                
                Form {
                    Section(header: Text("Timer Type")
                                .foregroundColor(.white)
                                .kerning(3)
                                .font(.custom("Khand-Regular", size: 28))) {
                        Picker("Timer Type", selection: $selectedTimerType) {
                            ForEach(TimerType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                                    .tag(type)
                                    .foregroundColor(type.color)
                                    .font(.custom("Khand-Regular", size: 14))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .listRowBackground(Color.black)

                    Section(header: Text("Set Parameters")
                                .foregroundColor(.white)
                                .kerning(3)
                                .font(.custom("Khand-Regular", size: 28))) {
                        if selectedTimerType != .classic {
                            HStack {
                                HStack(spacing: 0) {
                                    Text("")
                                        .font(.custom("Khand-Medium", size: 22))
                                        .foregroundColor(.white)
                                    Text("\(laps)")
                                        .font(.custom("Khand-Bold", size: 22))
                                        .foregroundColor(.white)
                                    Text(" Laps")
                                        .font(.custom("Khand-Medium", size: 22))
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                Stepper("", value: $laps, in: 1...50)
                                    .labelsHidden()
                            }
                            if selectedTimerType == .tabata {
                                HStack {
                                    HStack(spacing: 0) {
                                        Text("Rest: ")
                                            .font(.custom("Khand-Medium", size: 22))
                                            .foregroundColor(.white)
                                        Text("\(Int(restTime))")
                                            .font(.custom("Khand-Bold", size: 22))
                                            .foregroundColor(.white)
                                        Text(" sec.")
                                            .font(.custom("Khand-Medium", size: 22))
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    Stepper("", value: $restTime, in: 10...600, step: 10)
                                        .labelsHidden()
                                }
                            }
                        }
                        HStack {
                            HStack(spacing: 0) {
                                Text("Work: ")
                                    .font(.custom("Khand-Medium", size: 22))
                                    .foregroundColor(.white)
                                Text("\(Int(workTime))")
                                    .font(.custom("Khand-Bold", size: 22))
                                    .foregroundColor(.white)
                                Text(" sec.")
                                    .font(.custom("Khand-Medium", size: 22))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Stepper("", value: $workTime, in: 10...600, step: 10)
                                .labelsHidden()
                        }
                    }
                    .listRowBackground(Color.black)
                }
                .background(Color.black)
                .scrollContentBackground(.hidden)

                Spacer()

                HStack(spacing: 40) {
                    Button(action: {
                        withAnimation{
                            timerController.stopTimer()
                            dismiss()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        withAnimation{
                            timerController.startTimer(timerType: selectedTimerType, laps: laps, workTime: workTime, restTime: restTime)
                            dismiss()
                        }
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(selectedTimerType.color)
                    }
                }
                .padding()
                
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .foregroundColor(.white)
            .colorScheme(.dark)
        }
        .accentColor(.white)
    }
}

extension TimerType {
    var color: Color {
        switch self {
        case .emom:
            return Color.purple
        case .tabata:
            return Color.green
        case .classic:
            return Color.orange
        }
    }
}

#Preview {
    TimerSettingsView()
        .environmentObject(TimerController())
}

