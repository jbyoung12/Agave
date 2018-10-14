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
import MediaPlayer

class SoundViewController: UIViewController {
    
    var podcast: Podcast?
    var db: Firestore?
    var bookmarks = [Bookmark]()
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var descriptioner: UITextView!
    @IBOutlet weak var bookmarksTable: UITableView!
    @IBOutlet weak var timeSlider: UISlider!
    
    override func viewWillAppear(_ animated: Bool) {
        db = Firestore.firestore()
        self.getBookmarks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = self.podcast?.name
        descriptioner.text = self.podcast?.description
        bookmarksTable.delegate = self
        bookmarksTable.dataSource = self
        setCustomBack()
        timeSlider.setValue(0, animated: false)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    fileprivate func setCustomBack(){
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @IBAction func play(_ sender: Any) {
        if (Player.app.podcastId != podcast?.documentId){
            Player.app.prepareSongAndSession(podcast: podcast!)
        }
        Player.app.play()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        Player.app.pause()
    }
    
    @IBAction func addBookmark(_ sender: Any) {
        let time = Player.app.audioPlayer?.currentTime
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
                self.bookmarks.sort(by: { (Bookmark1, Bookmark2) -> Bool in
                    return Bookmark1.time < Bookmark2.time
                })
                self.bookmarksTable.reloadData()
            }
        }
 
    }
    
    fileprivate func getBookmarks(){
        // prints edwards bookmarks
        bookmarks = []
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
            self.bookmarks.sort(by: { (Bookmark1, Bookmark2) -> Bool in
                return Bookmark1.time < Bookmark2.time
            })
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
            destination.bookmarksTable = bookmarksTable
        }
    }
    @IBAction func sliderChanged(_ sender: UISlider) {
        Player.app.setAudioTime(percent: sender.value);
    }
    @objc func updateSlider(){
        let percent = Double((Player.app.audioPlayer?.currentTime)!) / Double( (Player.app.audioPlayer?.duration)!)
        timeSlider.setValue(Float(percent), animated: true)
    }
    
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
        self.showDetailsForBookmark()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //return height size whichever you want
    }
    
    
}

