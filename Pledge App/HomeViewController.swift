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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Timer.scheduledTimer(timeInterval: 6.1, target: self, selector: #selector(self.someSelector), userInfo: nil, repeats: false)
        // Do any additional setup after loading the view.
    }
    
    func someSelector() {
        
        let pledgeVC = self.storyboard!.instantiateViewController(withIdentifier: "PledgeTabBarView") as! PledgeTabBarViewController
        
        self.present(pledgeVC, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

