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
    let userId = UserDefaults.standard.string(forKey: "userId")
    let hostId = UserDefaults.standard.string(forKey: "hostId")
    
    var eventPost = EventPost()
    var eventId: String? = nil
    
    var name: String = "Event Name"
    var host: String = "Event Host"
    var location: String = "Event Location"
    var address: String = "Event Address"
    var city: String = "Event City"
    var state: String = " "
    var zipString: String = "Event Zip"
    var type: String = " "
    var details: String = "Insert Event Description And Contact Info Here."
    
    
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
        
        
        if nameField.text?.isEmpty == false {
            name = nameField.text!
        }
        
        if typeField.text?.isEmpty == false {
            type = typeField.text!
        }
        if hostField.text?.isEmpty == false{
            host = hostField.text!
        }
        
        if addressField.text?.isEmpty == false {
            address = addressField.text!
        }
        
        if cityField.text?.isEmpty == false {
            city = cityField.text!
        }
        
        if stateField.text?.isEmpty == false {
            state = stateField.text!
        }
        
        if locationField.text?.isEmpty == false {
            location = locationField.text!
        }
        
        if zipField.text?.isEmpty == false {
            zipString = zipField.text!
        }
        
        editEventDateVC.name = name
        editEventDateVC.host = host
        editEventDateVC.type = type
        editEventDateVC.address = address
        editEventDateVC.city = city
        editEventDateVC.location = location
        editEventDateVC.state = state
        editEventDateVC.zipString = zipString
        editEventDateVC.details = details
        
        self.navigationController?.pushViewController(editEventDateVC, animated: true)
        
        
    }
    
    @IBAction func endButtonTapped(_ sender: Any) {
        
        let editEventDateVC = self.storyboard!.instantiateViewController(withIdentifier: "EditEventDateView") as! EditEventDateViewController
        
        if nameField.text?.isEmpty == false {
        name = nameField.text!
        }
        
        if typeField.text?.isEmpty == false {
        type = typeField.text!
        }
        if hostField.text?.isEmpty == false{
        host = hostField.text!
        }
        
        if addressField.text?.isEmpty == false {
        address = addressField.text!
        }
        
        if cityField.text?.isEmpty == false {
        city = cityField.text!
        }
        
        if stateField.text?.isEmpty == false {
        state = stateField.text!
        }
        
        if locationField.text?.isEmpty == false {
        location = locationField.text!
        }
        
        if zipField.text?.isEmpty == false {
        zipString = zipField.text!
        }
            
        editEventDateVC.name = name
        editEventDateVC.host = host
        editEventDateVC.type = type
        editEventDateVC.address = address
        editEventDateVC.city = city
        editEventDateVC.location = location
        editEventDateVC.state = state
        editEventDateVC.zipString = zipString
        editEventDateVC.details = details
        
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
        
         name = nameField.text!
        type = typeField.text!
        host = hostField.text!
        location = locationField.text!
        address = addressField.text!
        city = cityField.text!
        state = stateField.text!
        zipString = zipField.text!
        
        
        let startTimeInterval = startDate.timeIntervalSince1970
        let endTimeInterval = endDate.timeIntervalSince1970
        
        
        
        eventPost.postEditEvent(name: name, type: type, host: host, userId: self.userId!, hostId: self.hostId!, location: location, address: address, city: city, state: state, zip: Int(zipString)!, startTime: (startTimeInterval * 1000), endTime: (endTimeInterval * 1000), details: details, eventId: eventId!) { result in
            
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
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
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
