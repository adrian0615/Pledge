//
//  EditProfileViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/14/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    
    let userType = UserDefaults.standard.string(forKey: "type")
    let userId = UserDefaults.standard.integer(forKey: "userId")
    
    var organizationPost = OrganizationPost()
    var individualPost = IndividualPost()
    var organization: Organization? = nil
    var individual: Individual? = nil
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var familyNameLabel: UILabel!
    @IBOutlet var familyNameField: UITextField!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var stateField: UITextField!
    @IBOutlet var zipLabel: UILabel!
    @IBOutlet var zipField: UITextField!
    
    
    
    
    
    func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        if userType != "individual" {
            
            if (familyNameField.text?.isEmpty)! || (emailField.text?.isEmpty)! || (addressField.text?.isEmpty)! || (cityField.text?.isEmpty)! || (zipField.text?.isEmpty)! {
                
                displayMyAlertMessage(userMessage: "All fields are required")
                
                return
            }
            
            let name = familyNameField.text
            let email = emailField.text
            let address = addressField.text
            let city = cityField.text
            let state = stateField.text
            let zip = Int(zipField.text!)
            
            organizationPost.postEditProfile(name: name!, address: address!, city: city!, state: state!, zip: zip!, email: email!, userId: userId) { profileResult in
                switch profileResult {
                case let .success(result) :
                    
                    OperationQueue.main.addOperation {
                        self.organization = result
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(self.organization?.name, forKey: "name")
                        UserDefaults.standard.set(self.organization?.address, forKey: "address")
                        UserDefaults.standard.set(self.organization?.city, forKey: "city")
                        UserDefaults.standard.set(self.organization?.state, forKey: "state")
                        UserDefaults.standard.set(self.organization?.zip, forKey: "zip")
                        UserDefaults.standard.synchronize()
                        
                        let myAlert = UIAlertController(title: "Alert", message: "Profile Saved", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { action in
                            
                            
                            
                            
                            
                            let profileVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileView") as! ProfileViewController
                            
                            self.navigationController?.pushViewController(profileVC, animated:
                                true)
                        }
                        
                        myAlert.addAction(okAction)
                        
                        self.present(myAlert, animated: true, completion: nil)
                    }
                case let .failureLogin(badLogin) :
                    self.displayMyAlertMessage(userMessage: "Failed to Edit Profile.  \(badLogin).")
                    
                case let .failure(error) :
                    print("failed to Make Changes: \(error)")
                    self.displayMyAlertMessage(userMessage: "Failed to Make Changes.  Try again.")
                }
                }
        } else {
            if (firstNameField.text?.isEmpty)! || (familyNameField.text?.isEmpty)! || (emailField.text?.isEmpty)!  {
                
                displayMyAlertMessage(userMessage: "All fields are required")
                
                return
            }
            
            
                    let firstName = firstNameField.text
                    let lastName = familyNameField.text
                    let email = emailField.text
                    
                    individualPost.postEditProfile(firstName: firstName!, lastName: lastName!, email: email! , userId: userId) { profileResult in
                        switch profileResult {
                        case let .success(result) :
                            
                            OperationQueue.main.addOperation {
                                self.individual = result
                                UserDefaults.standard.set(email, forKey: "email")
                                UserDefaults.standard.set(self.individual?.firstName, forKey: "firstName")
                                UserDefaults.standard.set(self.individual?.lastName, forKey: "lastName")
                                UserDefaults.standard.synchronize()
                                
                                let myAlert = UIAlertController(title: "Alert", message: "Profile Saved", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: .default) { action in
                                    
                                    
                                    
                                    
                                    
                                    let profileVC = self.storyboard!.instantiateViewController(withIdentifier: "ProfileView") as! ProfileViewController
                                    
                                    self.navigationController?.pushViewController(profileVC, animated:
                                        true)
                                }
                                
                                myAlert.addAction(okAction)
                                
                                self.present(myAlert, animated: true, completion: nil)
                            }
                            
                        case let .failureLogin(badLogin) :
                            self.displayMyAlertMessage(userMessage: "Failed to Make Changes.  \(badLogin).")
                            
                        case let .failure(error) :
                            print("failed edit profile: \(error)")
                            self.displayMyAlertMessage(userMessage: "Failed to Make Changes.  Try again.")
                        }
                        
                    }
                }
            }
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if !isUserLoggedIn {
            let acNoNetwork = UIAlertController(title: "Must Login to View Profile", message: nil, preferredStyle: .alert)
            
            acNoNetwork.addAction(UIAlertAction(title: "OK", style: .default, handler: self.mustLogin))
            
            self.present(acNoNetwork, animated: true)
        }
        
        title = "Edit Profile"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:
            "Save", style: .plain, target: self, action:
            #selector(saveButtonTapped))
        
        
        if userType == "individual" {
            addressLabel.isHidden = true
            addressField.isHidden = true
            cityLabel.isHidden = true
            cityField.isHidden = true
            stateLabel.isHidden = true
            stateField.isHidden = true
            zipLabel.isHidden = true
            zipField.isHidden = true
            
            
            let userFirstName = UserDefaults.standard.string(forKey: "firstName")
            let userLastName = UserDefaults.standard.string(forKey: "lastName")
            let userEmail = UserDefaults.standard.string(forKey: "email")
            
            firstNameField.text = userFirstName
            familyNameField.text = userLastName
            emailField.text = userEmail
            
        } else {
            
            firstNameLabel.isHidden = true
            firstNameField.isHidden = true
            
            let userName = UserDefaults.standard.string(forKey: "name")
            let userEmail = UserDefaults.standard.string(forKey: "email")
            let userAddress = UserDefaults.standard.string(forKey: "address")
            let userCity = UserDefaults.standard.string(forKey: "city")
            let userState = UserDefaults.standard.string(forKey: "state")
            let userZip = UserDefaults.standard.integer(forKey: "zip")
            
            familyNameField.text = userName
            emailField.text = userEmail
            addressField.text = userAddress
            cityField.text = userCity
            stateField.text = userState
            zipField.text = String(userZip)
            
        }
        
    }
    
    func displayMyAlertMessage(userMessage: String) {
        
        OperationQueue.main.addOperation {
            
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            myAlert.addAction(action)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
    }
    
    func mustLogin(action: UIAlertAction!) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated:
            true)
        
        return
    }
    
    
}
