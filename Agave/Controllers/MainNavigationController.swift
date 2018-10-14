//
//  MainNavigationController.swift
//  Agave
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import UIKit
import Firebase
//import FacebookLogin

class MainNavigationController: UINavigationController {

    let mainStoryBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var identifier: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func showLoginController() {
        let loginVC = LoginViewController()
        self.present(loginVC, animated: false, completion: {
            return
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isNavigationBarHidden = true
        let mainTabBarViewController = MainTabBarViewController()
        self.pushViewController(mainTabBarViewController, animated: false)

    }
    
    override func viewDidDisappear(_ animated: Bool) {

    }

}
