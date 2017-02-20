//
//  PledgeTabBarViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/14/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class PledgeTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor.white
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.selected)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
