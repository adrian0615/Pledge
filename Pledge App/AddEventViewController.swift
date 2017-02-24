
//
//  AddEventViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/12/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    let userId = UserDefaults.standard.string(forKey: "userId")
    let hostId = UserDefaults.standard.string(forKey: "hostId")
    
    var eventPost = EventPost()
    
    let states = ["GA", "AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KY", "KS", "LA", "LV", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "NE", "ND", "NH", "NJ", "NM", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"]
    
    let types = ["Event Type", "Arts & Culture", "Activism", "Animal Rights", "Civil Rights", "Community Improvement", "Disaster Relief", "Disability Assistance", "Education", "Elderly Assistance", "Environmental", "Feeding the Less Fortunate", "Housing & Shelter", "Human Rights", "Human Services", "Mental Health", "Public Health", "Public Safety", "Transportation", "Youth Development"]
    
    
    var name: String = "Event Name"
    var host: String = "Event Host"
    var location: String = "Event Location"
    var address: String = "Event Address"
    var city: String = "Event City"
    var state: String = " "
    var zipString: String = "Event Zip"
    var type: String = " "
    var details: String = "Insert Event Description And Contact Info Here."
    
    let startFormatter = DateFormatter()
    let endFormatter = DateFormatter()
    
    var startDate = Date()
    var endDate = Date()
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typePicker: UIPickerView!
    @IBOutlet var hostField: UITextField!
    @IBOutlet var locationField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var statePicker: UIPickerView!
    @IBOutlet var zipField: UITextField!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var endButton: UIButton!
    
    @IBAction func startButtonTapped(_ sender: Any) {
        let eventDateVC = self.storyboard!.instantiateViewController(withIdentifier: "EventDateView") as! EventDateViewController
        
        if nameField.text?.isEmpty == false {
            name = nameField.text!
        }
        
        if hostField.text?.isEmpty == false {
            host = hostField.text!
        }
        
        if addressField.text?.isEmpty == false {
            address = addressField.text!
        }
        
        if cityField.text?.isEmpty == false {
            city = cityField.text!
        }
        
        if locationField.text?.isEmpty == false {
            location = locationField.text!
        }
        
        if zipField.text?.isEmpty == false {
            zipString = zipField.text!
        }
        
        eventDateVC.name = name
        eventDateVC.host = host
        eventDateVC.type = type
        eventDateVC.address = address
        eventDateVC.city = city
        eventDateVC.location = location
        eventDateVC.state = state
        eventDateVC.zipString = zipString
        eventDateVC.details = details
        
        self.navigationController?.pushViewController(eventDateVC, animated:
            true)
    }
    
    @IBAction func endButtonTapped(_ sender: Any) {
        
        let eventDateVC = self.storyboard!.instantiateViewController(withIdentifier: "EventDateView") as! EventDateViewController
        
        if nameField.text?.isEmpty == false {
            name = nameField.text!
        }
        
        if hostField.text?.isEmpty == false {
            host = hostField.text!
        }
        
        if addressField.text?.isEmpty == false {
            address = addressField.text!
        }
        
        if cityField.text?.isEmpty == false {
            city = cityField.text!
        }
        
        if locationField.text?.isEmpty == false {
            location = locationField.text!
        }
        
        if zipField.text?.isEmpty == false {
            zipString = zipField.text!
        }
        
        eventDateVC.name = name
        eventDateVC.host = host
        eventDateVC.type = type
        eventDateVC.address = address
        eventDateVC.city = city
        eventDateVC.location = location
        eventDateVC.state = state
        eventDateVC.zipString = zipString
        eventDateVC.details = details
        
        self.navigationController?.pushViewController(eventDateVC, animated:
            true)
    }
    
    @IBAction func descriptionButtonTapped(_ sender: Any) {
        
        let eventDescriptionVC = self.storyboard!.instantiateViewController(withIdentifier: "EventDescriptionView") as! EventDescriptionViewController
        
        name = nameField.text!
        host = hostField.text!
        address = addressField.text!
        city = cityField.text!
        location = locationField.text!
        zipString = zipField.text!
        
        eventDescriptionVC.name = name
        eventDescriptionVC.host = host
        eventDescriptionVC.type = type
        eventDescriptionVC.address = address
        eventDescriptionVC.city = city
        eventDescriptionVC.location = location
        eventDescriptionVC.state = state
        eventDescriptionVC.zipString = zipString
        eventDescriptionVC.details = details
        
        eventDescriptionVC.startDate = startDate
        eventDescriptionVC.endDate = endDate
        
        self.navigationController?.pushViewController(eventDescriptionVC, animated:
            true)
    }
    
    func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        if (nameField.text?.isEmpty)! || (hostField.text?.isEmpty)! || (locationField.text?.isEmpty)! || (addressField.text?.isEmpty)! || (cityField.text?.isEmpty)! || (zipField.text?.isEmpty)! {
            
            displayMyAlertMessage(userMessage: "All fields are required")
            
            return
        }
        
        //displayMyAlertMessage(userMessage: "Set Event Type and State")
        
        name = nameField.text!
        host = hostField.text!
        location = locationField.text!
        address = addressField.text!
        city = cityField.text!
        zipString = zipField.text!
        
        
        print("startDate: \(startDate)")
        print("endDate: \(endDate)")
        
        let startTimeInterval = startDate.timeIntervalSince1970
        let endTimeInterval = endDate.timeIntervalSince1970
        
        if self.state == " " {
            state = "GA"
        }
        
        if self.type == " " {
            type = "Non-Profit"
        }
        
        
        eventPost.postCreateEvent(name: name, type: self.type, host: host, userId: self.userId!, hostId: self.hostId!, location: location, address: address, city: city, state: self.state, zip: Int(zipString)!, startTime: (startTimeInterval * 1000), endTime: (endTimeInterval * 1000), details: details) { result in
            
            switch result {
            case let .success(array) :
                OperationQueue.main.addOperation {
                    print(array)
                    
                    
                    let myAlert = UIAlertController(title: "Success", message: "Event Created", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { action in
                        
                        
                        let myEventsVC = self.storyboard!.instantiateViewController(withIdentifier: "MyEventsView") as! MyEventsTableViewController
                        
                        myEventsVC.events = array
                        
                        self.navigationController?.pushViewController(myEventsVC, animated:
                            true)
                    }
                    
                    myAlert.addAction(okAction)
                    
                    self.present(myAlert, animated: true, completion: nil)
                }
                
                
            case let .failureLogin(error) :
                print("Failed to Save New Event \(error)")
                
                self.displayMyAlertMessage(userMessage: "Unable to Save Event.  Try Again.")
                
                
            case let .failure(error) :
                print("Failed to Save New Event \(error)")
                
                self.displayMyAlertMessage(userMessage: "Unable to Save Event.  Try Again.")
                
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        
        if pickerView == statePicker {
            count = states.count
        }
        
        if pickerView == typePicker {
            count = types.count
        }
        
        return count
    }
    
    // Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var show: String?
        
        if pickerView == self.statePicker {
            show = states[row]
        }
        
        if pickerView == self.typePicker {
            show = types[row]
        }
        return show
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        if pickerView == statePicker {
            state = self.states[row]
        }
        
        if pickerView == typePicker {
            type = self.types[row]
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Event"
        
        if !isUserLoggedIn {
            let acNoNetwork = UIAlertController(title: "Must Login to Add Event", message: nil, preferredStyle: .alert)
            
            acNoNetwork.addAction(UIAlertAction(title: "OK", style: .default, handler: self.mustLogin))
            
            self.present(acNoNetwork, animated: true)
        }
        
        if isUserLoggedIn {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title:
                "Save", style: .plain, target: self, action:
                #selector(saveButtonTapped))
        }
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        
        
        
        startFormatter.dateStyle = .medium
        startFormatter.timeStyle = .short
        endFormatter.dateStyle = .medium
        endFormatter.timeStyle = .short
        
        
        startButton.setTitle("\(self.startFormatter.string(from: self.startDate))", for: .normal)
        endButton.setTitle("\(self.endFormatter.string(from: self.endDate))", for: .normal)
        
        
        statePicker.delegate = self
        statePicker.dataSource = self
        typePicker.delegate = self
        typePicker.dataSource = self
        
        nameField.text = name
        hostField.text = host
        locationField.text = location
        addressField.text = address
        cityField.text = city
        zipField.text = zipString
        
        
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



