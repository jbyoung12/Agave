//
//  Player.swift
//  Agave
//
//  Created by Joshua Young on 10/14/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class Player {
    static var app: Player = {
        return Player()
    }()
    var podcastId: String?
    var audioPlayer: AVAudioPlayer?

    private func setupCommandCenter(podcast: Podcast) {
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: "Agave",
            MPMediaItemPropertyPodcastTitle: podcast.name
        ]
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.pause()
            return .success
        }
    }
    
    func prepareSongAndSession(podcast: Podcast) {
        do {
            if let path = Bundle.main.path(forResource: (podcast.documentId), ofType:"mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                podcastId = podcast.documentId
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                    UIApplication.shared.beginReceivingRemoteControlEvents()
                    setupCommandCenter(podcast: podcast)
                }
                catch {
                    print("Can't make audio sesion with error: \(error.localizedDescription)")
                }
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
    }
    
    func play(){
        audioPlayer?.play()
    }
    
    func pause(){
        audioPlayer?.pause()
    }
    
    
    func setAudioTime(percent: Float){
        audioPlayer?.currentTime = (audioPlayer?.duration ?? 0) * Double(percent)
    }
}
