//
//  LoginViewController.swift
//  Agave
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Outlets
    
    override func viewDidLoad() {
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
//
//        if let accessToken = AccessToken.current {
//            // User is logged in, use 'accessToken' here.
//        }
    }
    
    
    
}

