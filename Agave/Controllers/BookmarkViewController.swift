//
//  BookmarkViewController.swift
//  Agave
//
//  Created by Joshua Young on 10/14/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Firebase

class BookmarkViewController: UIViewController {
    
    var podcast: Podcast?
    var bookmark: Bookmark!
    @IBOutlet weak var time: UITextView!
    @IBOutlet weak var descriptioner: UITextView!
    @IBOutlet weak var bookmarksTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        time.text = self.bookmark?.timeString
        descriptioner.text = self.bookmark?.description
        self.prepareSongAndSession()
    }
    
    
    var audioPlayer: AVAudioPlayer?
    
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
        audioPlayer?.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        audioPlayer?.pause()
    }
    
    @IBAction func updateDescription(_ sender: Any) {
        var db: Firestore?
        db = Firestore.firestore()
        let podcastUsers = db?.collection("podcasts").document((podcast?.documentId)!).collection("users")
        let thisBookmark = podcastUsers?.document("VJUKEVptSyfxFrvnCXKg").collection("bookmarks").document(bookmark.documentId!)
        var ref: DocumentReference? = nil
        //need to do update
//        ref = edwardBookmarks?.addDocument(data: [
//            "time": time!,
//            "description": ""
//        ]) {
//            err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//                self.bookmarks.append(Bookmark(time: time!, description: "", documentId: ref!.documentID))
//                self.bookmarksTable.reloadData()
//            }
//        }
        
    }

    
    //    @IBAction func jumpToBookmark(_ sender: Any, TimeInterval bookmark) {
    //        songPlayer.play(bookmark)
    //    }
    
}
