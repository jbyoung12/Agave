//
//  Bookmark.swift
//  Agave
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import Foundation
import Firebase

struct Bookmark {
    
    let documentId: String?
    let time: TimeInterval
    var description: String
    let timeString: String!
    
    init(time: TimeInterval, description: String, documentId: String) {
        self.time = time
        self.description = description
        self.documentId = documentId
        self.timeString = Bookmark.stringFromTimeInterval(timeInterval: time)
    }
    
    init?(document: DocumentSnapshot) {
        guard
            let time = document.data()["time"] as? TimeInterval,
            let description = document.data()["description"] as? String
            else {
                return nil
        }
        self.init(
            time: time,
            description: description,
            documentId: document.documentID
        )
    }
    
    static func stringFromTimeInterval (timeInterval: TimeInterval) -> String {
        let endingDate = Date()
        let startingDate = endingDate.addingTimeInterval(-timeInterval)
        let calendar = Calendar.current
        
        var componentsNow = calendar.dateComponents([.hour, .minute, .second], from: startingDate, to: endingDate)
        if let hour = componentsNow.hour, var minute = componentsNow.minute, let seconds = componentsNow.second {
            minute += hour*60;
            return "\(minute):\(seconds)"
            
        } else {
            return "00:00:00"
        }
    }
    
}
