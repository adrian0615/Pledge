//
//  RegisterViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/7/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var individual: Individual? = nil
    var organization: Organization? = nil
    let organizationPost = OrganizationPost()
    let individualPost = IndividualPost()
    
    var loggedIn: Bool = false
    
    
    
    @IBOutlet var individualNameLabel: UILabel!
    
    @IBOutlet var organizationNameLabel: UILabel!
    @IBOutlet var registerSwitch: UISwitch!
    
    //Need password Fields to be equal
    //Want User to be able to choose from a list of states
    //Integers only in Zip Code Field
    //family Name Label toggles as company and last Name
    //addressLabel toggles as address and password
    //city Label toggles as city and confirmation password
    //textFields need to be clear when things are toggled
    //way to hide password
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var familyNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    @IBOutlet var passwordOneLabel: UILabel!
    @IBOutlet var passwordTwoLabel: UILabel!
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var familyNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var stateField: UITextField!
    @IBOutlet var zipField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var passwordTwoField: UITextField!
    
    
    @IBAction func registerToggle(_ sender: Any) {
        
        
        if registerSwitch.isOn == true {
            showOrganization()
            loggedIn = true
        } else {
            showIndividual()
            loggedIn = true
        }
        
    }
    
    
    
    
    
    
    @IBAction func registerButton(_ sender: Any) {
        if registerSwitch.isOn == true {
            
            self.organizationPost.postRegister(name: familyNameField.text!, address: addressField.text!, city: cityField.text!, state: stateField.text!, zip: Int(zipField.text!)!, email: emailField.text!, password: passwordField.text!) { registerResult in
             switch registerResult {
             case let .success(result) :
             self.organization = result
             
             case let .failure(error) :
             print("failed to Register: \(error)")
             }
             }
        } else {
            individualPost.postRegister(firstName: firstNameField.text!, lastName: familyNameField.text!, email: emailField.text!, password: addressField.text!) { registerResult in
             switch registerResult {
             case let .success(result) :
             self.individual = result
             
             case let .failure(error) :
             print("failed to Register: \(error)")
             }
             }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameField.delegate = self
        familyNameField.delegate = self
        emailField.delegate = self
        addressField.delegate = self
        cityField.delegate = self
        stateField.delegate = self
        zipField.delegate = self
        passwordField.delegate = self
        passwordTwoField.delegate = self
        
        
        title = "Register"
        
        registerSwitch.isOn = false
        
        showIndividual()
        
        //hide addressField text for password
        //hide cityField text for password
        
    }
    
    func showIndividual() {
        individualNameLabel.isHighlighted = true
        individualNameLabel.textColor = UIColor.green
        organizationNameLabel.isHighlighted = false
        organizationNameLabel.textColor = UIColor.gray
        firstNameLabel.isHidden = false
        firstNameField.isHidden = false
        familyNameLabel.text = "Last Name:"
        addressLabel.text = "Password:"
        cityLabel.text = "Confirm Password:"
        stateLabel.isHidden = true
        stateField.isHidden = true
        zipLabel.isHidden = true
        zipField.isHidden = true
        passwordOneLabel.isHidden = true
        passwordField.isHidden = true
        passwordTwoLabel.isHidden = true
        passwordTwoField.isHidden = true
        addressField.isSecureTextEntry = true
        cityField.isSecureTextEntry = true
        
    }
    
    func showOrganization() {
        individualNameLabel.isHighlighted = false
        individualNameLabel.textColor = UIColor.gray
        organizationNameLabel.isHighlighted = true
        organizationNameLabel.textColor = UIColor.green
        firstNameLabel.isHidden = true
        firstNameField.isHidden = true
        familyNameLabel.text = "Company:"
        addressLabel.text = "Address:"
        cityLabel.text = "City:"
        stateLabel.isHidden = false
        stateField.isHidden = false
        zipLabel.isHidden = false
        zipField.isHidden = false
        passwordOneLabel.isHidden = false
        passwordField.isHidden = false
        passwordTwoLabel.isHidden = false
        passwordTwoField.isHidden = false
        passwordField.isSecureTextEntry = true
        passwordTwoField.isSecureTextEntry = true
        addressField.isSecureTextEntry = false
        cityField.isSecureTextEntry = false

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
