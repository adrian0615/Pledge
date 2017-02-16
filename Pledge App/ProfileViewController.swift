//
//  ProfileViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/14/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    
    let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var familyNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    
    func logoutButtonTapped(_ sender: UIBarButtonItem) {
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        
        let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        self.present(homeVC, animated: true, completion: nil)
        
        
    }
    
    func editButtonTapped(_ sender: UIBarButtonItem) {
        
        
        let editProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "EditProfileView") as! EditProfileViewController
        
        
        self.navigationController?.pushViewController(editProfileVC, animated:
            true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        
        if !isUserLoggedIn {
            let acNoNetwork = UIAlertController(title: "Must Login to View Profile", message: nil, preferredStyle: .alert)
            
            acNoNetwork.addAction(UIAlertAction(title: "OK", style: .default, handler: self.mustLogin))
            
            self.present(acNoNetwork, animated: true)
            
        }
        
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title:
                "Edit", style: .plain, target: self, action:
                #selector(editButtonTapped))
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title:
                "Logout", style: .plain, target: self, action:
                #selector(logoutButtonTapped))
        
        let userType = UserDefaults.standard.string(forKey: "type")
        
        
        
        
        if userType == "individual" {
            addressLabel.isHidden = true
            cityLabel.isHidden = true
            stateLabel.isHidden = true
            zipLabel.isHidden = true
            
        
            let userFirstName = UserDefaults.standard.string(forKey: "firstName")
            let userLastName = UserDefaults.standard.string(forKey: "lastName")
            let userEmail = UserDefaults.standard.string(forKey: "email")
            
            firstNameLabel.text = userFirstName
            familyNameLabel.text = userLastName
            emailLabel.text = userEmail
        } else {
            firstNameLabel.isHidden = true
    
            let userName = UserDefaults.standard.string(forKey: "name")
            let userEmail = UserDefaults.standard.string(forKey: "email")
            let userAddress = UserDefaults.standard.string(forKey: "address")
            let userCity = UserDefaults.standard.string(forKey: "city")
            let userState = UserDefaults.standard.string(forKey: "state")
            let userZip = UserDefaults.standard.integer(forKey: "zip")
            
            familyNameLabel.text = userName
            emailLabel.text = userEmail
            addressLabel.text = userAddress
            cityLabel.text = userCity
            stateLabel.text = userState
            zipLabel.text = String(userZip)
            
            }
        
        
            
        }

        // Do any additional setup after loading the view.
    
    func mustLogin(action: UIAlertAction!) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated:
            true)
        
        return
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
