//  Podcast.swift
//  Podcast
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import Foundation
import Firebase

struct Podcast {
    
    let documentId: String?
    let name: String
    let description: String
    var episodes = [Episode]()
    
//    init?(dict: Dictionary) {
//        guard
//            let title = dict["title"] as? String,
//            let description = dict["description"] as? String
//            else {
//                return nil
//        }
//        self.title = title
//        self.description = description
//    }
//
    init(name: String, description: String, documentId: String) {
            self.name = name
            self.description = description
            self.documentId = documentId
    }
    
    init?(document: DocumentSnapshot) {
        guard
            let name = document.data()["name"] as? String,
            let description = document.data()["description"] as? String
            else {
                return nil
            }
        self.init(
            name: name,
            description: description,
            documentId: document.documentID
        )
    }
//
//    init?(snapshot: DocumentSnapshot) {
//        guard
//            let value = snapshot. as? [String: AnyObject],
//            let title = value["title"] as? String,
//            let description = value["description"] as? String
//            else {
//                return nil
//        }
//        self.ref = snapshot.ref
//        self.title = title
//        self.description = description
//    }
//
//    
//    func toDict() -> Any {
//        return [
//            "title": title,
//            "description": description
//        ]
//    }
}
