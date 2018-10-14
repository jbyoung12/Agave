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

class BookmarkViewController: UIViewController, UITextViewDelegate {
    
    var podcast: Podcast!
    var bookmark: Bookmark!
    weak var bookmarksTable: UITableView!
    @IBOutlet weak var time: UITextView!
    @IBOutlet weak var descriptioner: UITextView!
    var descriptionBlank = true;

    override func viewDidLoad() {
        self.setNeedsStatusBarAppearanceUpdate()

        super.viewDidLoad()
        time.text = self.bookmark?.timeString
        descriptioner.delegate = self
        if self.bookmark?.description != "" {
            descriptionBlank = false;
            descriptioner.text = self.bookmark?.description
        }
        setCustomBack()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        //listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    deinit {
        //stop listening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    fileprivate func setCustomBack(){
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        if (descriptionBlank){
            self.descriptioner.text = ""
        }
    }
    
    // jumps to bookmark
    @IBAction func play(_ sender: Any) {
        if (Player.app.podcastId != podcast?.documentId){
            Player.app.prepareSongAndSession(podcast: podcast!)
        }
        Player.app.audioPlayer?.currentTime = bookmark.time
        Player.app.play()
    }
    
    @IBAction func pause(_ sender: Any) {
        Player.app.pause()
    }
    
    fileprivate func updateDescription() {
        var db: Firestore?
        db = Firestore.firestore()
        let podcastUsers = db?.collection("podcasts").document((podcast?.documentId)!).collection("users")
        let thisBookmark = podcastUsers?.document("VJUKEVptSyfxFrvnCXKg").collection("bookmarks").document(bookmark.documentId!)
        //need to do update
        thisBookmark?.updateData([
            "description": self.descriptioner.text
        ]) {
            err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document updated")
                self.bookmark.description = self.descriptioner.text
                self.bookmarksTable.reloadData()
            }
        }
        
    }

    
    func textViewDidEndEditing(_ textView: UITextView){
        if (self.descriptioner.text != ""){
            descriptionBlank = false;
            self.updateDescription()
        }
    }
    
}
