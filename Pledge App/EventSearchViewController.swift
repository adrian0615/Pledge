//
//  EventSearchViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EventSearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let types = ["ALL TYPES", "Arts & Culture", "Activism", "Animal Rights", "Civil Rights", "Community Improvement", "Disaster Relief", "Disability Assistance", "Education", "Elderly Assistance", "Environmental", "Feeding the Less Fortunate", "Housing & Shelter", "Human Rights", "Human Services", "Mental Health", "Public Health", "Public Safety", "Transportation", "Youth Development"]
    
    var type: String = " "
    var events: [Event] = []

    
    
    @IBOutlet var zipField: UITextField!
    @IBOutlet var typePicker: UIPickerView!
    
    
  
    @IBAction func searchButtonTapped(_ sender: Any) {
        var zipResults: [Event] = []
        var typeResults: [Event] = []
        var eventResults: [Event] = []
        
        if zipField.text?.isEmpty == true {
            for result in events {
                if result.type == type {
                    typeResults.append(result)
                    eventResults = typeResults
                }
            }
        } else if type == "ALL TYPES" || type == " " {
            for result in events {
                if result.zip == Int(zipField.text!)! {
                    zipResults.append(result)
                    eventResults = zipResults
                }
            }
        } else {
            for result in self.events {
                if result.zip == Int(self.zipField.text!)! {
                    zipResults.append(result)
                }
                for result in zipResults {
                    if result.type == self.type {
                        eventResults.append(result)
                    }
                }
        }
        }
    
        if eventResults == [] {
            displayMyAlertMessage(userMessage: "No Results Found")
            return
        }
        OperationQueue.main.addOperation {
        
        let eventResultsVC = self.storyboard!.instantiateViewController(withIdentifier: "EventResultsView") as! EventResultsTableViewController
        
        eventResultsVC.events = eventResults
        
        self.navigationController?.pushViewController(eventResultsVC, animated:
            true)
            
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search Events"
        
        typePicker.delegate = self
        typePicker.dataSource = self
        
        navigationController?.navigationBar.tintColor = UIColor.white
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        
        return types.count
    }
    
    // Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return types[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        type = self.types[row]
        
    }
    

    

}
