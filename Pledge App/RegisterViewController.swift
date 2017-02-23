//
//  RegisterViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/7/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var individual: Individual? = nil
    var organization: Organization? = nil
    var organizationPost = OrganizationPost()
    var individualPost = IndividualPost()
    let states = ["AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KY", "KS", "LA", "LV", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "NE", "ND", "NH", "NJ", "NM", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"]
    
    var state: String = " "
    
    @IBOutlet var individualNameLabel: UILabel!
    
    @IBOutlet var organizationNameLabel: UILabel!
    @IBOutlet var registerSwitch: UISwitch!
    
    
    
    
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var familyNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var statePicker: UIPickerView!
    @IBOutlet var zipField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var passwordTwoField: UITextField!
    
    
    @IBAction func registerToggle(_ sender: Any) {
        
        
        if registerSwitch.isOn == true {
            showOrganization()
            
        } else {
            showIndividual()
            
        }
        
    }
    
    
    
    
    
    
    @IBAction func registerButton(_ sender: Any) {
        
        
        if registerSwitch.isOn == true {
            
            if (familyNameField.text?.isEmpty)! || (emailField.text?.isEmpty)! || (addressField.text?.isEmpty)! || (cityField.text?.isEmpty)! || (zipField.text?.isEmpty)! || (passwordField.text?.isEmpty)! || (passwordTwoField.text?.isEmpty)! {
                
                displayMyAlertMessage(userMessage: "All fields are required")
                
                return
            }
            
            if passwordField.text != passwordTwoField.text {
                
                displayMyAlertMessage(userMessage: "Passwords do not match")
                
                return
            }
            
            let name = familyNameField.text
            let address = addressField.text
            let city = cityField.text
            let zip = zipField.text
            let email = emailField.text
            let password = passwordField.text
            
            if state == " " {
                state = "AK"
            }
            
            self.organizationPost.postRegister(name: name!, address: address!, city: city!, state: self.state, zip: Int(zip!)!, email: email!, password: password!) { registerResult in
                
                switch registerResult {
                    
                case let .success(result) :
                    
                    OperationQueue.main.addOperation {
                        self.organization = result
                        UserDefaults.standard.set("organization", forKey: "type")
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(password, forKey: "userPassword")
                        UserDefaults.standard.set(self.organization?.userId, forKey: "userId")
                        UserDefaults.standard.set(self.organization?.userId, forKey: "hostId")
                        UserDefaults.standard.set(self.organization?.name, forKey: "name")
                        UserDefaults.standard.set(self.organization?.address, forKey: "address")
                        UserDefaults.standard.set(self.organization?.city, forKey: "city")
                        UserDefaults.standard.set(self.organization?.state, forKey: "state")
                        UserDefaults.standard.set(self.organization?.zip, forKey: "zip")
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        
                        let myAlert = UIAlertController(title: "Registration Successful", message: nil, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { action in
                            
                            
                            
                            
                            
                            let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
                            self.present(homeVC, animated: true, completion: nil)
                        }
                        
                        myAlert.addAction(okAction)
                        
                        self.present(myAlert, animated: true, completion: nil)
                    }
                case let .failureLogin(badLogin) :
                    self.displayMyAlertMessage(userMessage: "Failed to Register.  \(badLogin).")
                    
                case let .failure(error) :
                    print("failed to Register: \(error)")
                    self.displayMyAlertMessage(userMessage: "Failed to Register.  Try again.")
                }
            }
            
        } else {
            
            if (firstNameField.text?.isEmpty)! || (familyNameField.text?.isEmpty)! || (emailField.text?.isEmpty)! || (addressField.text?.isEmpty)! || (cityField.text?.isEmpty)! {
                
                displayMyAlertMessage(userMessage: "All fields are required")
                
                return
            }
            
            
            if addressField.text != cityField.text {
                
                displayMyAlertMessage(userMessage: "Passwords do not match")
                
                return
            }
            
            let firstName = firstNameField.text
            let lastName = familyNameField.text
            let email = emailField.text
            let password = addressField.text
            
            individualPost.postRegister(firstName: firstName!, lastName: lastName!, email: email!, password: password!) { registerResult in
                
                switch registerResult {
                    
                case let .success(result) :
                    
                    OperationQueue.main.addOperation {
                        self.individual = result
                        
                        UserDefaults.standard.set("Individual", forKey: "type")
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(password, forKey: "userPassword")
                        UserDefaults.standard.set(self.individual?.userId, forKey: "userId")
                        UserDefaults.standard.set(self.individual?.userId, forKey: "hostId")
                        UserDefaults.standard.set(self.individual?.firstName, forKey: "firstName")
                        UserDefaults.standard.set(self.individual?.lastName, forKey: "lastName")
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        
                        let myAlert = UIAlertController(title: "Registration Successful", message: nil, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default) { action in
                            
                            
                            
                            
                            
                            let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
                            self.present(homeVC, animated: true, completion: nil)
                        }
                        
                        myAlert.addAction(okAction)
                        
                        self.present(myAlert, animated: true, completion: nil)
                    }
                    
                case let .failureLogin(badLogin) :
                    self.displayMyAlertMessage(userMessage: "Failed to Register.  \(badLogin).")
                    
                case let .failure(error) :
                    print("failed to Register: \(error)")
                    self.displayMyAlertMessage(userMessage: "Failed to Register.  Try again.")
                }
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    // Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        state = states[row]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        
        statePicker.delegate = self
        statePicker.dataSource = self
        
        title = "Register"
        
        registerSwitch.isOn = false
        
        showIndividual()
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    func showIndividual() {
        individualNameLabel.isHighlighted = true
        individualNameLabel.textColor = UIColor.green
        organizationNameLabel.isHighlighted = false
        organizationNameLabel.textColor = UIColor.gray
        firstNameField.isHidden = false
        firstNameField.isHidden = false
        familyNameField.placeholder = "Last Name"
        addressField.placeholder = "Password"
        cityField.placeholder = "Confirm Password"
        statePicker.isHidden = true
        zipField.isHidden = true
        passwordField.isHidden = true
        passwordTwoField.isHidden = true
        addressField.isSecureTextEntry = true
        cityField.isSecureTextEntry = true
        
    }
    
    func showOrganization() {
        individualNameLabel.isHighlighted = false
        individualNameLabel.textColor = UIColor.gray
        organizationNameLabel.isHighlighted = true
        organizationNameLabel.textColor = UIColor.green
        firstNameField.isHidden = true
        firstNameField.isHidden = true
        familyNameField.placeholder = "Company"
        addressField.placeholder = "Address"
        cityField.placeholder = "City"
        statePicker.isHidden = false
        zipField.isHidden = false
        passwordField.isHidden = false
        passwordTwoField.isHidden = false
        passwordField.isSecureTextEntry = true
        passwordTwoField.isSecureTextEntry = true
        addressField.isSecureTextEntry = false
        cityField.isSecureTextEntry = false
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
