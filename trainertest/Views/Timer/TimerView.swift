import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timerController: TimerController
    var timerType: TimerType
    var laps: Int
    var workTime: Double
    var restTime: Double
    @State private var countdown: Int = 5
    @State private var isCountdownActive: Bool = false

    var body: some View {
        VStack {
            Text(timerType.rawValue)
                .font(.custom("Khand-SemiBold", size: 42))
                .kerning(4)
                .foregroundColor(timerType.timerColor)
                .padding(.top, 20)
            
            if timerType != .classic {
                Text("\(timerController.currentLap)/\(laps)")
                    .font(.custom("Khand-Medium", size: 38))
                    .kerning(3)
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
            ZStack {
                if timerType == .tabata && timerController.currentPhase == "REST" {
                    Circle()
                        .trim(from: 0.0, to: CGFloat(timerController.currentTime / restTime))
                        .stroke(timerType.darkTimerColor, lineWidth: 10)
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))
                } else {
                    Circle()
                        .trim(from: 0.0, to: CGFloat(timerController.currentTime / workTime))
                        .stroke(timerType.timerColor, lineWidth: 10)
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))
                }
                if !timerController.isRunning && !isCountdownActive {
                    Button(action: {
                        isCountdownActive = true
                        startCountdown()
                    }) {
                        Image(systemName: "arrowtriangle.right.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .background(timerType.timerColor)
                            .clipShape(Circle())
                    }
                } else if isCountdownActive {
                    Text("\(countdown)")
                        .font(.custom("Khand-Light", size: 36))
                        .kerning(4)
                        .foregroundColor(.white)
                } else {
                    Text(timerController.isPaused ? "| |" : "\(timerController.currentTime.formattedTime)")
                        .font(.custom("Khand-Light", size: 36))
                        .kerning(4)
                        .foregroundColor(.white)
                        .onTapGesture {
                            timerController.pauseTimer()
                        }
                }
            }
            
            if timerController.isRunning {
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: 10, height: 40)
                Text(timerController.currentPhase)
                    .font(.custom("Khand-Bold", size: 42))
                    .foregroundColor(timerType == .tabata && timerController.currentPhase == "REST" ? timerType.darkTimerColor : timerType.timerColor)
                    .padding(.top, 20)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }

    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                timerController.startTimer(timerType: timerType, laps: laps, workTime: workTime, restTime: restTime)
                isCountdownActive = false
            }
        }
    }
}

extension Double {
    var formattedTime: String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TimerView(timerType: .tabata, laps: 10, workTime: 60, restTime: 20)
                .environmentObject(TimerController())
                .background(Color.black)
}
