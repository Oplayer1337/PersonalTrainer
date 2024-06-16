import Foundation
import UIKit
import Combine
import AVFoundation

class TimerController: ObservableObject {
    static let shared = TimerController()

    @Published var currentTime: Double = 0
    @Published var isRunning: Bool = false
    @Published var isPaused: Bool = false
    @Published var timerType: TimerType = .classic
    @Published var currentLap: Int = 0
    @Published var currentPhase: String = "WORK"
    @Published var laps: Int = 0
    @Published var workTime: Double = 0
    @Published var restTime: Double = 0
    private var timer: AnyCancellable?
    private var startTime: Date?
    private var endTime: Date?

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveTimerState), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadTimerState), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    func startTimer(timerType: TimerType, laps: Int, workTime: Double, restTime: Double = 0) {
        self.timerType = timerType
        self.laps = laps
        self.workTime = workTime
        self.restTime = restTime
        self.currentTime = workTime
        self.isRunning = true
        self.isPaused = false
        self.currentLap = 1
        self.currentPhase = "WORK"
        self.startTime = Date()
        self.endTime = Date().addingTimeInterval(currentTime + 0.3)
        
        tick()
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
        print("Started timer: \(timerType.rawValue), laps: \(laps), workTime: \(workTime), restTime: \(restTime), startTime: \(String(describing: startTime)), endTime: \(String(describing: endTime))")
    }

    func pauseTimer() {
        isPaused.toggle()
        if isPaused {
            timer?.cancel()
        } else {
            endTime = Date().addingTimeInterval(currentTime)
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                .sink { [weak self] _ in
                    self?.tick()
                }
        }
        print("Paused timer: \(isPaused), currentTime: \(currentTime), endTime: \(String(describing: endTime))")
    }

    func stopTimer() {
        timer?.cancel()
        isRunning = false
        isPaused = false
        currentTime = 0
        currentLap = 0
        currentPhase = "WORK"
        startTime = nil
        endTime = nil
        laps = 0
        workTime = 0
        restTime = 0
        
        // Clear saved state
        UserDefaults.standard.removeObject(forKey: "timerState")
            
        print("Stopped timer and cleared state")
    }

    
    private func tick() {
        guard let endTime = endTime else { return }
        currentTime = endTime.timeIntervalSinceNow
        print("Tick: currentTime = \(currentTime), currentPhase = \(currentPhase), currentLap = \(currentLap)")

        if currentTime <= 4 && currentTime > 3 {
            print("Attempting to play sound at \(currentTime) seconds before lap end.")
            AudioController.shared.playSound(named: "alarm", withExtension: "mp3")
        }

        if currentTime <= 0.4 {
            print("Lap ended: currentPhase = \(currentPhase), currentLap = \(currentLap), timerType = \(timerType.rawValue)")
            if currentPhase == "WORK" {
                if timerType == .tabata {
                    currentPhase = "REST"
                    currentTime = restTime
                    self.endTime = Date().addingTimeInterval(restTime)
                } else {
                    currentLap += 1
                    if timerType == .classic || currentLap > laps {
                        stopTimer()
                    } else {
                        currentTime = workTime
                        self.endTime = Date().addingTimeInterval(workTime)
                    }
                }
            } else {
                currentLap += 1
                if currentLap > laps {
                    stopTimer()
                } else {
                    currentPhase = "WORK"
                    currentTime = workTime
                    self.endTime = Date().addingTimeInterval(workTime)
                }
            }
        }
    }

    func performBackgroundFetch(completion: @escaping () -> Void) {
        // Check if sound needs to be played during background fetch
        if isRunning && !isPaused {
            let elapsedTime = Date().timeIntervalSince(startTime ?? Date())
            let remainingTime = (endTime?.timeIntervalSinceNow ?? 0)
            if remainingTime <= 4 && remainingTime > 3 {
                print("Background fetch: Playing sound at \(remainingTime) seconds before lap end.")
                AudioController.shared.playSound(named: "alarm", withExtension: "mp3")
            }
        }
        completion()
    }

    @objc func saveTimerState() {
        guard isRunning else { return }

        let savedData: [String: Any] = [
            "currentTime": currentTime,
            "isRunning": isRunning,
            "isPaused": isPaused,
            "timerType": timerType.rawValue,
            "currentLap": currentLap,
            "currentPhase": currentPhase,
            "startTime": startTime as Any,
            "endTime": endTime as Any,
            "laps": laps,
            "workTime": workTime,
            "restTime": restTime
        ]
        UserDefaults.standard.set(savedData, forKey: "timerState")
        print("Saved timer state: \(savedData)")
    }

    @objc func loadTimerState() {
        guard let savedData = UserDefaults.standard.dictionary(forKey: "timerState") else { return }

        currentTime = savedData["currentTime"] as? Double ?? 0
        isRunning = savedData["isRunning"] as? Bool ?? false
        isPaused = savedData["isPaused"] as? Bool ?? false
        timerType = TimerType(rawValue: savedData["timerType"] as? String ?? "classic") ?? .classic
        currentLap = savedData["currentLap"] as? Int ?? 0
        currentPhase = savedData["currentPhase"] as? String ?? "WORK"
        startTime = savedData["startTime"] as? Date
        endTime = savedData["endTime"] as? Date
        laps = savedData["laps"] as? Int ?? 0
        workTime = savedData["workTime"] as? Double ?? 0
        restTime = savedData["restTime"] as? Double ?? 0

        print("Loaded timer state: \(savedData)")

        if isRunning && !isPaused, let startTime = startTime {
            let elapsedTime = Date().timeIntervalSince(startTime)
            let lapTime = timerType == .tabata ? (workTime + restTime) : workTime
            let totalLapTime = lapTime * Double(max(laps, 1))

            let currentPhaseTime = timerType == .tabata && currentPhase == "REST" ? restTime : workTime

            if elapsedTime > totalLapTime {
                stopTimer()
            } else {
                let elapsedTimeWithinLap = elapsedTime.truncatingRemainder(dividingBy: lapTime)
                currentLap = Int(elapsedTime / lapTime) + 1

                if timerType == .tabata {
                    let workElapsed = elapsedTimeWithinLap < workTime
                    currentPhase = workElapsed ? "WORK" : "REST"
                    currentTime = workElapsed ? (workTime - elapsedTimeWithinLap) : (restTime - (elapsedTimeWithinLap - workTime))
                } else {
                    currentPhase = "WORK"
                    currentTime = currentPhaseTime - elapsedTimeWithinLap
                }
                self.endTime = Date().addingTimeInterval(currentTime)
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    .sink { [weak self] _ in
                        self?.tick()
                    }
            }
        }
    }
}

