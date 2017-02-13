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
    let individualPost = IndividualPost()
    let organizationPost = OrganizationPost()
    
    var loggedIn: Bool = false
    
    @IBOutlet var individualLabel: UILabel!
    @IBOutlet var organizationLabel: UILabel!
    @IBOutlet var loginToggle: UISwitch!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordFIeld: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        
        if loginToggle.isOn == true {
            
            organizationPost.postLogin(email: emailField.text!, password: passwordFIeld.text!) { loginResult in
             switch loginResult {
             case let .success(result) :
             self.organization = result
             
             self.loggedIn = true
             
             case let .failure(error) :
             print("failed to Login: \(error)")
             }
             }
            
            
            
            
            let eventsVC = self.storyboard!.instantiateViewController(withIdentifier: "EventsView") as! EventsTableViewController
            let eventVC = self.storyboard!.instantiateViewController(withIdentifier: "EventView") as! EventViewController
            
            
            
        } else {
            individualPost.postLogin(email: emailField.text!, password: passwordFIeld.text!) { loginResult in
             switch loginResult {
             case let .success(result) :
                
                self.individual = result
                self.loggedIn = true
                
             
             case let .failure(error) :
             print("failed to Login: \(error)")
             }
             }
            
            
        
        
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
