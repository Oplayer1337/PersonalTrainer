//
//  TimerManager.swift
//  trainertest
//
//  Created by Oplayer on 06.06.2024.
//

//import Foundation
//import SwiftUI
//
//class TimerManager: ObservableObject {
//    @Published var currentLap: Int = 1
//    @Published var timeRemaining: Int
//    @Published var timerProgress: Double = 0.0
//    @Published var isTimerRunning: Bool = false
//    @Published var isCompleted: Bool = false
//
//    var totalLaps: Int
//    var lapTime: Int
//    private var timer: Timer?
//
//    init(lapTime: Int, totalLaps: Int) {
//        self.lapTime = lapTime
//        self.totalLaps = totalLaps
//        self.timeRemaining = lapTime
//    }
//
//    func startTimer() {
//        isTimerRunning = true
//        timer?.invalidate() // Invalidate any existing timer
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            if self.timeRemaining > 0 {
//                self.timeRemaining -= 1
//                self.timerProgress = 1.0 - (Double(self.timeRemaining) / Double(self.lapTime))
//            } else {
//                self.nextLap()
//            }
//        }
//    }
//
//    func nextLap() {
//        if currentLap < totalLaps {
//            currentLap += 1
//            timeRemaining = lapTime
//            timerProgress = 0.0
//        } else {
//            timer?.invalidate()
//            timer = nil
//            isCompleted = true
//        }
//    }
//
//    func stopTimer() {
//        timer?.invalidate()
//        isTimerRunning = false
//    }
//
//    func resetTimer() {
//        timer?.invalidate()
//        isTimerRunning = false
//        currentLap = 1
//        timeRemaining = lapTime
//        timerProgress = 0.0
//        isCompleted = false
//    }
//}
