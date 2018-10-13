//
//  LoginViewController.swift
//  Agave
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarViewController: UITabBarController {
    
    var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myPushLearnsVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavController")
        let plazaVC = mainStoryboard.instantiateViewController(withIdentifier: "PlazaNavController")
        let accountVC = mainStoryboard.instantiateViewController(withIdentifier: "AccountNavigationViewController")
        
        //set titles
        myPushLearnsVC.tabBarItem.title = "My PushLearns"
        plazaVC.tabBarItem.title = "Plaza"
        accountVC.tabBarItem.title = "Account"
        
        //set images
        myPushLearnsVC.tabBarItem.image = UIImage(named: "PushLearnImage")
        plazaVC.tabBarItem.image = UIImage(named: "shopping_cart")
        accountVC.tabBarItem.image = UIImage(named: "contact_card")
        
        self.viewControllers = [myPushLearnsVC, plazaVC, accountVC]
        
        self.tabBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
