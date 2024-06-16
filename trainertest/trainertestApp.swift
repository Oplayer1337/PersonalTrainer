//
//  trainertestApp.swift
//  trainertest
//
//  Created by Oplayer on 28.05.2024.
//

//com.oplayer.trainertest.refresh

import SwiftUI
import BackgroundTasks

@main
struct trainertestApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var timerController = TimerController()

    init() {
        registerBackgroundTask()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
                .environmentObject(appState)
                .environmentObject(timerController)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                    timerController.saveTimerState()
                    scheduleBackgroundTask()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    timerController.loadTimerState()
                }
        }
    }

    private func registerBackgroundTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "oplayer.trainertest.refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }

    private func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleBackgroundTask()
        TimerController.shared.performBackgroundFetch {
            task.setTaskCompleted(success: true)
        }
    }

    private func scheduleBackgroundTask() {
        let request = BGAppRefreshTaskRequest(identifier: "oplayer.trainertest.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15 minutes from now
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Scheduled background task")
        } catch {
            print("Could not schedule background task: \(error)")
        }
    }
}







//import SwiftUI
//import BackgroundTasks
//
//@main
//struct trainertestApp: App {
//    @StateObject private var appState = AppState()
//    @StateObject private var timerController = TimerController()
//
//    init() {
//        registerBackgroundTask()
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.black)
//                .edgesIgnoringSafeArea(.all)
//                .environmentObject(appState)
//                .environmentObject(timerController)
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
//                    scheduleBackgroundTask()
//                }
//        }
//    }
//
//    private func registerBackgroundTask() {
//        print("Registering background task")
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "oplayer.trainertest.refresh", using: nil) { task in
//            print("Handling background task")
//            self.handleBackgroundTask(task: task as! BGAppRefreshTask)
//        }
//    }
//
//    private func handleBackgroundTask(task: BGAppRefreshTask) {
//        print("Handling background task: \(task.identifier)")
//        scheduleBackgroundTask()
//        // Perform the necessary operations for the background task
//        task.setTaskCompleted(success: true)
//    }
//
//    private func scheduleBackgroundTask() {
//        let request = BGAppRefreshTaskRequest(identifier: "oplayer.trainertest.refresh")
//        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15 minutes from now
//        do {
//            try BGTaskScheduler.shared.submit(request)
//            print("Scheduled background task")
//        } catch {
//            print("Could not schedule app refresh: \(error)")
//        }
//    }
//}
//





//import SwiftUI
//import BackgroundTasks
//
//@main
//struct trainertestApp: App {
//    @StateObject private var appState = AppState()
//    @StateObject private var timerController = TimerController()
//
//    init() {
//        registerBackgroundTask()
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.black)
//                .edgesIgnoringSafeArea(.all)
//                .environmentObject(appState)
//                .environmentObject(timerController)
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
//                    scheduleBackgroundTask()
//                    timerController.saveTimerState()
//                }
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
//                    timerController.loadTimerState()
//                }
//        }
//    }
//
//    private func registerBackgroundTask() {
//        print("Registering background task")
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "oplayer.trainertest.refresh", using: nil) { task in
//            print("Handling background task")
//            self.handleBackgroundTask(task: task as! BGAppRefreshTask)
//        }
//    }
//
//    private func handleBackgroundTask(task: BGAppRefreshTask) {
//        print("Handling background task: \(task.identifier)")
//        scheduleBackgroundTask()
//        // Perform the necessary operations for the background task
//        task.setTaskCompleted(success: true)
//    }
//
//    private func scheduleBackgroundTask() {
//        let request = BGAppRefreshTaskRequest(identifier: "oplayer.trainertest.refresh")
//        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15 minutes from now
//        do {
//            try BGTaskScheduler.shared.submit(request)
//            print("Scheduled background task")
//        } catch {
//            print("Could not schedule app refresh: \(error)")
//        }
//    }
//}



//import SwiftUI
//import BackgroundTasks
//
//@main
//struct trainertestApp: App {
//    @StateObject private var appState = AppState()
//    
//    init() {
//        registerBackgroundTask()
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            RootView()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color.black)
//                .edgesIgnoringSafeArea(.all)
//                .environmentObject(appState)
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
//                    scheduleBackgroundTask()
//                }
//        }
//    }
//    
//    private func registerBackgroundTask() {
//        print("Registering background task")
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "oplayer.trainertest.refresh", using: nil) { task in
//            print("Handling background task")
//            self.handleBackgroundTask(task: task as! BGAppRefreshTask)
//        }
//    }
//
//    private func handleBackgroundTask(task: BGAppRefreshTask) {
//        print("Handling background task: \(task.identifier)")
//        scheduleBackgroundTask()
//        // Perform the necessary operations for the background task
//        task.setTaskCompleted(success: true)
//    }
//
//    private func scheduleBackgroundTask() {
//        let request = BGAppRefreshTaskRequest(identifier: "oplayer.trainertest.refresh")
//        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15 minutes from now
//        do {
//            try BGTaskScheduler.shared.submit(request)
//            print("Scheduled background task")
//        } catch {
//            print("Could not schedule app refresh: \(error)")
//        }
//    }
//}




