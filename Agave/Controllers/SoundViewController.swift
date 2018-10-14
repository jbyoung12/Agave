//
//  SoundViewController.swift
//  Agave
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//
import UIKit
import Foundation
import AVFoundation

class SoundViewController: UIViewController {
    
    var podcast: Podcast?
    
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var descriptioner: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = self.podcast?.name
        descriptioner.text = self.podcast?.description
    }
    
    
    var audioPlayer = AVAudioPlayer()
    
    // call in viewDidLoad()
    func prepareSongAndSession() {

        do {
            if let path = Bundle.main.path(forResource: (podcast?.documentId), ofType:"mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        
    }
    
    
    @IBAction func play(_ sender: Any) {
        audioPlayer.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        audioPlayer.pause()
    }
    
//    @IBAction func addBookmark(_ sender: Any) {
//        let time = audioPlayer.currentTime
//        // find user ID, Podcast ID, add to bookmarks collection
//
//    }
    
//    @IBAction func jumpToBookmark(_ sender: Any, TimeInterval bookmark) {
//        songPlayer.play(bookmark)
//    }
    
}




