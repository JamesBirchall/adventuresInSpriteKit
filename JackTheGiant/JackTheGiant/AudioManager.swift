//
//  AudioManager.swift
//  JackTheGiant
//
//  Created by James Birchall on 28/04/2017.
//  Copyright © 2017 James Birchall. All rights reserved.
//

import AVFoundation

class AudioManager {
    static let sharedInstance = AudioManager()  // allows 1 instance only of the class object
    private init(){}    // stops other classes being made from this class
    
    private var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3")
        
        if url != nil {
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: url!)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Problem initialising AVAudioPlayer: \(error).")
            }
        } else {
            print("Background Music Not Found in Bundle resources.")
        }
    }
    
    func stopBackgroundMusic() {
        if audioPlayer != nil {
            if (audioPlayer?.isPlaying)! {
                audioPlayer?.stop()
            }
        }
    }
    
    func isPlaying() -> Bool {
        return (audioPlayer?.isPlaying)!
    }
}
