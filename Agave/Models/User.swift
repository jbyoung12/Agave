//
//  User.swift
//  PushLearn
//
//  Created by Joshua Young on 5/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let name: String
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
        name = (authData.displayName != nil) ? authData.displayName! : ""
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
        self.name = ""
    }
}
