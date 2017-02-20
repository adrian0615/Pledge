//
//  EditEventViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController{
    
    let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    let userId = UserDefaults.standard.integer(forKey: "userId")
    let hostId = UserDefaults.standard.integer(forKey: "hostId")
    
    var eventPost = EventPost()
    var eventId: Int? = nil
    
    
    var details: String = " "
    
    var type: String = " "
    var state: String = " "
    
    var startDate = Date()
    var endDate = Date()
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var hostField: UITextField!
    @IBOutlet var locationField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var stateField: UITextField!
    @IBOutlet var zipField: UITextField!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var endButton: UIButton!
    
    @IBAction func startButtonTapped(_ sender: Any) {
        let editEventDateVC = self.storyboard!.instantiateViewController(withIdentifier: "EditEventDateView") as! EditEventDateViewController
        
        self.navigationController?.pushViewController(editEventDateVC, animated: true)
        
        
    }
    
    @IBAction func endButtonTapped(_ sender: Any) {
        
        let editEventDateVC = self.storyboard!.instantiateViewController(withIdentifier: "EditEventDateView") as! EditEventDateViewController
        
        self.navigationController?.pushViewController(editEventDateVC, animated: true)
        
        
    }
    
    @IBAction func descriptionButtonTapped(_ sender: Any) {
        
        let editEventDescriptionVC = self.storyboard!.instantiateViewController(withIdentifier: "EditEventDescriptionView") as! EditEventDescriptionViewController
        
        self.navigationController?.pushViewController(editEventDescriptionVC, animated:
            true)
    }
    
    func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        if (nameField.text?.isEmpty)! || (hostField.text?.isEmpty)! || (locationField.text?.isEmpty)! || (addressField.text?.isEmpty)! || (cityField.text?.isEmpty)! || (zipField.text?.isEmpty)! {
            
            displayMyAlertMessage(userMessage: "All fields are required")
            
            return
        }
        
        let name = nameField.text
        let host = hostField.text
        let location = locationField.text
        let address = addressField.text
        let city = cityField.text
        let zip = Int(zipField.text!)
        
        let startDateString = startButton.titleLabel?.text
        let endDateString = endButton.titleLabel?.text
        
        let startDateFormatter = DateFormatter()
        let endDateFormatter = DateFormatter()
        
        startDateFormatter.dateFormat = "yyyy-MM-dd HH:MM"
        endDateFormatter.dateFormat = "yyyy-MM-dd HH:MM"
        
        let startDate = startDateFormatter.date(from: startDateString!)
        let endDate = endDateFormatter.date(from: endDateString!)
        
        let startTimeInterval = startDate?.timeIntervalSince1970
        let endTimeInterval = endDate?.timeIntervalSince1970
        
        
        ///Needs to be edit event
        eventPost.postEditEvent(name: name!, type: self.type, host: host!, userId: self.userId, hostId: self.hostId, location: location!, address: address!, city: city!, state: self.state, zip: zip!, startTime: startTimeInterval!, endTime: endTimeInterval!, details: details, eventId: eventId!) { result in
            
            switch result {
            case let .success(array) :
                OperationQueue.main.addOperation {
                    print(array)
                    
                    
                    let myAlert = UIAlertController(title: "Success", message: "Event Edited", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { action in
                        
                        
                        let myEventsVC = self.storyboard!.instantiateViewController(withIdentifier: "MyEventsView") as! EventsTableViewController
                        
                        myEventsVC.events = array
                        
                        self.navigationController?.pushViewController(myEventsVC, animated:
                            true)
                    }
                    
                    myAlert.addAction(okAction)
                    
                    self.present(myAlert, animated: true, completion: nil)
                }
                
                
            case let .failureLogin(error) :
                print("Failed to Save Event \(error)")
                
                self.displayMyAlertMessage(userMessage: "Unable to Save Changes.  Try Again.")
                
                
            case let .failure(error) :
                print("Failed to Save Event \(error)")
                
                self.displayMyAlertMessage(userMessage: "Unable to Save Changes.  Try Again.")
                
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit Event"
        
        if !isUserLoggedIn {
            let acNoNetwork = UIAlertController(title: "Must Login to Edit Event", message: nil, preferredStyle: .alert)
            
            acNoNetwork.addAction(UIAlertAction(title: "OK", style: .default, handler: self.mustLogin))
            
            self.present(acNoNetwork, animated: true)
        }
        
        if isUserLoggedIn {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title:
                "Save", style: .plain, target: self, action:
                #selector(saveButtonTapped))
        }
        
        let startFormatter = DateFormatter()
        let endFormatter = DateFormatter()
        
        
        startFormatter.dateStyle = .medium
        startFormatter.timeStyle = .short
        endFormatter.dateStyle = .medium
        endFormatter.timeStyle = .short
        
        
        startButton.setTitle("\(startFormatter.string(from: startDate))", for: .normal)
        endButton.setTitle("\(endFormatter.string(from: endDate))", for: .normal)
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func mustLogin(action: UIAlertAction!) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated:
            true)
        
        return
    }
    
    
}
