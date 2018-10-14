//
//  MainTabBarViewController
//  Agave
//
//  Created by Joshua Young on 10/13/18.
//  Copyright © 2018 JBYoung. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let podcastsVC = mainStoryboard.instantiateViewController(withIdentifier: "FindPodcastsViewController")
        
        //set titles
        podcastsVC.tabBarItem.title = "Podcasts"
        
        //set images
        podcastsVC.tabBarItem.image = UIImage(named: "TableImage")
        
        self.viewControllers = [podcastsVC]
        
        self.tabBar.isTranslucent = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
