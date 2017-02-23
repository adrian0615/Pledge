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
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for:.normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.yellow], for:.selected)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        
        leftSwipe.direction = .left
        
        
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        
        rightSwipe.direction = .right
        
        
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        var selectedIndex: Int = self.selectedIndex {
            didSet {
                if selectedIndex >= self.viewControllers!.count {
                    selectedIndex %= self.viewControllers!.count
                }
                while selectedIndex < 0 {
                    selectedIndex += self.viewControllers!.count
                }
            }
        }
        if (sender.direction == .left) {
            self.selectedIndex = selectedIndex + 1
        }
        
        if (sender.direction == .right) {
            self.selectedIndex = selectedIndex - 1
        }
    }
}
