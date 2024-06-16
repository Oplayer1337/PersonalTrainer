//
//  AudioController.swift
//  trainertest
//
//  Created by Oplayer on 07.06.2024.
//

import AVFoundation

class AudioController: NSObject, AVAudioPlayerDelegate {
    static let shared = AudioController()
    private var player: AVAudioPlayer?

    private override init() {
        super.init()
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            print("Audio session configured for playback in background")
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }

    func playSound(named soundName: String, withExtension ext: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: ext) else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.play()
            print("Playing sound: \(soundName).\(ext)")
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Finished playing sound: \(flag)")
    }
}




//import AVFoundation
//
//class AudioController: NSObject, AVAudioPlayerDelegate {
//    static let shared = AudioController()
//    private var player: AVAudioPlayer?
//
//    private override init() {
//        super.init()
//        configureAudioSession()
//    }
//
//    private func configureAudioSession() {
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
//            try AVAudioSession.sharedInstance().setActive(true)
//        } catch {
//            print("Failed to set up audio session: \(error.localizedDescription)")
//        }
//    }
//
//    func playSound(named soundName: String, withExtension ext: String) {
//        guard let url = Bundle.main.url(forResource: soundName, withExtension: ext) else { return }
//
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            player?.delegate = self
//            player?.play()
//            print("Playing sound: \(soundName).\(ext)")
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        print("Finished playing sound: \(flag)")
//    }
//}




//import AVFoundation
//
//class AudioController {
//    static let shared = AudioController()
//    private var player: AVAudioPlayer?
//
//    private init() {}
//
//    func playSound(named soundName: String, withExtension ext: String) {
//        guard let url = Bundle.main.url(forResource: soundName, withExtension: ext) else { return }
//
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            player?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//}
