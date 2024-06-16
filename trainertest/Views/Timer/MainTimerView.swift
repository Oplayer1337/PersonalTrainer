import SwiftUI

struct MainTimerView: View {
    @EnvironmentObject var timerController: TimerController
    @State private var showSettings: Bool = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                ZStack {
                    Text("TIMER")
                        .font(.custom("Khand-SemiBold", size: 48))
                        .kerning(4)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showSettings.toggle()
                        }) {
                            Image(systemName: "gearshape")
                                .font(.largeTitle)
                                .padding()
                        }
                        .sheet(isPresented: $showSettings) {
                            TimerSettingsView()
                                .environmentObject(timerController)
                        }
                    }
                }
            }
            .padding(.top, 16)
//            Rectangle()
//                .frame(width: 393, height: 2)
            Spacer()
            if timerController.isRunning || timerController.isPaused {
                TimerView(timerType: timerController.timerType,
                          laps: timerController.laps,
                          workTime: timerController.workTime,
                          restTime: timerController.restTime)
            } else {
//                Text("    SET UP\nYOUR TIMER")
//                    .font(.custom("Khand-Light", size: 48))
//                    .foregroundColor(.white)
//                    .kerning(6)
                Button(action: {
                    showSettings.toggle()
                }) {
                    Text("SET UP\nYOUR TIMER")
                                        .font(.custom("Khand-Light", size: 48))
                                        .foregroundColor(.white)
                                        .kerning(6)
                }
                .sheet(isPresented: $showSettings) {
                    TimerSettingsView()
                        .environmentObject(timerController)
                }
            }
            Spacer()
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight:4)
                .frame(alignment: .bottom)
                .foregroundColor(.white)
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight:16)
                .frame(alignment: .bottom)
                .foregroundColor(.black)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            timerController.loadTimerState()
        }
        .onDisappear {
            timerController.saveTimerState()
        }
    }
}

#Preview {
    MainTimerView()
        .environmentObject(TimerController())
}
