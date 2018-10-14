//
//  FindPodcastsViewController.swift
//  Agave
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import UIKit
import Firebase

class FindPodcastsViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    
//    var searchController: UISearchController!
//    var isSearching = false
    
    var podcasts = [Podcast]()

    override func viewDidLoad() {
        super.viewDidLoad()        
        let db = Firestore.firestore()
        self.navigationItem.title = "Podcasts"

        // prints all podcasts
        print("Podcasts")
        db.collection("podcasts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let podcast = Podcast(document: document){
                        self.podcasts.append(podcast)
                    }
                }
            }
            self.tableView.reloadData()
        }
        
        self.setCustomBack()
        // Goes into specific podcast with ID Sa84Bvanemas8hcQxI6A, finds users
        // Note: should not autogenerate ID, but have specific names for them
        print("Users of This American Life")
        let podcastUsers = db.collection("podcasts").document("Sa84Bvanemas8hcQxI6A").collection("users")
        podcastUsers.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        // prints edwards bookmarks
        let edwardBookmarks = podcastUsers.document("VJUKEVptSyfxFrvnCXKg").collection("bookmarks")
        print("Edward's bookmarks")
        edwardBookmarks.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        
        // add bookmark of 72 seconds to edwards bookmarks for this american life
        var ref: DocumentReference? = nil
        ref = edwardBookmarks.addDocument(data: [
            "time": 72
        ]) {
            err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func showDetailsForPodcast(){
        performSegue(withIdentifier: "showDetails", sender: AnyObject.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SoundViewController{
                destination.podcast = podcasts[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // set back button
    fileprivate func setCustomBack(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Podcasts", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
}
extension FindPodcastsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastTableViewCell", for: indexPath) as? PodcastTableViewCell {
            var data: [Podcast]
            data = podcasts
            cell.nameLabel.text = data[indexPath.row].name
            cell.descriptionLabel.text = data[indexPath.row].description
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetailsForPodcast()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //return height size whichever you want
    }
    

    
}
