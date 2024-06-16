//
//  TimerType.swift
//  trainertest
//
//  Created by Oplayer on 07.06.2024.
//

import SwiftUI

enum TimerType: String, CaseIterable {
    case emom = "EMOM"
    case tabata = "TABATA"
    case classic = "CLASSIC"

    var timerColor: Color {
        switch self {
        case .emom:
            return Color.purple
        case .tabata:
            return Color.green
        case .classic:
            return Color.orange
        }
    }

    var darkTimerColor: Color {
        switch self {
        case .emom:
            return Color.purple.opacity(0.7)
        case .tabata:
            return Color.blue.opacity(0.7)
        case .classic:
            return Color.orange.opacity(0.7)
        }
    }
}


