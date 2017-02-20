//
//  CharityViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/11/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class CharityViewController: UIViewController {
    
    
    
    var charity: Charity? = nil
    
    
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var donateButton: UIButton!
    
    
    @IBAction func donate(_ sender: Any) {
        
        let donateVC = self.storyboard!.instantiateViewController(withIdentifier: "DonateView") as! DonateViewController
        
        donateVC.charity = charity
        
        self.navigationController?.pushViewController(donateVC, animated:
            true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Charity"
        
        nameLabel.text = charity?.name
        typeLabel.text = charity?.category
        addressLabel.text = "\(charity!.city), \(charity!.state), \(charity!.zip)"
        
        
        if charity?.accept != 1 {
            donateButton.isHidden = true
        }
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
