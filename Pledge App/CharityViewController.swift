//
//  CharityViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/11/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class CharityViewController: UIViewController {
    
    var individualPost = IndividualPost()
    var organizationPost = OrganizationPost()
    var individual: Individual? = nil
    var organization: Organization? = nil
    
    var charity: Charity? = nil
    
    
    var loggedIn: Bool = false
    

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    
    
    @IBAction func donate(_ sender: Any) {
        
        let donateVC = self.storyboard!.instantiateViewController(withIdentifier: "DonateView") as! DonateViewController
        
        donateVC.charity = charity
        
        self.navigationController?.pushViewController(donateVC, animated:
            true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pledge"
        
        nameLabel.text = charity?.name
        typeLabel.text = charity?.category
        addressLabel.text = "\(charity!.city), \(charity!.state), \(charity!.zip)"
        detailsLabel.text = charity?.description

        // Do any additional setup after loading the view.
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
