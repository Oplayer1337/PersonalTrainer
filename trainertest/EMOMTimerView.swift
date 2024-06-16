//
//  EMOMTimerView.swift
//  trainertest
//
//  Created by Oplayer on 06.06.2024.
//

import SwiftUI
import BackgroundTasks

struct EMOMTimerView: View {
    @State private var currentLap: Int = 1
    @State private var timeRemaining: Int
    @State private var timerProgress: Double = 0.0
    @State private var timer: Timer? = nil
    @State private var isTimerRunning: Bool = false
    @State private var countdown: Int = 5
    @State private var countdownTimer: Timer? = nil
    @State private var isCompleted: Bool = false

    let lapTime: Int
    let totalLaps: Int

    init(lapTime: Int, totalLaps: Int) {
        self.lapTime = lapTime
        self.totalLaps = totalLaps
        self._timeRemaining = State(initialValue: lapTime)
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Add your back action here
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.gray))
                }
                Spacer()
            }
            .padding()

            Text("EMOM")
                .font(.largeTitle)
                .foregroundColor(.purple)
                .padding(.bottom, 20)

            if isCompleted {
                Text("Well Done!")
                    .font(.largeTitle)
                    .foregroundColor(.purple)
                    .padding()
            } else {
                Text("\(currentLap)/\(totalLaps)")
                    .font(.title)
                    .foregroundColor(.white)

                ZStack {
                    Circle()
                        .stroke(Color.purple.opacity(0.2), lineWidth: 10)
                    Circle()
                        .trim(from: 0.0, to: CGFloat(timerProgress))
                        .stroke(Color.purple, lineWidth: 10)
                        .rotationEffect(Angle(degrees: -90))
                        .animation(.linear, value: timerProgress)

                    if isTimerRunning {
                        Text("\(timeString(from: timeRemaining))")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    } else {
                        Button(action: {
                            startCountdown()
                        }) {
                            Image(systemName: "play.fill")
                                .foregroundColor(.purple)
                                .font(.system(size: 50))
                        }
                    }
                }
                .frame(width: 200, height: 200)
                .padding(.vertical, 40)

                Text("WORK")
                    .font(.title)
                    .foregroundColor(.purple)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onDisappear {
            timer?.invalidate()
            countdownTimer?.invalidate()
        }
    }

    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startCountdown() {
        countdownTimer?.invalidate()
        countdown = 5
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.countdown > 0 {
                self.countdown -= 1
                self.timerProgress = 1.0 - (Double(self.countdown) / 5.0)
            } else {
                self.countdownTimer?.invalidate()
                self.isTimerRunning = true
                self.startTimer()
            }
        }
    }

    func startTimer() {
        timer?.invalidate() // Invalidate any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                self.timerProgress = 1.0 - (Double(self.timeRemaining) / Double(self.lapTime))
            } else {
                self.nextLap()
            }
        }
    }

    func nextLap() {
        if currentLap < totalLaps {
            currentLap += 1
            timeRemaining = lapTime
            timerProgress = 0.0
        } else {
            timer?.invalidate()
            timer = nil
            isCompleted = true
        }
    }

    func handleAppRefresh(task: BGAppRefreshTask) {
        // Ensure the timer continues running
        if isTimerRunning {
            startTimer()
        }
        task.setTaskCompleted(success: true)
    }
}

#Preview {
    EMOMTimerView(lapTime: 20, totalLaps: 5)
}
