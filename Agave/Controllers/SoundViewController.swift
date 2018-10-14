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
import Firebase

class SoundViewController: UIViewController {
    
    var podcast: Podcast?
    var db: Firestore?
    var bookmarks = [Bookmark]()
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var descriptioner: UITextView!
    @IBOutlet weak var bookmarksTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = self.podcast?.name
        descriptioner.text = self.podcast?.description
        self.prepareSongAndSession()
        db = Firestore.firestore()
        self.getBookmarks()
        bookmarksTable.delegate = self
        bookmarksTable.dataSource = self
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
    
    @IBAction func addBookmark(_ sender: Any) {
        let time = audioPlayer?.currentTime
        // find user ID, Podcast ID, add to bookmarks collection
        // add bookmark of 72 seconds to edwards bookmarks for this american life
        let podcastUsers = db?.collection("podcasts").document((podcast?.documentId)!).collection("users")
        let edwardBookmarks = podcastUsers?.document("VJUKEVptSyfxFrvnCXKg").collection("bookmarks")
        var ref: DocumentReference? = nil
        ref = edwardBookmarks?.addDocument(data: [
            "time": time!,
            "description": ""
        ]) {
            err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.bookmarks.append(Bookmark(time: time!, description: "", documentId: ref!.documentID))
                self.bookmarksTable.reloadData()
            }
        }
 
    }
    
    fileprivate func getBookmarks(){
        // prints edwards bookmarks
        let podcastUsers = db?.collection("podcasts").document((podcast?.documentId)!).collection("users")
        let edwardBookmarks = podcastUsers?.document("VJUKEVptSyfxFrvnCXKg").collection("bookmarks")
        
        edwardBookmarks?.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
            for document in querySnapshot!.documents {
                print(document.data())
                if let bookmark = Bookmark(document: document){
                    self.bookmarks.append(bookmark)
                }
            }
        }
            self.bookmarksTable.reloadData()
    }
    }
    
    func showDetailsForBookmark(){
        performSegue(withIdentifier: "showBookmark", sender: AnyObject.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookmarkViewController{
            destination.podcast = podcast
            destination.bookmark = bookmarks[(bookmarksTable.indexPathForSelectedRow?.row)!]
        }
    }
    
//    @IBAction func jumpToBookmark(_ sender: Any, TimeInterval bookmark) {
//        songPlayer.play(bookmark)
//    }
    
}

extension SoundViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastTableViewCell", for: indexPath) as? PodcastTableViewCell {
            var data: [Bookmark]
            data = bookmarks
            cell.nameLabel.text = data[indexPath.row].timeString
            cell.descriptionLabel.text = data[indexPath.row].description
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.showDetailsForPodcast()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //return height size whichever you want
    }
}

