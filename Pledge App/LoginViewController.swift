//
//  LoginViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/7/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    var individual: Individual? = nil
    var organization: Organization? = nil
    var individualPost = IndividualPost()
    var organizationPost = OrganizationPost()
    
    
    @IBOutlet var individualLabel: UILabel!
    @IBOutlet var organizationLabel: UILabel!
    @IBOutlet var loginToggle: UISwitch!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordFIeld: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        
        if loginToggle.isOn == true {
            
            if (emailField.text?.isEmpty)! || (passwordFIeld.text?.isEmpty)! {
                
                displayMyAlertMessage(userMessage: "All fields are required")
                
                return
            }
            
            let ac = UIAlertController(title: "Logging in as Organization", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler:yesOrganization))
            ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(ac, animated: true)
            
        } else {
            
            if (emailField.text?.isEmpty)! || (passwordFIeld.text?.isEmpty)! {
                
                displayMyAlertMessage(userMessage: "All fields are required")
                
                return
            }
            
            let ac = UIAlertController(title: "Logging in as Individual", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler:yesIndividual))
            ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(ac, animated: true)
            
        }
    }
    
    @IBAction func toggle(_ sender: Any) {
        
        if loginToggle.isOn == true {
            showOrganization()
            
        } else {
            showIndividual()
        }
    }
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        loginToggle.isOn = false
        showIndividual()
        
        title = "Login"
        
        navigationController?.navigationBar.isHidden = true
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func yesOrganization(action: UIAlertAction!) {
        
        let email = emailField.text
        let password = passwordFIeld.text
        
        organizationPost.postLogin(email: email!, password: password!) { loginResult in
            switch loginResult {
            case let .success(result) :
                
                OperationQueue.main.addOperation {
                    
                    self.organization = result
                    
                    UserDefaults.standard.set("organization", forKey: "type")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(self.organization?.userId, forKey: "userId")
                    UserDefaults.standard.set(self.organization?.userId, forKey: "hostId")
                    UserDefaults.standard.set(self.organization?.name, forKey: "name")
                    UserDefaults.standard.set(self.organization?.address, forKey: "address")
                    UserDefaults.standard.set(self.organization?.city, forKey: "city")
                    UserDefaults.standard.set(self.organization?.state, forKey: "state")
                    UserDefaults.standard.set(self.organization?.zip, forKey: "zip")
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    
                    let myAlert = UIAlertController(title: "Login Successful", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { action in
                        
                        
                        let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
                        self.present(homeVC, animated: true, completion: nil)
                    }
                    
                    myAlert.addAction(okAction)
                    
                    self.present(myAlert, animated: true, completion: nil)
                }
                
                
                
            case let .failureLogin(badLogin) :
                
                self.displayMyAlertMessage(userMessage: "Incorrect Login.  \(badLogin).")
                
            case let .failure(error) :
                
                print("failed to Register: \(error)")
                self.displayMyAlertMessage(userMessage: "Failed to Login.  Try again.")
            }
        }
        
    }
    
    func yesIndividual(action: UIAlertAction!) {
        
        let email = emailField.text
        let password = passwordFIeld.text
        
        individualPost.postLogin(email: email!, password: password!) { loginResult in
            switch loginResult {
            case let .success(result) :
                
                OperationQueue.main.addOperation {
                    
                    self.individual = result
                    
                    UserDefaults.standard.set("individual", forKey: "type")
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(self.individual?.userId, forKey: "userId")
                    UserDefaults.standard.set(self.individual?.userId, forKey: "hostId")
                    UserDefaults.standard.set(self.individual?.firstName, forKey: "firstName")
                    UserDefaults.standard.set(self.individual?.lastName, forKey: "lastName")
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.synchronize()
                    
                    let myAlert = UIAlertController(title: "Login Successful", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { action in
                        
                        
                        let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
                        self.present(homeVC, animated: true, completion: nil)
                    }
                    
                    myAlert.addAction(okAction)
                    
                    self.present(myAlert, animated: true, completion: nil)
                }
                
            case let .failureLogin(badLogin) :
                self.displayMyAlertMessage(userMessage: "Incorrect Login.  \(badLogin).")
                
            case let .failure(error) :
                print("failed to Login: \(error)")
                self.displayMyAlertMessage(userMessage: "Failed to Login.  Try again.")
            }
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
    
    func showIndividual() {
        individualLabel.textColor = UIColor.green
        organizationLabel.textColor = UIColor.gray
    }
    
    func showOrganization() {
        individualLabel.textColor = UIColor.gray
        organizationLabel.textColor = UIColor.green
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
