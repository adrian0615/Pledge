//
//  HomeViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet var pledgeLogoImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(timeInterval: 4.1, target: self, selector: #selector(self.logo), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }
    
    func logo() {
        pledgeLogoImage.image = UIImage(named: "pledge-logo")
        _ = Timer.scheduledTimer(timeInterval: 5.1, target: self, selector: #selector(self.someSelector), userInfo: nil, repeats: false)
    }
    

    
    func someSelector() {
        
        let pledgeVC = self.storyboard!.instantiateViewController(withIdentifier: "tabBarController") as! PledgeTabBarViewController
        
        self.present(pledgeVC, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

