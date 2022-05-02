//
//  File.swift
//  Bezier Curves - WWDC22
//
//  Created by Subhronil Saha on 23/04/22.
//

import Foundation
import AVKit

public class AudioManager: ObservableObject {
    var player : AVAudioPlayer?
    @Published var isMusicPlaying : Bool = false
    
    func startPlayer() {
        guard let url = Bundle.main.url(forResource: "bg-music-lofi", withExtension: "mp3") else {
            print("Can't find music URL")
            return
        }
        do {
            player = try? AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
            isMusicPlaying = true
            
        } catch {
            print("Error playing music")
        }
    }
    
    func stopPlayer() {
        player?.stop()
        isMusicPlaying = false
    }
    
    func toggleMusicPlayer() {
        if isMusicPlaying {
            stopPlayer()
        } else {
            startPlayer()
        }
    }
}
